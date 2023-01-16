//
//  NativeCustomViewManager.swift
//  react-native-stories-sdk
//
//  Created by Admin on 19.10.2022.
//

import Foundation
@objc (NativeCustomViewManager)
class NativeCustomViewManager: RCTViewManager {

    var controller: SimpleIntegrationController = SimpleIntegrationController()
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }

    override func view() -> UIView! {
        return self.controller.view
    }

    @objc
    func refreshStoriesList()-> Void{
        do {
            DispatchQueue.main.async {
                self.controller.refresh()
            }
        } catch {}
    }
}
