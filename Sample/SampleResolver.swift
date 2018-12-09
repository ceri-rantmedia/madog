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
    func pageFactories() -> [AnyPageFactory<ResourceLocator>] {
        return [
            AnyPageFactory(LoginPageFactory()),
            AnyPageFactory(Page1Factory()),
            AnyPageFactory(Page2Factory()),
            AnyPageFactory(LogoutPageFactory())
        ]
    }

    func stateFactories() -> [StateFactory] {
        return [
            State1Factory(),
            AuthenticatorStateFactory()
        ]
    }
}
