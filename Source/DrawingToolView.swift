//
//  DrawingTool.swift
//  Componets
//
//  Created by Davis on 2019/3/9.
//  Copyright © 2019 davis. All rights reserved.
//

import Foundation
import UIKit

enum DrawingType:Int {
    case None;
    case Cicle;//画圆
    case Line;//画直线
    case Rect;//画矩形
    case Arc;//圆弧
}

class DrawingToolView:UIView {
    
    // MARK:绘画的参数配置
    private lazy var drawingParams:[DrawingParams] = []
    
    
    
    
    convenience init(drawParams:[DrawingParams]) {
        self.init(frame: CGRect.zero)
        resetDrawingParams(drawParams)
        
    }
    
    // MARK:重置绘画参数
    func resetDrawingParams(_ drawParams:[DrawingParams]){
        self.drawingParams = drawParams
         backgroundColor = UIColor.clear
        setNeedsDisplay()
        
    }
    
    
    
    // MARK:绘画
    override func draw(_ rect: CGRect) {
    
        
        for param in drawingParams{
            //初始化线条的颜色
            param.lineColor.set()
            
            switch param.drawType{
            case .Cicle://圆
                let cicleRect = param.roundedRect
             
                let path = UIBezierPath(roundedRect: CGRect(x: cicleRect.origin.x, y: cicleRect.origin.y, width: cicleRect.size.height, height: cicleRect.size.height), cornerRadius: cicleRect.size.height/2.0)
                
                path.lineWidth = param.lineWidth
                
                path.stroke()
                
                if let fillColor = param.fillColor{
                    fillColor.setFill()
                    path.fill()
                }
                
            case .Rect://矩形
            
                let path = UIBezierPath(roundedRect: param.roundedRect, cornerRadius: param.cornerRadius)
                
                path.lineWidth = param.lineWidth
              
                path.stroke()
                
                if let fillColor = param.fillColor{
                    fillColor.setFill()
                    path.fill()
                }
                
            case .Line://画线
                if let points = param.startAndEndPoint{
                    let path = UIBezierPath()
                    
                    path.move(to: points.0)
                    
                    path.addLine(to: points.1)
                    
                    path.lineWidth = param.lineWidth
                    
                    path.stroke()
                }
            case .Arc://弧度
                if let arcAngle = param.arcStartEndAngle{
                     let path = UIBezierPath(arcCenter: param.arcCenter, radius: param.arcRadius, startAngle: arcAngle.0, endAngle: arcAngle.1, clockwise: param.clockWise)
                    path.lineWidth = param.lineWidth
                     path.stroke()
                    if let color = param.fillColor{
                        //需要填充圆弧
                        path.addLine(to: param.arcCenter)
                        path.close()
                        color.setFill()
                        path.fill()
                    }

                    
                }

 
                
 
            default:
                break
            }
        }   
    }
 
}



struct DrawingParams {
    //默认是画圆
    var drawType:DrawingType = .None
    
    // MARK:圆角的大小(只有为矩形时有效)
    var cornerRadius:CGFloat = 0
    
    // MARK: 这里是指绘画之后的图形frame值(画圆和画矩形必穿参数)
    var roundedRect:CGRect = CGRect.zero
    
    // MARK:线条颜色
    var lineColor:UIColor = UIColor.clear
    
    // MARK:线条的宽度
    var lineWidth:CGFloat = 0.3
    
    // MARK:中间填充颜色
    var fillColor:UIColor?
    
    // MARK:画线时的线条起始点
    var startAndEndPoint:(CGPoint,CGPoint)?
    
    
    //MARK:- arc的中心点
    var arcCenter:CGPoint = CGPoint.zero
    
    //MARK:-  arc的radius
    var arcRadius:CGFloat = 0
    
    //MARK:- arcStartAngle:
    var arcStartEndAngle:(CGFloat,CGFloat)?
 
    //MARK:- 是否是逆时针
    var clockWise:Bool = false
    
}

















