//
//  QRCodeViewController.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/27.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
import SVProgressHUD

// 冲击波所占比例
let scanLineRatio: CGFloat = 3

// 闭包类型
typealias ExpressNumReturn = (expressNum: String) -> Void

class QRCodeViewController: UIViewController {

    var lightOn = false
    
    // 定义一个变量，将匿名函数当变量使用
    var expressNumReturn: ExpressNumReturn?

    weak var centerHeightCons: Constraint!
    
    weak var scanLineTopCons: Constraint!
    weak var scanLineHeightCons: Constraint!
    
    
    var defaultShowed = true
    
    var centerViewHeight: CGFloat = 150
    let centerViewWidth: CGFloat = 300
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupUI()
        
        // 开始冲击波动画
        startAnimation()
        
        // 开始扫描
        startScan()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK: - Method add by myself

    func setupUI() {
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        title = "请扫描条形码"
        bottomTabbar.selectedItem = bottomTabbar.items![0]
        bottomTabbar.delegate = self
        
//        添加子控件
        view.addSubview(centerView)
        centerView.addSubview(borderImageView)
        centerView.addSubview(scanlineImageView)
        view.addSubview(bottomTabbar)
        
//        添加约束
        centerView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY)
            make.width.equalTo(centerViewWidth)
            self.centerHeightCons = make.height.equalTo(centerViewHeight).constraint
        }
        
        borderImageView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        scanlineImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(centerView.snp_centerX).constraint
            self.scanLineTopCons = make.top.equalTo(0).constraint
            self.scanLineHeightCons = make.height.equalTo(self.centerViewHeight / scanLineRatio).constraint
            make.width.equalTo(centerView.snp_width)
            
        }
        
        bottomTabbar.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }

    final func startAnimation() {
        
        self.scanLineTopCons.updateOffset(-self.centerViewHeight / scanLineRatio)
        self.scanLineHeightCons.updateOffset(self.centerViewHeight / scanLineRatio)
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(1.2, animations: {
            // 设置动画指定次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            // 修改约束
            self.scanLineTopCons.updateOffset(self.centerViewHeight * (scanLineRatio - 1)/scanLineRatio)
            
            // 强制更新界面
            self.view.layoutIfNeeded()

            }, completion: nil)
        
    }
    
    func startScan() {
        
        // 1.判断是否能够将输入添加到会话中
        if !session.canAddInput(deviceInput) {
            return
        }
        
        // 2.判断是否能够将输出添加到会话中
        if !session.canAddOutput(output) {
            return
        }
        
        // 3.将输入和输出都添加到会话中
        session.addInput(deviceInput)
        session.addOutput(output)

        // 4.设置输出能够解析的数据类型
        // 注意：设置能够解析的数据类型，一定要在输出对象添加到会话之后设置，否则会报错
//        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeQRCode]
        
        // 5.设置输出对象的代理。只要解析成功就会通知代理
        // 添加到主线程上
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        // 如果想实现只扫描一张图片，那么系统自带的二维码扫描是不支持的
        // 只能设置让二维码只有出现在某一块区域去扫描
        // output.rectOfInterest = CGRectMake(0.0, 0.0, 0.5, 0.5)
        
        // 添加预览图层（将相机capture到的内容展示到layer层上）
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        // 添加绘制图层到预览图层上
        previewLayer.addSublayer(drawLayer)
        // 6.告诉session开始扫描
        session.startRunning()
        
        // 放大
        do {
            try self.deviceInput?.device!.lockForConfiguration()
        } catch _ {
            NSLog("Error: lockForConfiguration.");
        }
        self.deviceInput?.device!.videoZoomFactor = 1.5
        self.deviceInput?.device!.unlockForConfiguration()


    }
    
    func getExpressNum(result: ExpressNumReturn) {
        self.expressNumReturn = result
    }
    
    func switchLight() {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch){
            do {
                try device.lockForConfiguration()
            } catch {
                print(error)
            }
            if (device.torchMode == AVCaptureTorchMode.On)
            {
                device.torchMode = AVCaptureTorchMode.Off
            }
            else
            {
                do {
                    try device.setTorchModeOnWithLevel(1.0)
                } catch {
                    print(error)
                }
            }
            device.unlockForConfiguration()
        }

//        if deviceInput!.device.hasTorch {
//            SVProgressHUD.showErrorWithStatus("没有手电筒")
//            return
//        }
//        
//        if lightOn == false { // 打开灯
//            deviceInput!.device.setTorchModeOnWithLevel(<#T##torchLevel: Float##Float#>)
//        } else { // 关灯
//            
//        }
//        lightOn = !lightOn
    }

