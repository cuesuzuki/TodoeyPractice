//
//  AppDelegate.swift
//  Todory
//
//  Created by yutaka suzuki on 2019/03/15.
//  Copyright © 2019 yutaka suzuki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // データ保存の方法：ホームボタンでアプリを終了するのを保存し、別のアプリに入る
    //バックグラウンドで実行中のプロセスでもメモリを使っている
    //メモリを有効活用するための処理
    //アプリのライフサイクル：起動→画面に表示→背景へ→終了してリソース回収

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        //アプリと背景。アプリがスクリーンから消えたときに、バックグラウンドに移動したとき
        //スマホのメモリに残ってる。問題はアプリ終了するとき
        print("アプリがバックグラウンドへ移動-applicationDidEnterBackground")
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // アプリが終了したときの処理
        //終了ー再起動するとアイテムが消えてしまう。
        //永続的ストレージがないため、アプリ起動中にリストに追加されるだけ
        //いくつかの選択肢あるが、小さなデータを永続化するだけならUserDefaultを使う
        print("アプリが終了したときの処理-applicationWillTerminate")
    }


}

