import Foundation
import Madog

class TestResolver: Resolver {
    private let testPageCreationFunctions: [() -> AnyPage<String>]
    private let testStateCreationFunctions: [() -> State]

    init(testPageCreationFunctions: [() -> AnyPage<String>], testStateCreationFunctions: [() -> State]) {
        self.testPageCreationFunctions = testPageCreationFunctions
        self.testStateCreationFunctions = testStateCreationFunctions
    }

    func pageCreationFunctions() -> [() -> AnyPage<String>] {
        return testPageCreationFunctions
    }

    func stateCreationFunctions() -> [() -> State] {
        return testStateCreationFunctions
    }
}
