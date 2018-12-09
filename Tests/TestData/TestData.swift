import Foundation
import Madog

protocol TestPageProtocol {
    var registered: Bool {get}
    var unregistered: Bool {get}
}

class TestPage: Page, TestPageProtocol {
    static var created = false
    var registered = false, unregistered = false
    var capturedState: [String:State]? = nil

    static func createPage() -> Page {
        created = true
        return TestPage()
    }

    func register(with registry: ViewControllerRegistry) { registered = true }
    func unregister(from registry: ViewControllerRegistry) { unregistered = true }
    func configure(with state: [String:State]) { capturedState = state }
}

class TestState: State {
    static var created = false
    let name = String(describing: TestState.self)

    static func createState() -> State {
        created = true
        return TestState()
    }
}

class TestPageAndState: Page, State, TestPageProtocol {
    private static let instance = TestPageAndState()
    static var createdPage = false
    static var createdState = false

    let name = String(describing: TestState.self)
    var registered = false, unregistered = false
    var capturedState: [String:State]? = nil

    static func createPage() -> Page {
        createdPage = true
        return instance
    }

    static func createState() -> State {
        createdState = true
        return instance
    }

    func register(with registry: ViewControllerRegistry) { registered = true }
    func unregister(from registry: ViewControllerRegistry) { unregistered = true }
    func configure(with state: [String:State]) { capturedState = state }
}
