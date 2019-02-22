//
//  ViewController.swift
//  UIImageDemo01
//
//  Created by CoderDream on 2019/2/21.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageV = UIImageView(frame: CGRect(x: 90, y: 200, width: 200, height: 200))
        imageV.layer.borderWidth = 5
        imageV.layer.borderColor = UIColor.red.cgColor
        imageV.dowloadFromServer(link:
            "http://i.imgur.com/w5rkSIj.jpg",
                                 contentMode: .scaleAspectFill)
        self.view.addSubview(imageV)
    }
}


extension UIImageView {
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode)
    }
}

