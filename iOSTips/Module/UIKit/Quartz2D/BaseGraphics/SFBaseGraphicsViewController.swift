//
//  SFBaseGraphicsViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/8.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

enum PathType {
    case StraightLine
    case QuadCurveLine
    case Rectangle
    case RoundRectangle
    case SpecificRoundRectangle
    case Oval
    case CircleRound1
    case CircleRound2
    case Arc
    case Simple
}

var pathType = PathType.StraightLine

class SFBaseGraphicsViewController: UIViewController {
    
    lazy var drawView: SFDrawView = {
        let drawView = SFDrawView()
        drawView.backgroundColor = UIColor.white
        return drawView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(drawView)
        drawView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drawView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            drawView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drawView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drawView.heightAnchor.constraint(equalToConstant: view.bounds.height/2)
            ])
    }
    
    // 直线
    @IBAction func straightLine(_ sender: Any) {
        pathType = PathType.StraightLine
        drawView.setNeedsDisplay()
    }
    
    // 指定支点的弧线
    @IBAction func quadCurveLine(_ sender: Any) {
        pathType = PathType.QuadCurveLine
        drawView.setNeedsDisplay()
    }
    
    // 矩形
    @IBAction func rectangle(_ sender: Any) {
        pathType = PathType.Rectangle
        drawView.setNeedsDisplay()
    }
    
    // 圆角矩形
    @IBAction func roundRectangle(_ sender: Any) {
        pathType = PathType.RoundRectangle
        drawView.setNeedsDisplay()
    }
    
    // 指定某个角带圆角的矩形
    @IBAction func specificRoundRectangle(_ sender: Any) {
        pathType = PathType.SpecificRoundRectangle
        drawView.setNeedsDisplay()
    }
    
    // 椭圆
    @IBAction func oval(_ sender: Any) {
        pathType = PathType.Oval
        drawView.setNeedsDisplay()
    }
    
    // 圆形1
    @IBAction func circleRound1(_ sender: Any) {
        pathType = PathType.CircleRound1
        drawView.setNeedsDisplay()
    }
    @IBAction func circleRound2(_ sender: UIButton) {
        pathType = PathType.CircleRound2
        drawView.setNeedsDisplay()
    }
    
    // 圆弧
    @IBAction func arc(_ sender: Any) {
        pathType = PathType.Arc
        drawView.setNeedsDisplay()
    }
    
    @IBAction func simple(_ sender: UIButton) {
        pathType = PathType.Simple
        drawView.setNeedsDisplay()
    }
}
