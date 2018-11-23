//
//  NavigationUI.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import UIKit

public typealias NavigationUIContext = NavigationContext & ForwardNavigationContext

/// A class that presents view controllers, and manages the navigation between them.
///
/// At the moment, this is achieved with a UINavigationController that can be pushed / popped to / from.
public class NavigationUI<Token>: NavigationUIContext {
    private let registry = Registry<Token, NavigationUIContext, UIViewController>()
    private let navigationController = UINavigationController()

    public init?(pageResolver: PageResolver) {
        let pageFactories = pageResolver.pageFactories()
        for pageFactory in pageFactories {
            let page = pageFactory.createPage()
            page.register(with: registry)
        }

        guard let initialViewControllers = registry.createGlobalResults(context: self),
            let initialViewController = initialViewControllers.first else {
            return nil
        }

        if initialViewControllers.count > 1 {
            print("Warning: More than 1 initial registry function is registered. There are no guarantees about which will be used.")
        }

        navigationController.pushViewController(initialViewController, animated: false)
    }

    public var initialViewController: UIViewController {
        return navigationController
    }

    // MARK: NavigationContext

    public func openModal<ContextToken>(with token: ContextToken, from fromViewController: UIViewController, animated: Bool) -> NavigationToken? {
        return nil
    }

    // MARK: ForwardNavigationContext

    public func navigate<ContextToken>(with token: ContextToken, from fromViewController: UIViewController, animated: Bool) -> NavigationToken? {
        guard let token = token as? Token, let viewController = registry.createResult(from: token, context: self) else {
            return nil
        }

        navigationController.pushViewController(viewController, animated: animated)
        return NavigationTokenImplementation(viewController: viewController)
    }
}
