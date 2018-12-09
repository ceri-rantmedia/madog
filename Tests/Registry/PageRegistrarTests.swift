import XCTest

@testable import Madog

class PageRegistrarTests: XCTestCase {

    // MARK: CUT
    private var pageRegistrar: PageRegistrar!

    // MARK: Test Data
    private var resolver: TestResolver!
    private var registry: ViewControllerRegistry!

    override func setUp() {
        super.setUp()
        let testPageTypes: [Page.Type] = [TestPage.self, TestPageAndState.self]
        let testStateTypes: [State.Type] = [TestState.self, TestPageAndState.self]
        resolver = TestResolver(testPageTypes: testPageTypes, testStateTypes: testStateTypes)
        registry = ViewControllerRegistry()
        pageRegistrar = PageRegistrar(resolver: resolver)
    }

    override func tearDown() {
        pageRegistrar = nil
        super.tearDown()
    }

    func testLoadState() {
        TestState.created = false
        TestPageAndState.createdState = false

        XCTAssertEqual(pageRegistrar.states.count, 0)
        pageRegistrar.loadState()

        // Both factories create a state object with the same name, so we only get 1 object
        XCTAssertEqual(pageRegistrar.states.count, 1)

        XCTAssertTrue(TestState.created)
        XCTAssertTrue(TestPageAndState.createdState)
    }

    func testRegisterAndUnregisterPages() {
        TestPage.created = false
        TestPageAndState.createdPage = false

        XCTAssertEqual(pageRegistrar.pages.count, 0)
        pageRegistrar.registerPages(with: registry)
        XCTAssertEqual(pageRegistrar.pages.count, 2)

        XCTAssertTrue(TestPage.created)
        XCTAssertTrue(TestPageAndState.createdPage)

        for page in pageRegistrar.pages {
            let testPage = page as! TestPageProtocol
            XCTAssertTrue(testPage.registered)
            XCTAssertFalse(testPage.unregistered)
        }

        pageRegistrar.unregisterPages(from: registry)
        XCTAssertEqual(pageRegistrar.pages.count, 0)

        for page in pageRegistrar.pages {
            let testPage = page as! TestPageProtocol
            XCTAssertTrue(testPage.registered)
            XCTAssertTrue(testPage.unregistered)
        }
    }
}
