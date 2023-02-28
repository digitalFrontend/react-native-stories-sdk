//import UIKit
//import InAppStorySDK
//
//class NativeCustomView: UIView {
//
//private var storyView: StoryView!
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//      setupView(frame: frame)
//  }
//    required init?(coder aDecoder: NSCoder) {
//      super.init(coder: aDecoder)
//    }
//
//    private func setupView(frame: CGRect) {
////        InAppStory.shared.settings = Settings(userID: "11111")
//    // set background color received from react native
//        self.backgroundColor = .red
//        self.contentMode = .scaleToFill
//        self.addSubview(SimpleIntegrationController().self.view)
////        viewDidLoad()
//  }
//
////    func viewDidLoad() {
////        guard let rootVC = UIApplication.shared.delegate?.window??.visibleViewController, (rootVC.navigationController != nil) else {
////                         return
////                    }
////
////        storyView = StoryView(frame:.zero, feed: "", favorite:false)
////        storyView.target = rootVC
////
////        rootVC.view.addSubview(storyView)
////
////        storyView.create()
////    }
//
//  // when the view is clicked, send click event with some data to react native
//
//}


//public extension UIWindow {
//
//    var visibleViewController: UIViewController? {
//        self.window?.makeKeyAndVisible()
//        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
//    }
//
//    static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
//        if let nc = vc as? UINavigationController {
//            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
//        } else if let tc = vc as? UITabBarController {
//            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
//        } else {
//            if let pvc = vc?.presentedViewController {
//                return UIWindow.getVisibleViewControllerFrom(pvc)
//            } else {
//                return vc
//            }
//        }
//    }
//}
