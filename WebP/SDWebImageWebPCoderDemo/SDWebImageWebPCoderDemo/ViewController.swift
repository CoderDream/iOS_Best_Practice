//
//  ViewController.swift
//  SDWebImageWebPCoderDemo
//
//  Created by CoderDream on 2019/7/22.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import SDWebImage
import SDWebImageWebPCoder

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewDidLoad")
        // Add coder
        let WebPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(WebPCoder)

        //
        // 获取本地图片路径
        let imagePath = Bundle.main.path(forResource: "balloon_scene_640_960", ofType: "webp")
        // WebP online image loading 获取图片 URL
        let webpURL: URL = URL.init(fileURLWithPath: imagePath!)
        let image5 = UIImage.init(contentsOfFile: imagePath!)
        
        print("image5@@@@@：\(String(describing: image5))")
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 300))
        imageView.sd_setImage(with: webpURL) { (image, error, cacheType, url) in
            print("image2@@@@@：\(String(describing: image))")
            print("image2@@@@@：\(String(describing: error))")
            print("image2@@@@@：\(String(describing: cacheType))")
            print("image2@@@@@：\(String(describing: url))")
        }
        print("image2@@@@@：\(String(describing: imageView))")
        print("image2@@@@@：\(String(describing: imageView.image))")
        imageView.isHidden = true
       // let image = imageView.
        //let image2 = image //  cropingImageFromImage(imageFromImage: image!, inRext: rect)
       // let imageView2: UIImageView = UIImageView(frame: CGRect(x: 100, y: 400, width: 200, height: 300))
        
        self.view.addSubview(imageView)
        
        // 获取本地图片路径
        //let imagePath = Bundle.main.path(forResource: "balloon_scene_640_960", ofType: "webp")
        // WebP online image loading 获取图片 URL
        //let webpURL: URL = URL.init(fileURLWithPath: imagePath!)
        //let imagePath2 = Bundle.main.path(forResource: "balloon_scene_bgr_640_960", ofType: "png")
        //let imagePath2 = Bundle.main.path(forResource: "balloon_scene_640_960", ofType: "webp")
        //let image2 = UIImage(contentsOfFile: imagePath2!) // UIImage(named: "balloon_scene_640_960")
        //let rect = CGRect(x: 50, y: 50, width: 50, height: 50)
        //let cgImageCorpped = image?.cgImage?.cropping(to: rect)
        //image.in
        
       // let imageView2: UIImageView = UIImageView(frame: CGRect(x: 100, y: 400, width: 200, height: 300))
        //imageView2.image = image2 // cropingImageFromImage(imageFromImage: image!, inRext: rect) // UIImage.init(cgImage: cgImageCorpped!)
        //print("image2：\(String(describing: image2))")
        //self.view.addSubview(imageView2)
        
        
        
        // WebP image encoding
        //print("imagePath2: \(String(describing: imagePath2))")
        let imagePath2 = Bundle.main.path(forResource: "balloon_scene_640_960", ofType: "png")
        let image2: UIImage = UIImage(contentsOfFile: imagePath2!)!
        print("imagePath2: \(String(describing: image2))")
        //let webpData = SDImageWebPCoder.shared.encodedData(with: image, format: .webP, options: nil)
       //let imageView3: UIImageView = UIImageView(image: UIImage(data: webpData!))
        
        let rect = CGRect(x: 0, y: 340, width: 652, height: 261)
        let image3 = cropingImageFromImage(imageFromImage: image2, inRext: rect)
        let imageView3: UIImageView = UIImageView(frame: CGRect(x: 50, y: 400, width: 326, height: 130))
        imageView3.image = image3
        self.view.addSubview(imageView3)
       // self.view.addSubview(imageView3)
        
        //let webData = NSData.init(contentsOf: imagePath!)
    }
    
    func cropingImageFromImage(imageFromImage:UIImage!, inRext:CGRect) ->UIImage {
        //将UIImage转换成CGImageRef
        let sourceImageRef:CGImage = imageFromImage.cgImage!
        // 按照给定的矩形区域进行剪裁
        // CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
        let newImageRef: CGImage = sourceImageRef.cropping(to: inRext)!
        // 将CGImageRef转换成UIImage
        // UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
        let img:UIImage = UIImage.init(cgImage: newImageRef)
        //返回剪裁后的图片
        return img
    }


}

