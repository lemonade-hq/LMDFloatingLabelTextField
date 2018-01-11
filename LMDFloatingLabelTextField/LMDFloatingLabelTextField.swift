//
//  LMDTextField.swift
//  Lemonade
//
//  Created by Tal Cohen on 07/01/2018.
//  Copyright © 2018 Lemonade. All rights reserved.
//

import UIKit

open class LMDFloatingLabelTextField: UITextField {
    
    public enum State {
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
    public var placeholderFont = UIFont.systemFont(ofSize: 14) {
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
    
    @IBInspectable public  var borderColor: UIColor? = UIColor(white: 74/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public  var errorBorderColor: UIColor? = UIColor(red: 1, green: 0, blue: 131/255, alpha: 1) {
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
    
    @IBInspectable public var disabledTextColor: UIColor = UIColor(white: 183/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var disabledBackgroundColor: UIColor = UIColor(white: 247/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var enabledBackgroundColor: UIColor = .white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var error = false {
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
        if #available(iOS 11.0, *) {
            placeholder.insetsLayoutMarginsFromSafeArea = false
        }
        self.addSubview(placeholder)
        
        self.lmd_placeholder = placeholder
        
        self.notEditingConstraints = [
            NSLayoutConstraint(item: self.lmd_placeholder, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: self.leftPadding),
            NSLayoutConstraint(item: self.lmd_placeholder, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        ]
        
        self.animatePlaceholderIfNeeded(with: .notEditing, previousState: nil)
    }
    
    fileprivate func calculateEditingConstraints() {
        let originalWidth = self.lmd_placeholder.frame.width
        let xOffset = (originalWidth - (originalWidth * placeholderSizeFactor)) / 2
        
        self.editingConstraints = [
            NSLayoutConstraint(item: self.lmd_placeholder, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: -xOffset + self.leftPadding),
            NSLayoutConstraint(item: self.lmd_placeholder, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: self.topPadding)
        ]
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.tintColor = themeColor
        self.lmd_placeholder.font = self.placeholderFont
        self.lmd_placeholder.textColor = self.placeholderTextColor
        self.lmd_placeholder.text = self.placeholderText?.uppercased()
        self.textColor = self.lmd_state == .disabled ? self.disabledTextColor : self.textFieldTextColor
        self.backgroundColor = self.lmd_state == .disabled ? self.disabledBackgroundColor : self.enabledBackgroundColor
        self.layer.borderColor = self.error ? self.errorBorderColor?.cgColor : self.lmd_state == .editing ?
            self.borderColor?.cgColor :
            UIColor(white: 236/255, alpha: 1).cgColor
        self.isEnabled = self.lmd_state != .disabled
    }
    
    fileprivate func animatePlaceholderIfNeeded(with state: State, previousState: State?) {
        guard state != previousState else { return }
        switch state {
        case .disabled:
            break
            
        case .editing:
            if previousState == .notEditing && (self.text ?? "").isEmpty == true {
                self.animatePlaceholderToActivePosition()
            }
            
        case .notEditing:
            if (self.text ?? "").isEmpty == true {
                if previousState == .editing {
                    self.animatePlaceholderToInactivePosition()
                } else if previousState == nil {
                    self.animatePlaceholderToInactivePosition(animated: false)
                }
            }
        }
        self.setNeedsLayout()
    }
    
    fileprivate func animatePlaceholderToActivePosition(animated: Bool = true) {
        NSLayoutConstraint.deactivate(self.notEditingConstraints)
        self.calculateEditingConstraints()
        NSLayoutConstraint.activate(self.editingConstraints)
        let animationBlock = {
            self.layoutIfNeeded()
            self.lmd_placeholder.transform = CGAffineTransform(scaleX: self.placeholderSizeFactor, y: self.placeholderSizeFactor)
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                animationBlock()
            }
        } else {
            animationBlock()
        }
    }
    
    fileprivate func animatePlaceholderToInactivePosition(animated: Bool = true) {
        NSLayoutConstraint.deactivate(self.editingConstraints)
        NSLayoutConstraint.activate(self.notEditingConstraints)
        let animationBlock = {
            self.layoutIfNeeded()
            self.lmd_placeholder.transform = .identity
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                animationBlock()
            }
        } else {
            animationBlock()
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
        return self.calculateTextRect(forBounds: bounds)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return self.calculateTextRect(forBounds: bounds)
    }
    
    fileprivate func calculateTextRect(forBounds bounds: CGRect) -> CGRect {
        let textInset = (self.placeholderText ?? "").isEmpty == true ? 0 : self.textRectYInset
        return CGRect(x: leftPadding,
                      y: textInset,
                      width: bounds.width - (leftPadding * 2),
                      height: bounds.height)
    }
    
    //MARK: - PUBLIC FUNCTIONS
    public func updateState(_ state: State) {
        self.lmd_state = state
    }
    
}
