//
//  ToolbarView.swift
//  mailman
//
//  Created by david.roff on 8/23/18.
//  Copyright © 2018 droff.dev.llc. All rights reserved.
//

import UIKit

class ToolbarView: UIView {
    private let newButton = UIButton()
    private let importButton = UIButton()
    private let stackView = UIStackView()
    private let labelView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newButton.setTitle("New", for: .normal)
        newButton.backgroundColor = .orange
        newButton.addTarget(self, action: #selector(newButtonTapped), for: .touchUpInside)
        newButton.layer.cornerRadius = 5

        importButton.setTitle("Import", for: .normal)
        importButton.backgroundColor = .gray
        importButton.layer.cornerRadius = 5

        labelView.text = "MailMan App"
        labelView.textColor = .white
        labelView.font = UIFont.systemFont(ofSize: 30)
        
        addSubview(labelView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(newButton)
        stackView.addArrangedSubview(importButton)
        stackView.setCustomSpacing(10, after: newButton)
        
        newButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        importButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    private func newButtonTapped() {
        
    }
    
    
}
