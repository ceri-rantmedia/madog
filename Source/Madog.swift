//
//  Madog.swift
//  Madog
//
//  Created by Ceri Hughes on 02/12/2018.
//  Copyright © 2019 Ceri Hughes. All rights reserved.
//

import UIKit

public final class Madog<Token>: MadogUIContainerDelegate {
    private let registry = ViewControllerRegistry()
    private let registrar: Registrar
    private let factory: MadogUIContainerFactory<Token>

    private var currentContextUI: MadogUIContainer<Token>?

    public init() {
        registrar = Registrar(registry: registry)
        factory = MadogUIContainerFactory<Token>(registry: registry)
    }

    public func resolve(resolver: Resolver, launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        registrar.resolve(resolver: resolver, launchOptions: launchOptions)
    }

    public func addSingleUICreationFunction(identifier: String, function: @escaping () -> MadogSingleUIContainer<Token>) -> Bool {
        return factory.addSingleUICreationFunction(identifier: identifier, function: function)
    }

    public func addMultiUICreationFunction(identifier: String, function: @escaping () -> MadogMultiUIContainer<Token>) -> Bool {
        return factory.addMultiUICreationFunction(identifier: identifier, function: function)
    }

    public var currentContext: Context? {
        return currentContextUI
    }

    // MARK: - MadogUIContextDelegate

    public func renderUI<VC: UIViewController>(identifier: SingleUIIdentifier<VC>, token: Any, in window: UIWindow) -> Bool {
        guard let token = token as? Token,
            let contextUI = factory.createSingleUI(identifier: identifier),
            contextUI.renderInitialView(with: token) == true else {
                return false
        }

        contextUI.delegate = self
        currentContextUI = contextUI

        guard let viewController = contextUI.viewController as? VC else {
            return false
        }
        identifier.customisation(viewController)

        window.rootViewController = viewController
        return true
    }

    public func renderUI<VC: UIViewController>(identifier: MultiUIIdentifier<VC>, tokens: [Any], in window: UIWindow) -> Bool {
        guard let tokens = tokens as? [Token],
            let contextUI = factory.createMultiUI(identifier: identifier),
            contextUI.renderInitialViews(with: tokens) == true else {
                return false
        }

        contextUI.delegate = self
        currentContextUI = contextUI

        guard let viewController = contextUI.viewController as? VC else {
            return false
        }
        identifier.customisation(viewController)

        window.rootViewController = viewController
        return true
    }
}
