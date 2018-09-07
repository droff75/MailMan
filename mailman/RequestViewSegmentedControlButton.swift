import UIKit

enum RequestViewSegmentedControlButtonType {
    case headers, body
    
    var title: String {
        switch self {
        case .headers: return "Headers"
        case .body: return "Body"
        }
    }
}

class RequestViewSegmentedControlButton: UIButton {
    let type: RequestViewSegmentedControlButtonType
    init(type: RequestViewSegmentedControlButtonType) {
        self.type = type
        super.init(frame: .zero)
        
        setTitle(type.title, for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        setTitleColor(UIColor.black, for: .selected)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
