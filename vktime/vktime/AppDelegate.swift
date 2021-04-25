//
//  AppDelegate.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if DatabaseService.shared.getSubjects().count == 0 {
            let startDate = Int(Date().startOfDay.timeIntervalSince1970) + 10000
            let time = Time.init(start: startDate, end: startDate + 6000, parity: 1, weekday: Date().weekday)
            DatabaseService.shared.addSubject(title: "Математика", teacher: "Ирина Викторовна", place: "302кб", times: [time])
        }
        
        var vc = ScheduleViewController.init(nibName: nil, bundle: nil)
        let navVC = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navVC
        
        return true
    }

}

