  import Foundation
  import UIKit
  
  public class SampleView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initAppearance()
    }
    
    private func initAppearance() {
        self.backgroundColor = .white
    }
  }
