/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class RangeSlider: UIControl {
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
        
    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0.2
    var upperValue: CGFloat = 0.8
    // #imageLiteral(resourceName: "Oval")
    var thumbImage = #imageLiteral(resourceName: "Oval")
    private let trackLayer = CALayer()
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        addSubview(lowerThumbImageView)
        upperThumbImageView.image = thumbImage
        addSubview(upperThumbImageView)
        
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
    }
    
    private func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue), size: thumbImage.size)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue), size: thumbImage.size)
    }
}
