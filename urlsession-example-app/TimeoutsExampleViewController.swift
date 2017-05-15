//
//  TimeoutsExampleViewController.swift
//  urlsession-example-app
//
//  Created by Roman Paradeev on 15.05.17.
//  Copyright © 2017 Roman Paradeev. All rights reserved.
//

import UIKit

class TimeoutsExampleViewController: UIViewController {
    @IBOutlet var status: UILabel!

    var session: URLSession!
    var task: URLSessionTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = URLSessionConfiguration.default

//        configuration.timeoutIntervalForRequest
        configuration.timeoutIntervalForResource = 5

        session = URLSession(configuration: configuration)
    }

    @IBAction func ping(_ sender: Any) {
        task?.cancel()

        status.text = "pending"

        let url = URL(string: "http://localhost:8080/ping")!


        task = session.dataTask(with: url) {
            data, response, error in

            DispatchQueue.main.async {
                if let error = error {
                    self.status.text = error.localizedDescription
                } else {
                    self.status.text = String(data: data!, encoding: .utf8)
                }
            }
        }

        task?.resume()
    }
}
