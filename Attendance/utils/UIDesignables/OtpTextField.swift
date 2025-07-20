//
//  OtpTextField.swift
//  locksmith-user
//
//  Created by Dhruv Rawat on 13/12/24.
//

import UIKit

protocol DeleteTextProtocol: AnyObject {
    func textFieldDeleteDelegate(textField : UITextField)
}

class OtpTextField: UITextField {
    
    weak var deleteDelegate: DeleteTextProtocol?
    
    override func deleteBackward() {
        super.deleteBackward()
        deleteDelegate?.textFieldDeleteDelegate(textField: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAttributes()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setAttributes()
    }
    
    func setAttributes() {
        self.layer.cornerRadius = 8.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        self.textColor = UIColor.black
        let str = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ColorConstants.kHintText)!])
        self.attributedPlaceholder = str
        
        self.layer.borderColor = UIColor(named: ColorConstants.kHintBorder)?.cgColor
        self.layer.borderWidth = 0.9
        self.backgroundColor = UIColor.white
        
        self.font = UIFont(name: FontConstants.kSemiBold, size: 16)
        self.layer.masksToBounds = true
    }
}
