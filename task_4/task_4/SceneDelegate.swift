//
//  SceneDelegate.swift
//  task_4
//
//  Created by Aliona Starunska on 25.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var blurView: UIVisualEffectView?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupBlur()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        blurView?.removeFromSuperview()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        insertBlur()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        blurView?.removeFromSuperview()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        insertBlur()
    }
    
    // MARK: - Private
    private func setupBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        blurView = UIVisualEffectView(effect: blurEffect)
    }
    
    private func insertBlur() {
        if let blurView = blurView, blurView.superview == nil, let window = self.window {
            blurView.frame = UIScreen.main.bounds
            window.addSubview(blurView)
        }
    }
}
