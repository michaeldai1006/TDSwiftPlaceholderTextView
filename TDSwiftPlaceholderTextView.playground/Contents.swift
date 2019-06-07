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
  
  public class TDSwiftPlaceholderTextView: UITextView {
    // Place holder info
    var placeHolderText = "Some Placeholder" {
        didSet { if isPresentingPlaceHolder { self.text = placeHolderText } }
    }
    private var placeHolderTextColor: UIColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.0)
    
    // Normal text info
    var normalText: String!
    var normalTextColor: UIColor!
    
    func setText(text: String) {
        if !self.text.isEmpty {
            self.normalText = text
            self.text = text
            self.textColor = self.normalTextColor
            
            self.isPresentingPlaceHolder = false
        }
    }
    
    public init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        setupDelegate()
        initAppearance()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDelegate()
        initAppearance()
    }
    
    private var isPresentingPlaceHolder: Bool!
    
    private func initAppearance() {
        if self.text.isEmpty {
            self.normalText = ""
            self.normalTextColor = self.textColor
            
            self.text = self.placeHolderText
            self.textColor = self.placeHolderTextColor
            
            self.isPresentingPlaceHolder = true
        } else {
            self.normalText = self.text
            self.normalTextColor = self.textColor
            
            self.isPresentingPlaceHolder = false
        }
    }
    
    private func setupDelegate() {
        self.delegate = self
    }
  }
  
  extension TDSwiftPlaceholderTextView: UITextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.text = self.normalText
        self.textColor = self.normalTextColor
        
        self.isPresentingPlaceHolder = false
        
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.normalText = self.text
        self.normalTextColor = self.textColor
        
        if self.text.isEmpty {
            self.text = self.placeHolderText
            self.textColor = self.placeHolderTextColor
            
            self.isPresentingPlaceHolder = true
        }
        
        return true
    }
  }
  
  // Present the view controller in the Live View window
  PlaygroundPage.current.liveView = TDLiveViewController()
