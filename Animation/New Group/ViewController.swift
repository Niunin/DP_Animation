//
//  ViewController.swift
//  Animation
//
//  Created by Andrei Niunin on 19.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let layer = ShapeLayer(numberOfMarks: 10, longMarkIndes: 5)
    
    lazy var buttonPlus = UIButton(type: .system)
    lazy var buttonMinus = UIButton(type: .system)
    lazy var buttonUpDown = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.layer.addSublayer(layer)
        layer.position = CGPoint(x: 100, y: 200)
        setupButtonPlus(buttonPlus)
        setupButtonMinus(buttonMinus)
        setupButtonDown(buttonUpDown)
    }
    
    private func setupButtonPlus(_ button: UIButton) {
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(plusAction), for: .touchUpInside)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupButtonMinus(_ button: UIButton) {
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(minusAction), for: .touchUpInside)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupButtonDown(_ button: UIButton) {
        button.setTitle("^", for: .normal)
        button.addTarget(self, action: #selector(downAction), for: .touchUpInside)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @IBAction func plusAction() {
        layer.insertMark(at: 6)
        
    }
    
    @IBAction func minusAction() {
        layer.removeMark(at: 6)
    }
    
    @IBAction func downAction() {
        layer.getDown()
    }

}
