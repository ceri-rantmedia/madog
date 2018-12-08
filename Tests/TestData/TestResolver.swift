import Foundation
import Madog

class TestResolver: PageResolver, StateResolver {
    private let testPageTypes: [Page.Type]
    private let testStateTypes: [State.Type]

    init(testPageTypes: [Page.Type], testStateTypes: [State.Type]) {
        self.testPageTypes = testPageTypes
        self.testStateTypes = testStateTypes
    }

    func pageTypes() -> [Page.Type] {
        return testPageTypes
    }

    func stateTypes() -> [State.Type] {
        return testStateTypes
    }
}
