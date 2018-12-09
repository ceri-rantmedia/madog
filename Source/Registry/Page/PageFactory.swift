//
//  PageFactory.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Foundation

open class PageFactory<Token> {
    static func createPage() -> AnyPage<Token> {
        return AnyPage(DummyPage())
    }
}

private class DummyPage<Token>: Page {
    func configure(with state: [String : State]) {}
    func register(with registry: ViewControllerRegistry) {}
    func unregister(from registry: ViewControllerRegistry) {}
}
