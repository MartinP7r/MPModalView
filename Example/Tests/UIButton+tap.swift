//
//  UIButton+tap.swift
//  MPModalView_Tests
//
//  Created by Martin Pfundmair on 2018-11-10.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension UIButton {
    func tap() {
        sendActions(for: .touchUpInside)
    }
}
