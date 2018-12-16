//
//  TabBarNavigationUI.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import UIKit

internal protocol TabBarNavigationContext: Context, ModalContext, ForwardBackNavigationContext {}

/// A class that presents view controllers in a tab bar, and manages the navigation between them.
///
/// At the moment, this is achieved with a UINavigationController that can be pushed / popped to / from.
internal class TabBarNavigationUI<Token>: MadogMultiPageUIContext<Token>, TabBarNavigationContext {
    private let tabBarController = UITabBarController()

    internal init() {
        super.init(viewController: tabBarController)
    }

    // MARK: - MadogMultiPageUIContext

    override internal func renderInitialViews(with tokens: [Token]) -> Bool {
        let viewControllers = tokens.compactMap { registry.createViewController(from: $0, context: self) }
            .map { UINavigationController(rootViewController: $0) }

        tabBarController.viewControllers = viewControllers
        return true
    }

    // MARK: - ModalContext

    func presentModal(with token: Any, presentationStyle: UIModalPresentationStyle, animated: Bool) -> NavigationToken? {
        guard let viewController = registry.createViewController(from: token, context: self) else {
            return nil
        }

        tabBarController.modalPresentationStyle = presentationStyle
        tabBarController.present(viewController, animated: animated, completion: nil)
        return createNavigationToken(for: viewController)
    }

    func dismissModal(animated: Bool) -> Bool? {
        if tabBarController.presentedViewController == nil {
            return false
        }

        tabBarController.dismiss(animated: animated, completion: nil)
        return true
    }

    // MARK: - ForwardBackNavigationContext

    internal func navigateForward(with token: Any, animated: Bool) -> NavigationToken? {
        guard let toViewController = registry.createViewController(from: token, context: self),
            let navigationController = tabBarController.selectedViewController as? UINavigationController else {
                return nil
        }

        navigationController.pushViewController(toViewController, animated: animated)
        return createNavigationToken(for: viewController)
    }

    internal func navigateBack(animated: Bool) -> Bool {
        guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {
            return false
        }

        return navigationController.popViewController(animated: animated) != nil
    }

    internal func navigateBackToRoot(animated: Bool) -> Bool {
        guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {
            return false
        }

        return navigationController.popToRootViewController(animated: true) != nil
    }

}
