//
//  ScreenshotDetailViewController.swift
//  MapDemo
//
//  Created by CoderDream on 2019/3/14.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ScreenshotDetailViewController: UIViewController {
    var screenshotImage : UIImage?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.view.backgroundColor = UIColor.black
        self.initImageView()
    }
    
    @objc func backAction() {
        self.dismiss(animated: true) // , completion: { _ in }
    }
    
    // MARK: - Initialization
    func initNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.backAction))
    }
    
    func initImageView() {
        let imageView = UIImageView(image: self.screenshotImage)
        imageView.center = CGPoint(x: CGFloat(self.view.bounds.midX), y: CGFloat(self.view.bounds.midY))
        imageView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        self.view.addSubview(imageView)
    }
}
