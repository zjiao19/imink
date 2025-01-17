//
//  SceneDelegate.swift
//  imink
//
//  Created by Jone Wang on 2021/7/20.
//

import SwiftUI

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Fix the problem that NavgationView and TabBar has no background when Stack style.
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            let defaultAppearance = UINavigationBar.appearance()
            defaultAppearance.standardAppearance = navigationBarAppearance
            defaultAppearance.scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            let appAppearance = UITabBar.appearance()
            appAppearance.standardAppearance = tabBarAppearance
            appAppearance.scrollEdgeAppearance = tabBarAppearance
        }
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Do not config external display. So we can get default mirroring behavior.
        guard session.role != .windowExternalDisplay else { return }

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let contentView = InkApp()
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
            
            configureNotchBranding()
        }
    }
}

// NotchBranding
extension SceneDelegate {
    func configureNotchBranding() {
        guard let window = window,
              UIDevice.current.userInterfaceIdiom == .phone,
              UIApplication.shared.windows.first!.safeAreaInsets.top > 20 else {
            return
        }
        
        // Add NotchBranding to window
        let notchBranding = UIHostingController(rootView: NotchBranding())
        notchBranding.view.backgroundColor = .clear
        notchBranding.view.isUserInteractionEnabled = false
        window.addSubview(notchBranding.view)
        notchBranding.view.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(window)
        }
    }
}
