import UIKit

class TextPopoverViewController: UIViewController {    
    private let popoverText: String?
    
    init(popoverText: String?) {
        self.popoverText = popoverText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = TextPopoverView(text: popoverText)
    }
}
