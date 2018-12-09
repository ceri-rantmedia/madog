import XCTest

@testable import Madog

class PageRegistrarTests: XCTestCase {

    // MARK: CUT
    private var pageRegistrar: PageRegistrar<String>!

    // MARK: Test Data
    private var resolver: TestResolver!
    private var registry: ViewControllerRegistry!

    override func setUp() {
        super.setUp()
        let testPageCreationFunctions: [() -> AnyPage<String>] = [TestPageFactory.createPage, TestPageAndStateFactory.createPage]
        let testStateCreationFunctions: [() -> State] = [TestStateFactory.createState, TestPageAndStateFactory.createState]
        resolver = TestResolver(testPageCreationFunctions: testPageCreationFunctions,
                                testStateCreationFunctions: testStateCreationFunctions)
        registry = ViewControllerRegistry()
        pageRegistrar = PageRegistrar(resolver: AnyResolver(resolver))
    }

    override func tearDown() {
        pageRegistrar = nil
        super.tearDown()
    }

    func testLoadState() {
        TestStateFactory.created = false
        TestPageAndStateFactory.createdState = false

        XCTAssertEqual(pageRegistrar.states.count, 0)
        pageRegistrar.loadState()

        // Both factories create a state object with the same name, so we only get 1 object
        XCTAssertEqual(pageRegistrar.states.count, 1)

        XCTAssertTrue(TestStateFactory.created)
        XCTAssertTrue(TestPageAndStateFactory.createdState)
    }

    func testRegisterAndUnregisterPages() {
        TestPageFactory.created = false
        TestPageAndStateFactory.createdPage = false

        XCTAssertEqual(pageRegistrar.pages.count, 0)
        pageRegistrar.registerPages(with: registry)
        XCTAssertEqual(pageRegistrar.pages.count, 2)

        XCTAssertTrue(TestPageFactory.created)
        XCTAssertTrue(TestPageAndStateFactory.createdPage)
    }
}
