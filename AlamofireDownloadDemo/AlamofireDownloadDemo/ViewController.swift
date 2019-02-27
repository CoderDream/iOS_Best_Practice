//
//  ViewController.swift
//  AlamofireDownloadDemo
//
//  Created by CoderDream on 2019/2/27.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    //进度条
    var valueProgress:UIProgressView!;
    //开始，停止
    var bsBtn:UIButton!;
    //下载文件的保存路径
    var destinationPath:DownloadRequest.DownloadFileDestination!;
    //用于停止下载时，保存已下载的部分
    var cancelledData: Data?;
    //下载请求对象
    var downloadRequest: DownloadRequest!;
    // 图片
    //var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white;
        self.title = "下载页面";
        
        //设置下载路径。保存到用户文档目录，文件名不变，如果有同名文件则会覆盖
        self.destinationPath = { _, response in
            let documentsPath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
            let fileURL = documentsPath.appendingPathComponent(response.suggestedFilename!)
            //完成以后才会输出,记得这里查看地址的时候，要把地址最前面的file//去掉
            print("输出此时下载的地址位置。。。。。\(fileURL)");
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL,[.removePreviousFile, .createIntermediateDirectories])
        }
        
        //进度条
        self.valueProgress = UIProgressView.init(frame: CGRect.init(x: 50, y: 130, width: 100, height: 50));
        self.valueProgress.progressViewStyle = UIProgressView.Style.default;
        self.valueProgress.backgroundColor = UIColor.lightGray;
        self.view.addSubview(self.valueProgress);
        //开始，停止按钮
        self.bsBtn = UIButton.init(frame: CGRect.init(x: 50, y: 150, width: 100, height: 50));
        self.bsBtn.setTitle("开始下载", for: UIControl.State.normal);
        self.bsBtn.setTitleColor(UIColor.blue, for: UIControl.State.normal);
        self.bsBtn.isSelected = false;
        self.bsBtn.addTarget(self, action: #selector(clickDownloadBtn(btn:)), for: UIControl.Event.touchUpInside);
        self.view.addSubview(self.bsBtn);
    }
    
    @objc func clickDownloadBtn(btn: UIButton) {
        if btn.isSelected {
            btn.setTitle("开始下载", for: UIControl.State.normal);
            btn.isSelected = false;
            
            //停止下载，记录下载进度
            self.downloadRequest.cancel();
        }else{
            btn.setTitle("停止下载", for: UIControl.State.normal);
            btn.isSelected = true;
            
            //请求下载
            self.httpRequest();
        }
    }
    //MARK:-------------- 下载数据请求http
    func httpRequest() {
        let url1 = "http://aggie-horticulture.tamu.edu/wildseed/flowers/AlamoFire.jpg"
        //let url2 = "https://pm.myapp.com/invc/xfspeed/qqpcmgr/download/QQPCDownload1600.exe"
        //let url3 = "http://dldir1.qq.com/qqfile/qq/QQ7.9/16621/QQ7.9.exe"
        
        if let cancelledData = self.cancelledData {
            self.downloadRequest = Alamofire.download(resumingWith: cancelledData,to: self.destinationPath);
        } else {
            //页面加载完毕就自动开始下载
            self.downloadRequest = Alamofire.download(url1, to: self.destinationPath);
            //print("111111111111");
        }
        //下载进度
        self.downloadRequest.downloadProgress(queue: DispatchQueue.main,closure: downloadProgress);
        //下载数据响应
        self.downloadRequest.responseData(completionHandler: downloadResponse)
        self.downloadRequest.responseData { response in // 这里一定要取 responseData，否则报错
            if let data = response.result.value {
                let image = UIImage(data: data)
                let imageView = UIImageView.init(frame: CGRect.init(x: 50, y: 350, width: 300, height: 150));
                imageView.image = image
                imageView.layer.borderWidth = 5
                imageView.layer.borderColor = UIColor.red.cgColor
                self.view.addSubview(imageView)
                print("set image success")
            }
            let message = "下载图片结果：\(response.result)"
            print(message)
        }
    }
    //MARK:------------下载过程中改变进度条
    func downloadProgress(progress: Progress) {
        //进度条更新
        self.valueProgress.setProgress(Float(progress.fractionCompleted), animated: true);
        //print(Float(progress.fractionCompleted));
        print("当前进度：\(progress.fractionCompleted*100)%");
    }
    //MARK:------------下载停止响应（不管成功或者失败）
    func downloadResponse(response: DownloadResponse<Data>) {
        switch response.result {
        case .success( _):
            //self.image = UIImage(data: data)
            self.bsBtn.setTitle("下载完成", for: UIControl.State.normal);
            print("文件下载完毕: \(response)");
        case .failure:
            //意外终止的话，把已下载的数据储存起来
            self.cancelledData = response.resumeData;
        }
    }
}

