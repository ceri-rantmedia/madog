//
//  Resolver.swift
//  Madog
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import UIKit

/// Implementations of Resolver should return an array of all PageFactory and StateFactory instances.
///
/// At the moment, the only implementation is the RuntimeResolver which uses Runtime magic to find all loaded classes
/// that implement PageFactory and StateFactory.
///
/// This might not be a long term solution, especially if Swift moves away from the Obj-C runtime, but it does serve as
/// a nice example of accessing the Obj-C runtime from Swift.
///
/// Other implementations can be written that (e.g.) manually instantiate the required implementations, or maybe load
/// them via a plist.
public protocol Resolver {
    associatedtype Token

    func pageCreationFunctions() -> [() -> AnyPage<Token>]
    func stateCreationFunctions() -> [() -> State]
}

public class AnyResolver<Token>: Resolver {
    private let _pageCreationFunctions: () -> [() -> AnyPage<Token>]
    private let _stateCreationFunctions: () -> [() -> State]

    public init<R: Resolver>(_ resolver: R) where R.Token == Token {
        _pageCreationFunctions = resolver.pageCreationFunctions
        _stateCreationFunctions = resolver.stateCreationFunctions
    }

    public func pageCreationFunctions() -> [() -> AnyPage<Token>] {
        return _pageCreationFunctions()
    }

    public func stateCreationFunctions() -> [() -> State] {
        return _stateCreationFunctions()
    }
}
