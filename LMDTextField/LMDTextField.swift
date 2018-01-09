//
//  LMDTextField.swift
//  Lemonade
//
//  Created by Tal Cohen on 07/01/2018.
//  Copyright © 2018 Lemonade. All rights reserved.
//

import UIKit

open class LMDTextField: UITextField {
    
    fileprivate enum State {
        case disabled
        case editing
        case notEditing
    }
    
    fileprivate var lmd_state : State = .notEditing {
        didSet {
            self.animatePlaceholderIfNeeded(with: lmd_state, previousState: oldValue)
        }
    }
    
    fileprivate weak var lmd_placeholder: UILabel!
    fileprivate let textRectYInset : CGFloat = 7
    fileprivate var editingConstraints = [NSLayoutConstraint]()
    fileprivate var notEditingConstraints : [NSLayoutConstraint]!
    
    //MARK: - PUBLIC VARIABLES
    public var placeholderFont = UIFont.systemFont(ofSize: 14, weight: .light) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var placeholderText: String? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public  var placeholderSizeFactor: CGFloat = 0.7  {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public  var themeColor: UIColor? = UIColor(red: 1, green: 0, blue: 131/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var placeholderTextColor: UIColor = UIColor(white: 183/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var textFieldTextColor: UIColor = UIColor(white: 74/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var topPadding: CGFloat = 6
    @IBInspectable public var leftPadding: CGFloat = 14
    
    //MARK: - LIFE CYCLE
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    fileprivate func setupViews() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        self.addTarget(self, action: #selector(editingDidBegin), for: UIControlEvents.editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: UIControlEvents.editingDidEnd)
        
        let placeholder = UILabel()
        
        placeholder.layoutMargins = .zero
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeholder)
        
        self.lmd_placeholder = placeholder
        
        self.notEditingConstraints = [
            self.lmd_placeholder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding),
            self.lmd_placeholder.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        self.animatePlaceholderIfNeeded(with: .notEditing, previousState: nil)
    }
    
    fileprivate func calculateEditingConstraints() {
        let originalWidth = self.lmd_placeholder.frame.width
        let xOffset = (originalWidth - (originalWidth * placeholderSizeFactor)) / 2
        
        self.editingConstraints = [
            self.lmd_placeholder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -xOffset + self.leftPadding),
            self.lmd_placeholder.topAnchor.constraint(equalTo: self.topAnchor, constant: self.topPadding)
        ]
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.lmd_placeholder.font = self.placeholderFont
        self.lmd_placeholder.textColor = self.placeholderTextColor
        self.lmd_placeholder.text = self.placeholderText?.uppercased()
        self.textColor = self.lmd_state == .disabled ? UIColor(white: 183/255, alpha: 1) : self.textFieldTextColor
        self.tintColor = self.themeColor
        self.backgroundColor = self.lmd_state == .disabled ? UIColor(white: 247/255, alpha: 1) : .white
        self.layer.borderColor = self.lmd_state == .editing ?
            self.themeColor?.cgColor :
            UIColor(white: 236/255, alpha: 1).cgColor
        self.isEnabled = self.lmd_state != .disabled
    }
    
    fileprivate func animatePlaceholderIfNeeded(with state: State, previousState: State?) {
        guard state != previousState else { return }
        switch state {
        case .disabled:
            break
            
        case .editing:
            if previousState == .notEditing && self.text?.isEmpty == true {
                self.animatePlaceholderToActivePosition()
            }
            
        case .notEditing:
            if (previousState == .editing || previousState == nil) &&
                self.text?.isEmpty == true {
                self.animatePlaceholderToInactivePosition()
            }
        }
        self.setNeedsLayout()
    }
    
    fileprivate func animatePlaceholderToActivePosition() {
        self.layoutIfNeeded()
        NSLayoutConstraint.deactivate(self.notEditingConstraints)
        self.calculateEditingConstraints()
        NSLayoutConstraint.activate(self.editingConstraints)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
            self.lmd_placeholder.transform = CGAffineTransform(scaleX: self.placeholderSizeFactor, y: self.placeholderSizeFactor)
        }
    }
    
    fileprivate func animatePlaceholderToInactivePosition() {
        NSLayoutConstraint.deactivate(self.editingConstraints)
        NSLayoutConstraint.activate(self.notEditingConstraints)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
            self.lmd_placeholder.transform = .identity
        }
    }
    
    @objc private func editingDidBegin() {
        self.lmd_state = .editing
    }
    
    @objc private func editingDidEnd() {
        self.lmd_state = .notEditing
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        let point = CGPoint(x: leftPadding,
                            y: bounds.origin.x + self.textRectYInset)
        return CGRect(origin: point, size: bounds.size)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        let point = CGPoint(x: leftPadding,
                            y: bounds.origin.x + self.textRectYInset)
        return CGRect(origin: point, size: bounds.size)
    }
    
    //MARK: - PUBLIC FUNCTIONS
    public func disable() {
        self.lmd_state = .disabled
    }
    
    public func enable() {
        self.lmd_state = .notEditing
    }
    
}

