import UIKit

class NativeCustomView: UIView {

  @objc var message: String? = "Hello Native Custom View" {
    didSet {
      self.setupView()
    }
  }
  
  @objc var bgColor: String? {
    didSet {
      self.setupView()
    }
  }

  @objc var onClick: RCTBubblingEventBlock?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  private func hexStringToUIColor (hex:String) -> UIColor {
      var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

      if (cString.hasPrefix("#")) {
          cString.remove(at: cString.startIndex)
      }

      if ((cString.count) != 6) {
          return UIColor.gray
      }

      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)

      return UIColor(
          red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
          green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
          blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
          alpha: CGFloat(1.0)
      )
  }
  
  private func setupView() {
    // set background color received from react native
    self.backgroundColor = (self.bgColor != nil) ? hexStringToUIColor(hex: self.bgColor!) : .red

    // make the view clickable
    self.isUserInteractionEnabled = true
    
    // add a text view and set the message received from react native
    let textView = UITextView()
    textView.center = self.center
    textView.textAlignment = NSTextAlignment.center
    textView.textColor = UIColor.blue
    textView.backgroundColor = UIColor.lightGray
    textView.text = self.message
    textView.isEditable = false
    textView.sizeToFit()
    self.addSubview(textView)

    // center the text view
    textView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textView.widthAnchor.constraint(equalToConstant: 260),
      textView.heightAnchor.constraint(equalToConstant: 30),
      textView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      textView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }

  // when the view is clicked, send click event with some data to react native
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let onClick = self.onClick else { return }

    let params: [String : Any] = ["receivedBgColor":self.bgColor,"receivedMessage": self.message, "response":"hey, you've touched screen."]
    onClick(params)
  }

}
