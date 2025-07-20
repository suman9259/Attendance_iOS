//
//  CustomTextField.swift
//  locksmith-serviceprovider
//
//  Created by Dhruv Rawat on 16/12/24.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.autocapitalizationType = .sentences   // 🔥 Move this here
        self.keyboardType = .default
        self.autocorrectionType = .yes
        
        self.setAttributes()
    }
    
    func setAttributes() {
        self.layer.cornerRadius = 10.0
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
        self.textColor = UIColor.black
        self.layer.borderColor = UIColor(named: ColorConstants.kHintBorder)?.cgColor
        self.layer.borderWidth = 0.9
        self.alpha = 0.9
        self.font = UIFont(name: FontConstants.kMedium, size: 15)
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        
        setPlaceholder(placeholder: self.placeholder ?? "", font: UIFont(name: FontConstants.kMedium, size: 15)!)
    }
    
    func updatePadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.setNeedsLayout()
    }
    
    func setPlaceholder(placeholder: String, font: UIFont) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: ColorConstants.kHintText) ?? UIColor.black,
            .font: font
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    var padding = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 20)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func setSearchTextField() {
        self.layer.cornerRadius = frame.size.height / 2
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
        self.textColor = UIColor.black
        self.layer.borderColor = UIColor(named: ColorConstants.kMintLight)?.cgColor
        self.layer.borderWidth = 0.9
        self.alpha = 0.9
        self.font = UIFont(name: FontConstants.kMedium, size: 15)
        self.backgroundColor = UIColor(named: ColorConstants.kMint)
        self.layer.masksToBounds = true
        
        setPlaceholder(placeholder: self.placeholder ?? "", font: UIFont(name: FontConstants.kMedium, size: 15)!)
    }
    
    
}