//    MARK: - 懒加载
    // 底部tabbar工具条
    lazy var bottomTabbar: UITabBar = {
        let tabbar = UITabBar()
        let barcode = UITabBarItem(title: "条形码", image: UIImage(named: "qrcode_tabbar_icon_barcode"), tag: 101)
        let qrcode = UITabBarItem(title: "二维码", image: UIImage(named: "qrcode_tabbar_icon_qrcode"), tag: 102)
        tabbar.items = [barcode, qrcode]
        return tabbar
    }()
    
    // 打开灯按钮
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let barItem = UIBarButtonItem(imageName: "camera_flashlight_open", target: self, action: "switchLight")
        return barItem
    }()
    
    // 容器view
    lazy var centerView: UIView = {
        let view = UIView()
        view.frame = CGRectMake(0, 0, self.centerViewWidth, self.centerViewHeight)
        return view
    }()
    
    // 边框view
    lazy var borderImageView: UIImageView = {
        let borderView = UIImageView(image: UIImage(named: "qrcode_border"))
        
        return borderView
    }()
    
    // 冲击波view
    lazy var scanlineImageView: UIImageView = {
        let scanlineView = UIImageView(image: UIImage(named: "qrcode_scanline_barcode"))
        scanlineView.frame = CGRectMake(0, 0, self.centerViewWidth, self.centerViewHeight / scanLineRatio)
        
        return scanlineView
    }()
    
    // 会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    
    // 拿到输入设备
    private lazy var deviceInput: AVCaptureDeviceInput? = {
        // 获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            // 创建输入对象
            let input = try AVCaptureDeviceInput(device: device)
            return input
        } catch {
            print(error)
            return nil
        }
    }()

    // 拿到输出对象
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()

    // 拿到预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
    // 创建用于绘制边线的图层
    private lazy var drawLayer: CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()

}

extension QRCodeViewController: UITabBarDelegate {
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.tag == 101 { // 条形码
            self.centerHeightCons.updateOffset(150)
            centerViewHeight = 150
        } else if item.tag == 102 { // 二维码
            self.centerHeightCons.updateOffset(300)
            centerViewHeight = 300

        }
        // 停止动画
        self.scanlineImageView.layer.removeAllAnimations()
        
        // 重新开始动画
        startAnimation()
    }
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
//    只要解析到数据就会调用
    
    
    // 1.获取扫描到的数据
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // 0.清空图层
        clearConers()
        
        // print(metadataObjects)
        // 注意：要使用stringValue
        // resultLabel.text = metadataObjects.last?.stringValue
        // resultLabel.sizeToFit()
        print("---result---\(metadataObjects.last?.stringValue)")
        
        // 2.获取扫描到的二维码的位置
        // 2.1.转换坐标
        for object in metadataObjects {
            // 2.1.1.判断当前获取到的数据，是否是机器可识别的类型
            if object is AVMetadataMachineReadableCodeObject {
                // 2.1.2.将坐标转换界面可识别的坐标系
                let codeObject = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                // 2.1.3.绘制图形
                drawCorners(codeObject)
            }
        }
        
        if self.expressNumReturn != nil {
            if metadataObjects.last != nil {
                self.expressNumReturn!(expressNum: metadataObjects.last!.stringValue!)
            }
//            self.expressNumReturn!(expressNum: (metadataObjects.last?.stringValue!)!)
            self.navigationController?.popViewControllerAnimated(true)
        }

    }
    
    /**
     *  绘制图形
     *
     *  @param AVMetadataMachineReadableCodeObject 保存了坐标的对象
     */
    private func drawCorners(codeObject: AVMetadataMachineReadableCodeObject) {
        
        if codeObject.corners.isEmpty {
            return
        }
        
        // 1.创建一个图层
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        
        // 2.创建路径
        // layer.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).CGPath
        let path = UIBezierPath()
        var point = CGPointZero
        var index: Int = 0
        // 2.1.移动到第一个点
        // 从corners数组中取出第0个元素，将这个字典中的x/y赋值给point
        CGPointMakeWithDictionaryRepresentation((codeObject.corners[index] as! CFDictionaryRef), &point)
        index += 1
        path.moveToPoint(point)
        
        // 2.2.移动到其它的点
        while index < codeObject.corners.count {
            CGPointMakeWithDictionaryRepresentation((codeObject.corners[index] as! CFDictionaryRef), &point)
            index += 1
            path.addLineToPoint(point)
        }
        
        // 2.3.关闭路径
        path.closePath()
        
        // 2.4.绘制路径
        layer.path = path.CGPath
        
        // 3.将绘制好的图层添加到drawLayer上
        drawLayer.addSublayer(layer)
    }
    
    /**
     *  清空边线
     */
    private func clearConers() {
        // 1.判断drawLayer上是否有其它图层
        if drawLayer.sublayers == nil || drawLayer.sublayers?.count == 0 {
            return
        }
        // 2.移除所有子图层
        for subLayer in drawLayer.sublayers! {
            subLayer.removeFromSuperlayer()
        }
    }
}

