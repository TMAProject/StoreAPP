//
//  SceneDelegate.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import UIKit
// swiftlint:disable line_length

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)

        let storeRoomVC = StoreRoomTableViewController(style: .grouped)
        let navigation = UINavigationController(rootViewController: storeRoomVC)
        window.rootViewController = navigation

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
