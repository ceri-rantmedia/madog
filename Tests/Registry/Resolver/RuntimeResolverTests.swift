import XCTest

@testable import Madog

class RuntimeResolverTests: XCTestCase {

    // MARK: CUT
    private var resolver: RuntimeResolver!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: RuntimeResolverTests.self)
        resolver = RuntimeResolver(bundle: bundle)
    }

    override func tearDown() {
        resolver = nil
        super.tearDown()
    }

    func testNumberOfPageTypes() {
        // Only classes are considered at the moment
        XCTAssertEqual(resolver.pageTypes().count, 2)
    }

    func testNumberOfStateTypes() {
        // Only classes are considered at the moment
        XCTAssertEqual(resolver.stateTypes().count, 2)
    }
}
