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

    @IBAction func buttonClicked(_ sender: Any) {
        let message = textField.text!

        sendMessage(message)
    }

    var session: URLSession!

    override func viewDidLoad() {
        session = URLSession(configuration: .default)

        loadMessages()
    }

    func sendMessage(_ message: String) {
        let url = URL(string: "http://localhost:8080/message")!
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["message": message])

        let task = session.dataTask(with: request) {
            data, response, error in

            self.loadMessages()
        }

        task.resume()
    }

    func loadMessages() {
        let url = URL(string: "http://localhost:8080/messages")!

        let task = session.dataTask(with: url) {
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
