//
//  GetExampleViewController.swift
//  urlsession-example-app
//
//  Created by Roman Paradeev on 14.05.17.
//  Copyright © 2017 Roman Paradeev. All rights reserved.
//

import UIKit

class CacheExampleViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    var session: URLSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = URLSessionConfiguration.default

        configuration.urlCache = URLCache.shared
        configuration.requestCachePolicy = .returnCacheDataElseLoad

//        configuration.allowsCellularAccess = False

        session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
    }

    @IBAction func clearCache(_ sender: Any) {
        session.configuration.urlCache!.removeAllCachedResponses()
    }

    @IBAction func buttonClicked(_ sender: Any) {
        let url = URL(string: "http://localhost:8080/public/apple.jpg")!

        let task = session.dataTask(with: url)

        task.resume()
    }
}

extension CacheExampleViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    willCacheResponse proposedResponse: CachedURLResponse,
                    completionHandler: @escaping (CachedURLResponse?) -> Void) {
        completionHandler(proposedResponse)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        imageView.image = UIImage(data: data)
    }
}
