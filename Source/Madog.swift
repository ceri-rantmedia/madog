//
//  Madog.swift
//  Madog
//
//  Created by Ceri Hughes on 02/12/2018.
//  Copyright © 2019 Ceri Hughes. All rights reserved.
//

import Provident
import UIKit

public final class Madog<Token>: MadogUIContainerDelegate {
    private let registry = Registry<Token>()
    private let registrar: Registrar<Token, Context>
    private let factory: MadogUIContainerFactory<Token>

    private var currentContextUI: MadogUIContainer<Token>?

    public init() {
        registrar = Registrar(registry: registry)
        factory = MadogUIContainerFactory<Token>(registry: registry)
    }

    public func resolve(resolver: Resolver<Token>, launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        registrar.resolve(resolver: resolver, launchOptions: launchOptions)
    }

    @discardableResult
    public func addSingleUICreationFunction(identifier: String, function: @escaping () -> MadogSingleUIContainer<Token>) -> Bool {
        return factory.addSingleUICreationFunction(identifier: identifier, function: function)
    }

    @discardableResult
    public func addMultiUICreationFunction(identifier: String, function: @escaping () -> MadogMultiUIContainer<Token>) -> Bool {
        return factory.addMultiUICreationFunction(identifier: identifier, function: function)
    }

    public var currentContext: Context? {
        return currentContextUI
    }

    // MARK: - MadogUIContextDelegate

    @discardableResult
    public func renderUI<VC: UIViewController>(identifier: SingleUIIdentifier<VC>, token: Any, in window: UIWindow, transition: Transition? = nil) -> Context? {
        guard let token = token as? Token,
            let contextUI = factory.createSingleUI(identifier: identifier),
            contextUI.renderInitialView(with: token) == true else {
                return nil
        }

        contextUI.delegate = self
        currentContextUI = contextUI

        guard let viewController = contextUI.viewController as? VC else {
            return nil
        }
        identifier.customisation(viewController)

        window.setRootViewController(viewController, transition: transition)
        return contextUI
    }

    @discardableResult
    public func renderUI<VC: UIViewController>(identifier: MultiUIIdentifier<VC>, tokens: [Any], in window: UIWindow, transition: Transition? = nil) -> Context? {
        guard let tokens = tokens as? [Token],
            let contextUI = factory.createMultiUI(identifier: identifier),
            contextUI.renderInitialViews(with: tokens) == true else {
                return nil
        }

        contextUI.delegate = self
        currentContextUI = contextUI

        guard let viewController = contextUI.viewController as? VC else {
            return nil
        }
        identifier.customisation(viewController)

        window.setRootViewController(viewController, transition: transition)
        return contextUI
    }
}

extension UIWindow {
    func setRootViewController(_ viewController: UIViewController, transition: Transition?) {
		rootViewController = viewController

        if let transition = transition {
			UIView.transition(with: self, duration: transition.duration, options: transition.options, animations: {})
        }
    }
}
