//
//  SimpleIntegrationController.swift
//  react-native-stories-sdk
//
//  Created by Admin on 20.10.2022.
//
import UIKit
import InAppStorySDK
import AudioToolbox
import SwiftUI



class SimpleIntegrationController: UIViewController, InAppStoryDelegate
{
    var window: UIWindow!
     var vc: UIViewController!
     var storyView: StoryView!
    
    override func loadView() {
        print("SimpleIntegrationController 1")
        let screenSize: CGRect = UIScreen.main.bounds
        let rect = CGRect(x: 0, y: 0, width: screenSize.width, height: 134)
        view = UIView(frame: rect)

    }
    
    func refresh() {
       storyView.refresh()
    }
    
    override func viewDidLoad() {
        print("SimpleIntegrationController 2")
        super.viewDidLoad()
        DispatchQueue.main.async {
            guard let rootVC = UIApplication.shared.delegate?.window??.visibleViewController, (rootVC.navigationController != nil) else {
                                         return
                                    }
            rootVC.addChild(self)
            
        }
            // create instance of StoryView
            let screenSize: CGRect = UIScreen.main.bounds
            let rect = CGRect(x: 0, y: -16, width: screenSize.width, height: 134)
        
            storyView = StoryView(frame: rect, favorite: false)
            storyView.translatesAutoresizingMaskIntoConstraints = true
            // adding a point from where the reader will be shown
            storyView.target =  self
            // set delegate for layout of StoryView
            storyView.storiesDelegate = self

            storyView.storyCell = CustomStoryCell()
            storyView.deleagateFlowLayout = self
        
            self.view.addSubview(storyView)
            storyView.create()
    }
   
}



 extension SimpleIntegrationController
{
    // delegate method, called when the data is updated
    func storiesDidUpdated(isContent: Bool, from storyType: StoriesType)
    {
        guard let currentStoryView = storyView else {
            return
        }
        
        if currentStoryView.isContent {
            print("storiesDidUpdated")
            switch storyType {
            case .list:
                print("StoryView has content")
            case .single:
                print("SingleStory has content")
            case .onboarding:
                print("Onboarding has content")
            }
        } else {
            print("No content")
        }
    }
    
    // delegate method, called when a button or SwipeUp event is triggered in the reader
    // types is .button, .game, .deeplink, .swipe
     func storyReader(actionWith target: String, for type: ActionType, from storyType: StoriesType) {
        print("storyReader")
        if let url = URL(string: target.trimmingCharacters(in: .whitespaces)) {
            UIApplication.shared.open(url)
        }
     }
    
    // delegate method, called when the reader will show
    func storyReaderWillShow(with storyType: StoriesType)
    {
        print("storyReaderWillShow")
        switch storyType {
        case .list:
            print("StoryView reader will show")
        case .single:
            print("SingleStory reader will show")
        case .onboarding:
            print("Onboarding reader will show")
        }
    }
    
    // delegate method, called when the reader did close
    func storyReaderDidClose(with storyType: StoriesType)
    {
        print("storyReaderDidClose")
        switch storyType {
        case .list:
            print("StoryView reader did close")
        case .single:
            print("SingleStory reader did close")
        case .onboarding:
            print("Onboarding reader did close")
        }
    }
}

extension SimpleIntegrationController: StoryViewDelegateFlowLayout
{
    func sizeForItem() -> CGSize
    {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    func insetForSection() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
    }
    
    func minimumLineSpacingForSection() -> CGFloat
    {
        return 8.0
    }
    
    func minimumInteritemSpacingForSection() -> CGFloat
    {
        return 16.0
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


