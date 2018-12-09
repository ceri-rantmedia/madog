//
//  Page1.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Madog
import UIKit

fileprivate let page1Identifier = "page1Identifier"

class Page1Factory: PageFactory {

    // MARK: PageFactory

    func createPage() -> AnyPage<ResourceLocator> {
        return AnyPage<ResourceLocator>(Page1())
    }
}

class Page1: Page {
    typealias Token = ResourceLocator

    private var state1: State1?
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
        state1 = state[state1Name] as? State1
    }

    // MARK: Private

    private func createViewController(token: Any, context: Context) -> UIViewController? {
        guard let state1 = state1,
            let rl = token as? ResourceLocator,
            rl.identifier == page1Identifier,
            let navigationContext = context as? ForwardBackNavigationContext else {
                return nil
        }

        let viewController =  Page1ViewController(state1: state1, navigationContext: navigationContext)
        viewController.tabBarItem = UITabBarItem.init(tabBarSystemItem: .bookmarks, tag: 0)
        return viewController
    }
}

extension ResourceLocator {
    static func createPage1ResourceLocator() -> ResourceLocator {
        return ResourceLocator(identifier: page1Identifier, data: [:])
    }
}
