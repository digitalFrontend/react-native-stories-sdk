//
//  SimpleIntegrationController.swift
//  InAppStoryExample
//

import UIKit
import AVFoundation
import InAppStorySDK

class CustomStoryCell: UICollectionViewCell
{
//    required init(coder aDecoder: NSCoder) {
//         super.init(coder: aDecoder)
//         NSBundle.mainBundle().loadNibNamed("SomeView", owner: self, options: nil)
//         self.addSubview(self.view);    // adding the top level view to the view hierarchy
//      }
    // reuseIdentifier of cell
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // nib of cell, if cell created in .xib file
    static var nib: UINib? {
            // let bundle = Bundle(for: self.classForCoder())
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        //UINib(nibName: "CustomStoryCell", bundle: bundle)
        //bundle.loadNibNamed("CustomStoryCell", owner: nil, options: nil)?.first as? UINib
         
    }
    
    var storyID: String!
    
    // player for video cover
    fileprivate let player = AVPlayer()
    fileprivate var playerLayer: AVPlayerLayer!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
       
    override func prepareForReuse() {
        super.prepareForReuse()
        

        imageView.image = nil
        titleLabel.text = ""
        videoView.isHidden = true
    }
    
    // set start cell style
    override func awakeFromNib() {
        super.awakeFromNib()
//            layer.borderColor =  UIColor.black.cgColor
//            layer.borderWidth = 1.5
//            layer.shadowOpacity = 1
//
//
//        containerView.layer.masksToBounds = false

        containerView.layer.cornerRadius = 16
        let blurEffectView = UIView()
        blurEffectView.backgroundColor = .white
        blurEffectView.frame = containerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(blurEffectView)
        
        titleLabel.font = UIFont(name: "Tele2TextSansSHORT-Bold", size: 10)!
        titleLabel.textColor = .black
        
        if playerLayer == nil {
            player.isMuted = true
            
            if #available(iOS 12.0, *) {
                // fixes "autolock" blocking due to video loop
                player.preventsDisplaySleepDuringVideoPlayback = false
            }
            
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = videoView.frame
            playerLayer.videoGravity = .resizeAspectFill
            videoView.layer.addSublayer(playerLayer)
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        // update vidoe frame for cover
        if playerLayer != nil {
            playerLayer.frame = videoView.frame
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension CustomStoryCell: StoryCellProtocol
{
    // title of cell
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    // image url for cover
    func setImageURL(_ url: URL) {
        imageView.image = nil
        imageView.tag = Int(String("\(Int(Date().timeIntervalSince1970 * 1000000))".dropFirst(8)))!
        imageView.downloadedFrom(url: url, contentMode: .scaleAspectFill, withViewTag: imageView.tag)
    }
    
    // video url for animated cover
    func setVideoURL(_ url: URL) {
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        
        // loop video
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
            guard let weakSelf = self, !weakSelf.videoView.isHidden else {
                return
            }
            
            weakSelf.player.seek(to: CMTime.zero)
            weakSelf.player.play()
        }
        
        player.play()
        
        videoView.isHidden = false
    }
    
    // set new state if story is opened
    func setOpened(_ value: Bool) {
        // containerView.sub backgroundColor = UIColor.white.withAlphaComponent(0.5)
        let whiteSubview = containerView.subviews.first{$0.backgroundColor == .white}//?.alpha = value ? 0.4 : 0
        whiteSubview?.alpha = value ? 0.4 : 0
//        let blurEffectView = UIView()
//        blurEffectView.backgroundColor = .white
//        blurEffectView.alpha = value ? 0.4 : 0
//        blurEffectView.frame = containerView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        containerView.addSubview(blurEffectView)
    }
    
    // set new state if story cell if highlighted
    func setHighlight(_ value: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.containerView.alpha = value ? 0.7 : 1.0
        }
    }
    
    // set background color of cell
    func setBackgroundColor(_ color: UIColor) {
        imageView.backgroundColor = color
    }
    
    // set title color of cell
    func setTitleColor(_ color: UIColor) {
        titleLabel.textColor = color
    }
    
    // does the story have sound
    func setSound(_ value: Bool) {}
}
