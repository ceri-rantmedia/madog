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
        let stateFactoryTypes = resolver.stateFactoryTypes()
        for stateFactoryType in stateFactoryTypes {
            let state = stateFactoryType.createState()
            let name = state.name
            states[name] = state
        }
    }

    internal func registerPages(with registry: ViewControllerRegistry) {
        let pageFactoryTypes = resolver.pageFactoryTypes()
        for pageFactoryType in pageFactoryTypes {
            let page = pageFactoryType.createPage()
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
