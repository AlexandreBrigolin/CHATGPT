//
//  SceneDelegate.swift
//  CHATGPT
//
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        NotificationCenter.default.addObserver(self, selector: #selector(switchStateChangedNotification), name: Notification.Name("SwitchStateChangedNotification"), object: nil)
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: ChatVC())
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .pink
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
        updateAppTheme(isSwitchOn: (UserDefaults.standard.value(forKey: Key.isNight.rawValue) as? Bool) ?? true)
    }
    
    @objc func switchStateChangedNotification(notification: Notification) {
        guard let isSwitchOn = notification.object as? Bool else { return }
        updateAppTheme(isSwitchOn: isSwitchOn)
    }
    
    func updateAppTheme(isSwitchOn: Bool) {
        if #available(iOS 13.0, *) {
            UserDefaults.standard.setValue(isSwitchOn, forKey: Key.isNight.rawValue)
            UserDefaults.standard.synchronize()
            let style: UIUserInterfaceStyle = isSwitchOn ? .dark : .light
            window?.overrideUserInterfaceStyle = style
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}

