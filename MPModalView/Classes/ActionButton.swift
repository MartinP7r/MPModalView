//
//  ActionButton.swift
//  popover-view
//
//  Created by Pfundmair Martin on 2018-10-18.
//  Copyright © 2018 Disco Corporation. All rights reserved.
//

import UIKit

public class ActionButton: UIButton {

    private let callback: (() -> ())?
    var type: ActionButtonType?

    public enum ActionButtonType { case
        ok,
        cancel,
        basic(title: String),
        custom(title: String, bgColor: UIColor)
    }

    private let bgColor: UIColor

    public override init(frame: CGRect) {
        bgColor = .white
        callback = nil
        super.init(frame: frame)
        setupView()
    }

    public init(frame: CGRect = .zero,
         title: String,
         bgColor: UIColor,
         _ callback: @escaping () -> Void = { }) {
        self.bgColor = bgColor
        self.callback = callback
        super.init(frame: frame)
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        setupView()
        setupCallback()
    }

    public convenience init(type buttonType: ActionButtonType, _ callback: @escaping () -> Void = { }) {
        switch buttonType {
        case .ok:
            self.init(title: "OK", bgColor: .blue, callback)
        case .cancel:
            self.init(title: "Cancel", bgColor: .red, callback)
        case .basic(let title):
            self.init(title: title, bgColor: .blue, callback)
        case .custom(let title, let bgColor):
            self.init(title: title, bgColor: bgColor, callback)
        }
        self.type = buttonType
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    private func setupView() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.0
        titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 15)

        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
    }

    private func setupCallback() {
        addTarget(self, action: #selector(callAction(sender:)), for: .touchUpInside)
    }

    @objc func callAction(sender: UIButton) {
        callback?()
    }
}
