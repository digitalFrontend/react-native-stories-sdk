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
    
    override func viewDidLoad() {
        print("SimpleIntegrationController 2")
//        for family: String in UIFont.familyNames
//               {
//                   print(family)
//                   for names: String in UIFont.fontNames(forFamilyName: family)
//                   {
//                       print("== \(names)")
//                   }
//               }
        super.viewDidLoad()

           // setupInAppStory
            print("SimpleIntegrationController 3")
        InAppStory.shared.cellFont = UIFont(name: "Tele2TextSansSHORT-Bold", size: 10)!
        InAppStory.shared.cellBorderRadius = CGFloat(12.0)
        InAppStory.shared.showCellTitle = false
        InAppStory.shared.coverQuality = .high

            // setup InAppStorySDK for user with ID
        DispatchQueue.main.async {
            guard let rootVC = UIApplication.shared.delegate?.window??.visibleViewController, (rootVC.navigationController != nil) else {
                                         return
                                    }
            rootVC.addChild(self)
        }
       

           // setupStoryView
            print("SimpleIntegrationController 4, ")
            // create instance of StoryView
            let screenSize: CGRect = UIScreen.main.bounds
            let rect = CGRect(x: 0, y: -16, width: screenSize.width, height: 134)
        
            storyView = StoryView(frame: rect, favorite: false)
            storyView.translatesAutoresizingMaskIntoConstraints = true
            storyView.storyCell.backgroundColor = .none
        
            // adding a point from where the reader will be shown
            storyView.target =  self
            storyView.storiesDelegate = self
        
            // set delegate for layout of StoryView
            storyView.deleagateFlowLayout = self
   
            
//            var allConstraints: [NSLayoutConstraint] = []
//
//            NSLayoutConstraint.activate(allConstraints)
            
            // running internal StoryView logic
            
            storyView.create()
        
            self.view.addSubview(storyView)
    }
}

//extension SimpleIntegrationController
//{
//
//     func setupInAppStory()
//    {
//        print("SimpleIntegrationController 3")
//        // setup InAppStorySDK for user with ID
//        InAppStory.shared.settings = Settings(userID: "11111")
//        InAppStory.shared.cellFont =
//    }
//
//     func setupStoryView()
//    {
//        guard let rootVC = UIApplication.shared.delegate?.window??.visibleViewController, (rootVC.navigationController != nil) else {
//                return
//            }
//        let topController = UIApplication.topViewController()
//        print("SimpleIntegrationController 4, ")
//        // create instance of StoryView
//        let screenSize: CGRect = UIScreen.main.bounds
//        let rect = CGRect(x: 0, y: 0, width: screenSize.width, height: 100)
//        storyView = StoryView(frame: rect, favorite: false)
//
//        storyView.translatesAutoresizingMaskIntoConstraints = true
//        // adding a point from where the reader will be shown
//        storyView.target = topController
//        // set StoryView delegate
//        storyView.storiesDelegate = self
//
//        self.view.addSubview(storyView)
//
//        var allConstraints: [NSLayoutConstraint] = []
//        let horConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[storyView]-(0)-|",
//                                                           options: [.alignAllLeading, .alignAllTrailing],
//                                                           metrics: nil,
//                                                           views: ["storyView": storyView!])
//        allConstraints += horConstraint
//        let vertConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[storyView(150)]",
//                                                            options: [.alignAllTop, .alignAllBottom],
//                                                            metrics: nil,
//                                                            views: ["storyView": storyView!])
//        allConstraints += vertConstraint
//        NSLayoutConstraint.activate(allConstraints)
//
//        // running internal StoryView logic
//        storyView.create()
//    }
//}

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
        if let url = URL(string: target) {
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
        return UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 8.0)
    }
    
    func minimumLineSpacingForSection() -> CGFloat
    {
        return 0
    }
    
    func minimumInteritemSpacingForSection() -> CGFloat
    {
        return 4.0
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


