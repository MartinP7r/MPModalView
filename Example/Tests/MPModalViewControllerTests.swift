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

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSUT()
    }

    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Setup

    func setupSUT() {
        sut = MPModalViewController(actionButtons: [], contentView: .text(title: "A", body: "B"))
        let navCon = UINavigationController(rootViewController: UIViewController())
        window.rootViewController = navCon
    }

    func loadView() {
        // MARK: Calls ViewDidLoad
//        _ = sut.view
//        RunLoop.current.run(until: Date())
//        sut.view.setNeedsLayout()
//        sut.view.layoutIfNeeded()
        // MARK: Calls ViewWillAppear
//        sut.beginAppearanceTransition(true, animated: false)
//        sut.endAppearanceTransition()
    }

    func currentViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }

    func testModal_isTopViewControllerWhenCalled() {
        sut.presentOnTop()
        eventually(timeout: 2) {
//        eventually {
            XCTAssertEqual(self.currentViewController(), self.sut)
        }


    }

}
