//
//  RootViewController.swift
//  FestFive
//
//  Created by Techchain on 25/02/2021.
//

import UIKit

class RootViewController: BaseViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    private let transitionDuration = 0.3
    private var isTrasitioning = false
    
    lazy var homeVc = HomeViewController()
    
    enum Screen {
        case home
    }
    
    convenience init(screen: Screen) {
        self.init()
        self.screen = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch screen {
        case .home:
            show(scene: homeVc)
        }
        
    }
    var currentScene: UIViewController!
    var screen: Screen = .home
    
    
    enum TransitionStyle {
        case `switch`
        case fadeIn
        case present
    }
    
    func showHome(style: TransitionStyle, completion: (() -> Void)?) {
        let navigationController = UINavigationController(rootViewController: homeVc)
        navigationController.setNavigationBarHidden(true, animated: false)
        switch style {
        case .switch:
            self.switch(to: navigationController, completion: completion)
        case .fadeIn:
            show(scene: navigationController, completion: completion)
        case .present:
            present(navigationController, animated: true, completion: completion)
        }
    }
    
    private func `switch`(to scene: UIViewController, completion: (() -> Void)? = nil) {
        addChild(scene)
        currentScene?.willMove(toParent: nil)
        scene.view.embed(in: view)
        let initialFrame = CGRect(x: 2 * view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        scene.view.frame = initialFrame
        isTrasitioning = true
        transition(from: currentScene, to: scene, duration: transitionDuration, options: [], animations: {
            scene.view.frame = self.view.bounds
        }) { (completed) in
            self.currentScene.view.removeFromSuperview()
            self.currentScene.removeFromParent()
            scene.didMove(toParent: self)
            self.currentScene = scene
            self.isTrasitioning = false
            completion?()
        }
    }
    
    private func show(scene: UIViewController, completion: (() -> Void)? = nil) {
        guard let currentScene = self.currentScene else {
            scene.view.frame = self.view.bounds
            self.addChild(scene)
            self.view.addSubview(scene.view)
            self.currentScene?.view.removeFromSuperview()
            self.currentScene?.removeFromParent()
            scene.didMove(toParent: self)
            self.currentScene = scene
            completion?()
            return
        }
        addChild(scene)
        self.currentScene?.willMove(toParent: nil)
        scene.view.embed(in: view)
        scene.view.alpha = 0
        isTrasitioning = true
        transition(from: currentScene, to: scene, duration: transitionDuration, options: .curveEaseIn) {
            scene.view.alpha = 1
        } completion: { _ in
            self.currentScene.view.removeFromSuperview()
            self.currentScene.removeFromParent()
            scene.didMove(toParent: self)
            self.currentScene = scene
            self.isTrasitioning = false
            completion?()
        }
    }
}
