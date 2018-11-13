//
//  PopoverVC.swift
//  popover-view
//
//  Created by Pfundmair Martin on 2018-10-18.
//  Copyright © 2018 Disco Corporation. All rights reserved.
//

import UIKit

public class MPModalViewController: UIViewController {

    public enum ContentViewType { case
        text(title: String, body: String),
        custom(UIView)
    }

    // MARK: - Properties
    private var variableHeight: Bool

    // MARK: - View Elements
    public let contentView: UIView
    private let frameView = UIView()
    private let shadowView = UIView()
    private let stack = UIStackView()
    private let buttonStack = UIStackView()
    public private(set) var buttons: [ActionButton]

    // MARK: - Initialization
    public init(actionButtons: [ActionButton],
         contentView: ContentViewType,
         hasShadow: Bool = true,
         variableHeight: Bool = true) {
        self.buttons = actionButtons
        self.variableHeight = variableHeight

        switch contentView {
        case .custom(let view):
            self.contentView = view
        case .text(let title, let body):
            self.contentView = UIView()

            let lblTitle = UILabel()
            lblTitle.text = title
            lblTitle.numberOfLines = 0
            lblTitle.font = UIFont.boldSystemFont(ofSize: 17)
            lblTitle.textAlignment = .center
            lblTitle.setContentHuggingPriority(.defaultHigh, for: .vertical)

            let lblBody = UILabel()
            lblBody.numberOfLines = 0
            lblBody.font = UIFont.systemFont(ofSize: 15)
            lblBody.text = body
            lblBody.setContentHuggingPriority(.defaultHigh, for: .vertical)

            let stackView = UIStackView()
            stackView.addArrangedSubview(lblTitle)
            stackView.addArrangedSubview(lblBody)
            let fillerView = UIView()
            stackView.addArrangedSubview(fillerView)
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 5
            self.contentView.addSubview(stackView)
            stackView.fillSuperview(padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .clear
        if hasShadow {
            setupShadow()
        }
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: - ViewController LifeCycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overCurrentContext
        setupSubViews()
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: view) else { return }
        if !shadowView.frame.contains(location) {
            dismiss(animated: true)
        } else {

        }
    }

    /// Presents the modal view on top of everything else on the screen
    public func presentOnTop() {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel =  UIWindow.Level.alert + 1.0
        alertWindow.makeKeyAndVisible()

        alertWindow.rootViewController?.present(self,
                                                animated: true,
                                                completion: nil)
    }

    public func addActionButton(button: ActionButton) {
        buttons.append(button)
        buttonStack.addArrangedSubview(button)
    }

    public func removeActionButton(button: ActionButton) {
        guard let idx = buttons.index(of: button) else { return }
        buttonStack.removeArrangedSubview(button)
        buttons.remove(at: idx)
    }
}

// MARK: - Private Methods
fileprivate extension MPModalViewController {

    // MARK: View Setup
    func setupSubViews() {
        setupFrameAndShadowView()
        setupStackView()
    }

    func setupFrameAndShadowView() {
        shadowView.backgroundColor = .white
        view.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                          multiplier: 0.8).isActive = true
        shadowView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                           multiplier: 0.8).isActive = !variableHeight
        shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        frameView.layer.borderColor = UIColor.black.cgColor
        frameView.layer.borderWidth = 1
        frameView.layer.cornerRadius = 8
        frameView.layer.masksToBounds = true

        shadowView.addSubview(frameView)
        frameView.fillSuperview()
    }

    func setupStackView() {
        for button in buttons {
            buttonStack.addArrangedSubview(button)
            if let ttype = button.type {
                switch ttype {
                case .cancel:
                    button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
                default: break
                }
            }
        }

        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 0

        stack.addArrangedSubview(contentView)
        stack.addArrangedSubview(buttonStack)

        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 0

        frameView.addSubview(stack)
        stack.fillSuperview()
    }

    func setupShadow() {
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
