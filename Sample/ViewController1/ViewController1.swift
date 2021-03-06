//
//  ViewController1.swift
//  MadogSample
//
//  Created by Ceri Hughes on 23/11/2018.
//  Copyright © 2019 Ceri Hughes. All rights reserved.
//

import Madog
import UIKit

class ViewController1: UIViewController {
    private let sharedService: Any
    private weak var navigationContext: ForwardBackNavigationContext?
    private var pushCount = 0

    init(sharedService: Any, navigationContext: ForwardBackNavigationContext) {
        self.sharedService = sharedService
        self.navigationContext = navigationContext

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ButtonView()
    }

    override func viewDidLoad() {
        guard let view = view as? ButtonView else {
            return
        }

        view.button.setTitle("Push", for: .normal)
        view.button.addTarget(self, action: #selector(buttonTapGesture(sender:)), for: .touchUpInside)
    }
}

extension ViewController1 {

    // MARK: UIButton interactions

    @objc
    private func buttonTapGesture(sender: UIButton) {
        pushCount += 1
        let token = SampleToken.createVC2Identifier(stringData: String(pushCount))
        _ = self.navigationContext?.navigateForward(token: token, animated: true)
    }
}
