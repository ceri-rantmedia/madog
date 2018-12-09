//
//  Page.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Foundation

/// A protocol that describes a page that wants to provide a VC (or a number of VCs) for a given token by registering
/// with a ViewControllerRegistry.
public protocol Page {
    associatedtype Token

    func register(with registry: ViewControllerRegistry)
    func unregister(from registry: ViewControllerRegistry)
    func configure(with state: [String:State])
}

public class AnyPage<Token>: Page {
    private let _configure: ([String:State]) -> Void
    private let _register: (ViewControllerRegistry) -> Void
    private let _unregister: (ViewControllerRegistry) -> Void

    public init<P: Page>(_ page: P) where P.Token == Token {
        _configure = page.configure
        _register = page.register
        _unregister = page.unregister
    }

    public func configure(with state: [String : State]) {
        _configure(state)
    }

    public func register(with registry: ViewControllerRegistry) {
        _register(registry)
    }

    public func unregister(from registry: ViewControllerRegistry) {
        _unregister(registry)
    }
}
