//
//  PostExampleViewController.swift
//  urlsession-example-app
//
//  Created by Roman Paradeev on 14.05.17.
//  Copyright © 2017 Roman Paradeev. All rights reserved.
//

import UIKit

class PostExampleViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UITextView!

    @IBAction func send() {
        let message = textField.text!
        let url = URL(string: "http://localhost:8080/message")!
    }

    @IBAction func reload() {
        let url = URL(string: "http://localhost:8080/messages")!

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in

            if let data = data,
                let messages = try? JSONSerialization.jsonObject(with: data) as? [String] {

                DispatchQueue.main.async {
                    self.label.text = messages?.joined(separator: "\n")
                }
            }
        }

        task.resume()
    }
}
