  import UIKit
  import PlaygroundSupport
  
  // View controller that hosts the target view
  class TDLiveViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Config background view
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        
        // Label location
        let viewWidth: CGFloat = 200.0
        let viewHeight: CGFloat = 200.0
        var viewX: CGFloat { get { return self.view.frame.width / 2 - viewWidth / 2 } }
        var viewY: CGFloat { get { return self.view.frame.height / 2 - viewHeight / 2 } }
        
        // Config sample view
        let placeholderTextView = TDSwiftPlaceholderTextView(frame: CGRect(x: viewX, y: viewY, width: viewWidth, height: viewHeight))
        backgroundView.addSubview(placeholderTextView)
        
        // Dismiss keyboard handler
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        
        // Present background view
        self.view = backgroundView
    }
    
    @objc private func dismissKeyboard() { self.view.endEditing(true) }
  }
  
  // Present the view controller in the Live View window
  PlaygroundPage.current.liveView = TDLiveViewController()
