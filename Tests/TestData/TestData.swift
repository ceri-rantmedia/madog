import Foundation
import Madog

class TestPage: Page {
    typealias Token = String

    var registered = false, unregistered = false
    var capturedState: [String:State]? = nil
    func register(with registry: ViewControllerRegistry) {
        registered = true
    }
    func unregister(from registry: ViewControllerRegistry) {
        unregistered = true
    }
    func configure(with state: [String:State]) {
        capturedState = state
    }
}

class TestState: State {
    let name = String(describing: TestState.self)
}

class TestPageFactory {
    static var created = false
    static func createPage() -> AnyPage<String> {
        created = true
        return AnyPage(TestPage())
    }
}

class TestStateFactory {
    static var created = false
    static func createState() -> State {
        created = true
        return TestState()
    }
}

class TestPageAndState: TestPage, State {
    let name = String(describing: TestState.self)
}


class TestPageAndStateFactory {
    static let testPageAndState = TestPageAndState()
    static var createdPage = false
    static func createPage() -> AnyPage<String> {
        createdPage = true
        return AnyPage(testPageAndState)
    }

    static var createdState = false
    static func createState() -> State {
        createdState = true
        return testPageAndState
    }
}
