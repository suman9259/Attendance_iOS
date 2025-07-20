//
//  CustomButton.swift
//  locksmith-user
//
//  Created by Dhruv Rawat on 12/12/24.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        backgroundColor     = UIColor(named: ColorConstants.kBlue)
        layer.cornerRadius  = frame.height / 2
        titleLabel?.font    = UIFont(name: FontConstants.kSemiBold, size: 16)
        setTitleColor(.white, for: .normal)
    }
    
    func updateView() {
        layer.cornerRadius  = 8.0
        titleLabel?.font    = UIFont(name: FontConstants.kMedium, size: 12)
    }
}
