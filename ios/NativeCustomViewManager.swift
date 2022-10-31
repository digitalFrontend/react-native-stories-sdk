//
//  NativeCustomViewManager.swift
//  react-native-stories-sdk
//
//  Created by Admin on 19.10.2022.
//

import Foundation
@objc (NativeCustomViewManager)
class NativeCustomViewManager: RCTViewManager {

  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func view() -> UIView! {
      return SimpleIntegrationController().view
  }

}
