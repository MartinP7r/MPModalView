//
//  MPModalViewControllerTests.swift
//  MPModalView_Tests
//
//  Created by Martin Pfundmair on 2018-11-08.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import MPModalView

class MPModalViewControllerTests: XCTestCase {

    var sut: MPModalViewController!
    var window: UIWindow!

    var buttonA: ActionButton!
    var buttonB: ActionButton!
    var customView: UILabel!

    var buttonACallbackCount: Int!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        buttonACallbackCount = 0
        buttonA = ActionButton(type: .basic(title: "A")) {
            self.buttonACallBackMock()
        }
        customView = UILabel()
        buttonB = ActionButton(type: .custom(title: "B", bgColor: .green))

        setupSUT()
    }

    override func tearDown() {
        window = nil
        sut = nil
        buttonACallbackCount = nil
        buttonA = nil
        buttonB = nil
        customView = nil
        super.tearDown()
    }

    func buttonACallBackMock() {
        buttonACallbackCount += 1
    }

    // MARK: - Test Setup

    func setupSUT() {
        sut = MPModalViewController(actionButtons: [buttonA, buttonB],
                                    contentView: .custom(customView))
        let navCon = UINavigationController(rootViewController: UIViewController())
        window.rootViewController = navCon
    }

    func visibleViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
    }

    func testModal_isTopViewControllerWhenCalled() {
        XCTAssertNotEqual(visibleViewController(), sut)
        sut.presentOnTop()
        XCTAssertEqual(visibleViewController(), sut)

    }

    func testModal_containsCustomView() {
        XCTAssertEqual(sut.contentView, customView)
    }

    func testModal_containsButtons() {
        let btnA = sut.view.findButton(withText: "A")
        let btnB = sut.view.findButton(withText: "B")

        XCTAssertNotNil(btnA)
        XCTAssertNotNil(btnB)
    }

    func testModal_buttonATap() {
        let btnA = sut.view.findButton(withText: "A")
        XCTAssertEqual(buttonACallbackCount, 0)
        btnA?.tap()
        XCTAssertEqual(buttonACallbackCount, 1)
    }

}
