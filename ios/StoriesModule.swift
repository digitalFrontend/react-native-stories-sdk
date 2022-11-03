//
//  StoriesModule.swift
//  react-native-stories-sdk
//
//  Created by Admin on 20.10.2022.
//
import SwiftUI
import UIKit
import Foundation
import InAppStorySDK


@objc(StoriesModule)
class StoriesModule: NSObject, InAppStoryDelegate {
    private var window: UIWindow? = nil;
//    private var mainVC: UIViewController? = nil;
      
//      may change too rootVC
     override init(){
         super.init()
         DispatchQueue.main.async {
             let appDelegate = UIApplication.shared.delegate?.window??.visibleViewController
             appDelegate?.addChild(SimpleIntegrationController())
         }

      }
    
    
   
    
//    var window: UIWindow?
    @objc
    func onCreate(
        _ apiKey:String
    )-> Void{
        print("func was calling")
        do {
        
//            InAppStory.shared.initWith(serviceKey: apiKey)
            InAppStory.shared.initWith(serviceKey: "hDlLPXPDHrjv3Vpd9nlFr8SO3E8DsUBH")
            InAppStory.shared.settings = Settings(userID: "11113")
//            DispatchQueue.main.async {
//            guard let rootVC = UIApplication.shared.delegate?.window??.visibleViewController, (rootVC.navigationController != nil) else {
//                             return
//                        }
//            }
            print("connecting")
//
        } catch {

        }
    }
    
    @objc
    func showSingle(
        _ stotyId:String
    )-> Void{
       
        print("func was calling")
        do {
            DispatchQueue.main.async {
                guard let rootVC = UIApplication.shared.delegate?.window??.visibleViewController, (rootVC.navigationController != nil) else {
                                            return
                                       }
//                var visibleViewController: UIViewController? {
//                    self.window?.makeKeyAndVisible()
//                    return UIWindow.getVisibleViewControllerFrom()
//                }
            InAppStory.shared.settings = Settings(userID: "111111")
                self.window?.makeKeyAndVisible()
                var displaingViewController:UIViewController = UIWindow.getVisibleViewControllerFrom(rootVC)!
                InAppStory.shared.showSingle(with:stotyId, from: displaingViewController, delegate: self) { show in
                print("Story reader \(show ? "is" : "not") showing")
            }
                    print("connecting")
            }
        } catch {

        }
    }
    
    // methods for Delegate
    func storiesDidUpdated(isContent: Bool, from storyType: StoriesType) {
        print("storiesDidUpdated")
    }
    
    func storyReader(actionWith target: String, for type: ActionType, from storyType: StoriesType) {
        print("storyReader")
    }
    
    func storyReaderWillShow(with storyType: StoriesType) {
        print("storyReaderWillShow")
    }
    
    func storyReaderDidClose(with storyType: StoriesType) {
        print("storyReaderDidClose")
    }
    
    func favoriteCellDidSelect() {
        print("favoriteCellDidSelect")
    }
    
    func editorCellDidSelect() {
        print("editorCellDidSelect")
    }
    
    func getGoodsObject(with skus: Array<String>, complete: @escaping GoodsComplete) {
        print("getGoodsObject")
    }
    
    func goodItemSelected(_ item: GoodsObjectProtocol, with storyType: StoriesType) {
        print("goodItemSelected")
    }
}

public func comleteSingleStory(flag: Bool) -> Void{}



public extension UIWindow {
    
    var visibleViewController: UIViewController? {
        self.window?.makeKeyAndVisible()
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

