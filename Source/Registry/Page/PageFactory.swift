//
//  PageFactory.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Foundation

public protocol PageFactory {
    associatedtype Token

    func createPage() -> AnyPage<Token>
}

public class AnyPageFactory<Token>: PageFactory {
    private let _createPage: () -> AnyPage<Token>

    public init<PF: PageFactory>(_ pageFactory: PF) where PF.Token == Token {
        _createPage = pageFactory.createPage
    }

    public func createPage() -> AnyPage<Token> {
        return _createPage()
    }
}
