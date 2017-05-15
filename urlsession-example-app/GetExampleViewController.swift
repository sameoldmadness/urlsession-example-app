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
        let url = URL(string: "http://localhost:8080/public/apple.jpg")!

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in

            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }

        task.resume()
    }
}
