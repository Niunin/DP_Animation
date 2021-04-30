//
//  Replicator.swift
//  Animation
//
//  Created by Andrei Niunin on 20.04.2021.
//

import UIKit

class Replicator: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK:
    func setupLayer(numberOfMarks: Int, longMarkIndesx: Int) {
        let singleMarkLayer = setupMarkLayer()
        
        let marksLayer = CAReplicatorLayer()
        layer.addSublayer(marksLayer)
         marksLayer.instanceCount = numberOfMarks
        marksLayer.addSublayer(singleMarkLayer)
        
    }
    
    
    func setupMarkLayer()->CAShapeLayer {
        let mark = CAShapeLayer()
        mark.fillColor = UIColor.systemPink.cgColor
        mark.lineWidth = 0
        return mark
    }
}
