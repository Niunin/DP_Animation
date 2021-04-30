//
//  SceneDelegate.swift
//  Animation
//
//  Created by Andrei Niunin on 19.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // ViewController
        let viewController = ViewController()
        
        // NavigationController
//        let navigationController =  UINavigationController(rootViewController: viewController)
//        navigationController.navigationBar.topItem?.title = "Animation"
//        navigationController.navigationBar.prefersLargeTitles = true
        
        // Window
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }



}

