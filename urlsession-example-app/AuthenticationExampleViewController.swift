//
//  AuthenticationExampleViewController.swift
//  urlsession-example-app
//
//  Created by Roman Paradeev on 15.05.17.
//  Copyright © 2017 Roman Paradeev. All rights reserved.
//

import UIKit

class AuthenticationExampleViewController: UIViewController {
    @IBOutlet var label: UILabel!
    var session: URLSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = URLSessionConfiguration.default

        session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
    }

    @IBAction func revealSecret(_ sender: Any) {
        let url = URL(string: "http://localhost:8080/secret")!
        let task = session.dataTask(with: url)

        task.resume()
    }
}

extension AuthenticationExampleViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let credential = URLCredential(user: "admin", password: "password", persistence: .none)

        completionHandler(.useCredential, credential)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        label.text = String(data: data, encoding: .utf8)
    }
}
