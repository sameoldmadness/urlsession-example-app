//
//  GetExampleViewController.swift
//  urlsession-example-app
//
//  Created by Roman Paradeev on 14.05.17.
//  Copyright © 2017 Roman Paradeev. All rights reserved.
//

import UIKit

class GetExampleViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    @IBAction func buttonClicked(_ sender: Any) {
        let img = "http://localhost:8080/public/apple.jpg"
    }
}
