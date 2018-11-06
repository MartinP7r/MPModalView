//
//  ViewController.swift
//  MPModalView
//
//  Created by cyrus86 on 11/06/2018.
//  Copyright (c) 2018 cyrus86. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let popOver = PopoverVC(actionButtons: [ActionButton(type: .basic(title: "Bla")), ActionButton(type: .cancel),ActionButton(type: .basic(title: "Blu"))], contentView: .text(title: "A", body: "B"))

        popOver.presentOnTop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

