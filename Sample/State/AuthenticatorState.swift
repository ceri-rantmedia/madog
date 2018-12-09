//
//  AuthenicatorState.swift
//  Madog
//
//  Created by Ceri Hughes on 24/11/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import Foundation
import Madog

let authenticatorStateName = "authenicatorStateName"

class AuthenticatorStateFactory: StateFactory {

    // MARK: StateFactory

    func createState() -> State {
        return AuthenticatorState()
    }
}

class AuthenticatorState: State {
    let authenticator = Authenticator()

    // MARK: State

    let name = authenticatorStateName
}

class Authenticator {
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(true)
        }
    }

    func logout(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(true)
        }
    }
}
