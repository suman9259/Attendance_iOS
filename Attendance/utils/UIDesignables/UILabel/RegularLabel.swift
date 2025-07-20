//
//  RegularLabel.swift
//  JobDash
//
//  Created by CodeAegis's Macbook Pro i9 on 03/04/25.
//

import UIKit

class RegularLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFont()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFont()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFont()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupFont()
    }
    
    private func setupFont() {
        if let fontName = UIFont(name: FontConstants.kRegular, size: self.font.pointSize) {
            self.font = fontName
        }
    }
}
