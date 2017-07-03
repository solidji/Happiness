//
//  ViewController.swift
//  Happniss
//
//  Created by 计 炜 on 2017/6/30.
//  Copyright © 2017年 计 炜. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FaceViewDataSource {

    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(faceView.scale(gesture:))))
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    @IBAction func changeHappiness(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            fallthrough
        case .changed:
            let translation = gesture.translation(in: faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPoint.zero, in: faceView)
            }
        default: break

        }
    }
    
    var happiness: Int = 100 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    
    private func updateUI() {
        faceView.setNeedsDisplay()
    }

    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }

} 

