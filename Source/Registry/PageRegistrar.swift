//
//  PageRegistrar.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Foundation

/// A class that presents view controllers, and manages the navigation between them.
internal class PageRegistrar<Token> {
    private let resolver: AnyResolver<Token>
    internal var states = [String:State]()
    internal var pages = [AnyPage<Token>]()

    internal init(resolver: AnyResolver<Token>) {
        self.resolver = resolver
    }

    internal func loadState() {
        let stateFactories = resolver.stateFactories()
        for stateFactory in stateFactories {
            let state = stateFactory.createState()
            let name = state.name
            states[name] = state
        }
    }

    internal func registerPages(with registry: ViewControllerRegistry) {
        let pageFactories = resolver.pageFactories()
        for pageFactory in pageFactories {
            let page = pageFactory.createPage()
            page.register(with: registry)
            page.configure(with: states)
            pages.append(AnyPage(page))
        }
    }

    internal func unregisterPages(from registry: ViewControllerRegistry) {
        for page in pages {
            page.unregister(from: registry)
        }
        pages.removeAll()
    }
}
