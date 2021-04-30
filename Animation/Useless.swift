//
//  File.swift
//  Animation
//
//  Created by Andrei Niunin on 19.04.2021.
//

import UIKit

extension UIBezierPath {
        
    convenience init(numberOfMarks: Int) {
        self.init()
        for i in 0..<numberOfMarks {
            let xOffs: CGFloat = CGFloat(i) * 30
            self.drawSingleMark(xOffs: xOffs)
        }
    }

    func drawSingleMark(xOffs: CGFloat)  {
        let height: CGFloat = 20
        let width: CGFloat = 20

        self.move(to: CGPoint(x: xOffs, y: height))
        self.addLine(to: CGPoint(x: xOffs+width, y: height))
        self.addLine(to: CGPoint(x: xOffs+width, y: 0))
        self.addLine(to: CGPoint(x: xOffs, y: 0))
        self.close()
    }


}
