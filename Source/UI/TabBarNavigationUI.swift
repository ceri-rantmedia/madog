//
//  TabBarNavigationUI.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import UIKit

public typealias TabBarNavigationUIContext = ModalContext & TabBarNavigationContext

/// A class that presents view controllers in a tab bar, and manages the navigation between them.
///
/// At the moment, this is achieved with a UINavigationController that can be pushed / popped to / from.
public class TabBarNavigationUI<Token>: BaseUI<Token, TabBarNavigationUIContext>, TabBarNavigationUIContext {
    private let tabBarController = UITabBarController()

    override public init?(pageResolver: PageResolver) {
        super.init(pageResolver: pageResolver)

        guard let initialViewControllers = registry.createGlobalResults(context: self),
            initialViewControllers.count > 0 else {
                return nil
        }

        tabBarController.viewControllers = initialViewControllers
    }

    public var initialViewController: UITabBarController {
        return tabBarController
    }

    // MARK: ModalContext

    public func openModal<ContextToken>(with token: ContextToken, from fromViewController: UIViewController, animated: Bool) -> NavigationToken? {
        return nil
    }

    // MARK: TabBarNavigationContext

    public func navigateForward<ContextToken>(with token: ContextToken, from fromViewController: UIViewController, animated: Bool) -> NavigationToken? {
        guard let token = token as? Token,
            let toViewController = registry.createResult(from: token, context: self),
            let navigationController = fromViewController.navigationController else {
            return nil
        }

        navigationController.pushViewController(toViewController, animated: animated)
        return NavigationTokenImplementation(viewController: toViewController)
    }

    public func navigateBack(animated: Bool) -> Bool {
        guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {
            return false
        }
        return navigationController.popViewController(animated: animated) != nil
    }
}
