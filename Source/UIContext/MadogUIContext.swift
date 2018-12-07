//
//  MadogUIContext.swift
//  Madog
//
//  Created by Ceri Hughes on 07/12/2018.
//  Copyright © 2018 Ceri Hughes. All rights reserved.
//

import UIKit

internal protocol MadogUIContextDelegate: class {
    func renderSinglePageUI(_ uiIdentifier: SinglePageUIIdentifier, with token: Any, in window: UIWindow) -> Bool
    func renderMultiPageUI(_ uiIdentifier: MultiPageUIIdentifier, with tokens: [Any], in window: UIWindow) -> Bool
}

internal protocol MadogUIContext {
    var delegate: MadogUIContextDelegate? {get set}
    var viewController: UIViewController {get}
}
