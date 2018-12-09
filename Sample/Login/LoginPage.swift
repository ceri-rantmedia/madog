//
//  LoginPage.swift
//  Madog
//
//  Created by Ceri Hughes on 02/12/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Madog
import UIKit

fileprivate let loginPageIdentifier = "loginPageIdentifier"

class LoginPageFactory: PageFactory {

    // MARK: PageFactory

    func createPage() -> AnyPage<ResourceLocator> {
        return AnyPage<ResourceLocator>(LoginPage())
    }
}

class LoginPage: Page {
    typealias Token = ResourceLocator

    private var authenticatorState: AuthenticatorState?
    private var uuid: UUID?

    // MARK: Page

    func register(with registry: ViewControllerRegistry) {
        uuid = registry.add(registryFunction: createViewController(token:context:))
    }

    func unregister(from registry: ViewControllerRegistry) {
        guard let uuid = uuid else {
            return
        }

        registry.removeRegistryFunction(uuid: uuid)
    }

    func configure(with state: [String : State]) {
        authenticatorState = state[authenticatorStateName] as? AuthenticatorState
    }

    // MARK: Private

    private func createViewController(token: Any, context: Context) -> UIViewController? {
        guard let rl = token as? ResourceLocator,
            rl.identifier == loginPageIdentifier,
            let authenticator = authenticatorState?.authenticator,
            let navigationContext = context as? Context & ForwardBackNavigationContext else {
                return nil
        }

        return LoginViewController.createLoginViewController(authenticator: authenticator, navigationContext: navigationContext)
    }
}

extension ResourceLocator {
    static func createLoginPageResourceLocator() -> ResourceLocator {
        return ResourceLocator(identifier: loginPageIdentifier, data: [:])
    }
}
