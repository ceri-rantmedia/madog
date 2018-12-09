//
//  SampleResolver.swift
//  Madog
//
//  Created by Ceri Hughes on 09/12/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Foundation
import Madog

class SampleResolver: Resolver {
    func pageCreationFunctions() -> [() -> AnyPage<ResourceLocator>] {
        return [
            { return AnyPage(LoginPage()) },
            { return AnyPage(Page1()) },
            { return AnyPage(Page2()) },
            { return AnyPage(LogoutPage()) }
        ]
    }
    func stateCreationFunctions() -> [() -> State] {
        return [
            { return State1() },
            { return AuthenticatorState() }
        ]
    }
}
