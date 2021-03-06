//
//  DDLoadHudManager.swift
//  DDLoadHudDemo
//
//  Created by cuirhong on 2019/4/10.
//  Copyright © 2019 davis. All rights reserved.
//

import Foundation
import UIKit

open class DDLoadHud:UIView  {
    // MARK:圆环的颜色
    open lazy var arcColor:UIColor = UIColor.black
    
    // MARK:圆环的宽度
    open lazy var arcLineWidth:CGFloat = 4
    
    // MARK:动画的颜色
    open lazy var animationColor:UIColor = UIColor.white
    
    // MARK:hud的size
    open lazy var hudSize:CGSize = CGSize(width: 32, height: 32)
    
    // MARK:加载的颜色
    open lazy var loadColor:UIColor = UIColor.white
    
    // MARK:旋转的速度,默认是1
    open lazy var animationSpeed:TimeInterval = 1
    
   
    public override init(frame: CGRect) {
        super.init(frame: frame)
         bottomArcView = DrawingToolView()
        self.addSubview(bottomArcView!)
        
    
        progressDrawingview = DrawingToolView()
        self.addSubview(progressDrawingview!)
    }
    
  
    
    
    // MARK:开始动画
    open func startAnimation(){
        //圆环
        var parmas = DrawingParams()
        parmas.drawType = .Cicle
        parmas.cornerRadius = hudSize.height * 0.5 - arcLineWidth
        parmas.roundedRect = CGRect(x: arcLineWidth, y: arcLineWidth, width: hudSize.width-arcLineWidth*2, height: hudSize.height-arcLineWidth*2)
        parmas.lineColor = arcColor
        parmas.lineWidth = arcLineWidth
        
        bottomArcView?.frame = CGRect(x: 0, y: 0, width: hudSize.width, height: hudSize.height)
        bottomArcView?.resetDrawingParams([parmas])
        
        //进度
        var progressParams = DrawingParams()
        progressParams.drawType = .Arc
        progressParams.lineColor = loadColor
        progressParams.lineWidth = arcLineWidth
        progressParams.arcCenter = CGPoint(x: hudSize.width*0.5, y: hudSize.height*0.5)
        progressParams.arcRadius = hudSize.height * 0.5 - arcLineWidth
        progressParams.arcStartEndAngle = (CGFloat(Double.pi),CGFloat(1.5 * Double.pi))
        progressParams.clockWise = true
        
        progressDrawingview?.frame = CGRect(x: 0, y: 0, width: hudSize.width, height: hudSize.height)
         progressDrawingview?.resetDrawingParams([progressParams])
        
        
      
        stopAnimation()
        
        // 1. 创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        // 2. 设置动画属性
        rotationAnim.fromValue = 0 // 开始角度
        rotationAnim.toValue = Double.pi * 2 //结束角度
        rotationAnim.repeatCount = MAXFLOAT // 重复次数
        rotationAnim.duration = 1/animationSpeed // 一圈所需要的时间
        rotationAnim.isRemovedOnCompletion = false //默认是true，切换到其他控制器再回来，动画效果会消失，需要设置成false，动画就不会停了
        progressDrawingview?.layer.add(rotationAnim, forKey: "transform.rotation.z") // 给需要旋转的view增加动画
        
    }
    
    
    // MARK:停止动画
    open func stopAnimation(){
        progressDrawingview?.layer.removeAllAnimations()
    }
    
    // MARK:是否正在动画
    open func isAnimation()->Bool{
        return ((progressDrawingview?.layer.animation(forKey: "transform.rotation.z")) != nil)
    }
    
    
    fileprivate var bottomArcView:DrawingToolView? = nil
    
    fileprivate  var progressDrawingview:DrawingToolView? = nil
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
