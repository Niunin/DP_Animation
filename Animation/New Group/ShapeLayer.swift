//
//  ShapeLayer.swift
//  Animation
//
//  Created by Andrei Niunin on 19.04.2021.
//

import UIKit

// MARK: - Object

class ShapeLayer: CAShapeLayer {
// MARK: properties
    
    var numberOfMarks: Int!
    var indexOfLongMark: Int!
    
    private let h = 6
    private let w = 6
    private let lw = 18
    private let space = 10
    private var offset: Int {
       return w + space
    }

// MARK: init - deinit
    
    convenience init(numberOfMarks: Int, longMarkIndes: Int) {
        self.init()
        self.numberOfMarks = numberOfMarks
        self.indexOfLongMark = longMarkIndes
        setupInitialState()
    }
    
    
// MARK: setup layer
    
    func setupInitialState() {
        let shortMark = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: w, height: h))
        let longMark = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: lw, height: h))
        let shortMarkPath = UIBezierPath(rect: shortMark).cgPath
        let longMarkPath = UIBezierPath(rect: longMark).cgPath
        
        for i in 0...indexOfLongMark {
            let mark = setupMarkLayer()
            self.addSublayer(mark)

            let xOffset = i * offset
            mark.position = CGPoint(x: xOffset, y: 0)
            mark.path = i == indexOfLongMark ? longMarkPath : shortMarkPath
        }
        
        let startCoordinate = indexOfLongMark * (space+w) + (space+lw)
        let endIndex = numberOfMarks - indexOfLongMark

        print(startCoordinate)
        for i in 0..<endIndex{
            let mark = setupMarkLayer()
            self.addSublayer(mark)
            let xOffset = i * (w+space) + startCoordinate
            mark.position = CGPoint(x: xOffset, y: 0)
            mark.path = shortMarkPath
        }
        
    }
    
    func setupMarkLayer()->CAShapeLayer {
        let mark = CAShapeLayer()
        mark.fillColor = UIColor.systemPink.cgColor
        mark.lineWidth = 0
        return mark
    }
    
    func setupMarkStrokeLayer()->CAShapeLayer {
        let mark = CAShapeLayer()
        self.addSublayer(mark)
        mark.strokeColor = UIColor.systemPink.cgColor
        mark.lineWidth = 6
        mark.anchorPoint = CGPoint(x: 0, y: 6)
        mark.lineCap = CAShapeLayerLineCap(rawValue: "round")
        mark.lineJoin = CAShapeLayerLineJoin(rawValue: "round")
        return mark
    }
    
// MARK: some tools
        
    func insertMark(at position: Int) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.2)
        CATransaction.setCompletionBlock {
            self.drawMark(at: position)
        }
        self.offsetMarks(startingFrom: position, offset: self.offset)
        CATransaction.commit()
        
    }
        
    func removeMark(at position: Int) {
        if let markToRemove = self.sublayers?[position] {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.2)
            CATransaction.setCompletionBlock {
                self.offsetMarks(startingFrom: position, offset: -1 * self.offset)
            }
            markToRemove.removeFromSuperlayer()
            CATransaction.commit()
        }
    }
    
    func offsetMarks(startingFrom startIndex: Int, offset: Int) {
        guard let endIndex = self.sublayers?.endIndex   else { return }
        
        for i in startIndex..<endIndex {
            if let mark = self.sublayers?[i] {
                var newPosition = mark.position
                newPosition.x += CGFloat(offset)
                mark.animatePosition( toValue: newPosition)
                
            }
        }
    }
    
    func drawMark(at position: Int) {
        
        let markRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: w, height: h))
        
        let markPath = UIBezierPath(rect: markRect).cgPath
        
        let mark = setupMarkLayer()
        mark.fillColor = UIColor.red.cgColor
        

        if position > indexOfLongMark {
            let xOffset = position * offset + (lw-w)
            mark.position = CGPoint(x: xOffset, y: 0)
        } else {
            let xOffset = position * offset
            mark.position = CGPoint(x: xOffset, y: 0)
        }
        mark.path = markPath
        self.insertSublayer(mark, at: UInt32(position))
    
        
        //self.addSublayer(mark)
    }
    
    func getDown() {
        guard let endIndex = self.sublayers?.endIndex   else { return }
        
        for i in 0..<endIndex {
            if i == indexOfLongMark { continue }
            if let mark = self.sublayers?[i] {
                var newPosition = mark.position
                newPosition.x += CGFloat(offset)
                //mark.animateOffset( toValue: newPosition)
                mark.anchorPoint = CGPoint(x: 0, y: 10000)
                mark.animateHeight()
            }
        }
    }
 
}

// MARK: - CAAnimation Delegate

extension ShapeLayer: CALayerDelegate {
    
}

// MARK: - CALayer Exnension

extension CALayer {
    func animatePosition(toValue: Any) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = self.position
        animation.toValue = toValue
        animation.autoreverses = false
    
        animation.duration = 0.2
        animation.fillMode = .removed
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        animation.isRemovedOnCompletion = true

        self.position = toValue as! CGPoint
        self.add(animation, forKey: "position")
    }
    
    func animateHeight() {
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.fromValue = 1
        animation.toValue = 0.1
        animation.autoreverses = false
        animation.duration = 0.2
        self.add(animation, forKey: "position1")
    }

}

//extension ShapeLayerAnimation: CAAnimationDelegate {
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {

//        circle.fillColor = UIColor.red.cgColor
//    }
//}


