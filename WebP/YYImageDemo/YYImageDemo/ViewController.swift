//
//  ViewController.swift
//  YYImageDemo
//
//  Created by CoderDream on 2019/7/22.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import YYImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        // Decode single frame:
       // let data = NSData.dataWithContentsOfMappedFile("")
      //  let decoder: YYImageDecoder
       // NSData *data = [NSData dataWithContentsOfFile:@"/tmp/image.webp"];
        //YYImageDecoder *decoder = [YYImageDecoder decoderWithData:data scale:2.0];
        //UIImage image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;
        // 获取本地图片路径
        let imagePath = Bundle.main.path(forResource: "balloon_scene_640_960", ofType: "webp")
        // WebP online image loading 获取图片 URL
       // let webpURL: URL = URL.init(fileURLWithPath: imagePath!)
        let data = NSData(contentsOfFile: imagePath!)
        let decoder = YYImageDecoder(data: data! as Data, scale: 2.0)
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 300))
        let image = decoder?.frame(at: 0, decodeForDisplay: true)?.image
        imageView.image = image
        self.view.addSubview(imageView)
        
       // imageView.sd_setImage(with: webpURL)
        // let imageView2: UIImageView = UIImageView(frame: CGRect(x: 100, y: 400, width: 200, height: 300))
        
        //self.view.addSubview(imageView)
        
        let rect = CGRect(x: 0, y: 340, width: 652, height: 261)
        let image3 = cropingImageFromImage(imageFromImage: image, inRext: rect)
        let imageView3: UIImageView = UIImageView(frame: CGRect(x: 50, y: 400, width: 326, height: 130))
        imageView3.image = image3
        self.view.addSubview(imageView3)
    }
    // 
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

