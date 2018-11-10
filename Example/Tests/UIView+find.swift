//
//  UIView+find.swift
//  MPModalView_Tests
//
//  Created by Martin Pfundmair on 2018-11-10.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {

    /// returns array of all subviews that are UILabel (recursively)
    func subLabels() -> [UILabel] {
        var labels = [UILabel]()
        subviews.forEach { v in
            if let v = v as? UILabel {
                labels.append(v)
            } else {
                labels += v.subLabels()
            }
        }
        return labels
    }

    func findButton(withText searchText: String) -> UIButton? {
        return subviews
            .compactMap { $0 as? UIButton ?? $0.findButton(withText: searchText) }
            .filter { $0.titleLabel?.text == searchText }
            .first
    }

    func find<T: UIView>(subViewWithIdentifier identifier: String) -> T? {
        return subviews
            .compactMap { $0.find(subViewWithIdentifier: identifier) ?? $0 }
            .filter { $0.accessibilityIdentifier == identifier }
            .first as? T
    }
}
