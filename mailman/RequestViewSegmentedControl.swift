import UIKit

protocol RequestViewSegmentedControlDelegate: class {
    func headersButtonTapped()
    func bodyButtonTapped()
}

class RequestViewSegmentedControl: UISegmentedControl {    
    weak var delegate: RequestViewSegmentedControlDelegate?
    
    private let headersButton = RequestViewSegmentedControlButton(type: .headers)
    private let bodyButton = RequestViewSegmentedControlButton(type: .body)
    private let buttons: [RequestViewSegmentedControlButton]


    init() {
        buttons = [headersButton, bodyButton]
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButtons() {
        resetSelected()
        headersButton.isSelected = true
        buttons.forEach { (button) in
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        }
    }
    
    private func resetSelected() {
        buttons.forEach { $0.isSelected = false }
    }
    
    @objc private func buttonTapped(button: RequestViewSegmentedControlButton) {
        if !button.isSelected {
            resetSelected()
            button.isSelected = true
            switch button.type {
            case .headers:
                delegate?.headersButtonTapped()
            case .body:
                delegate?.bodyButtonTapped()
            }
        }
    }
    
}
