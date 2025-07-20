//
//  fileextensions.swift
//  locksmith-user
//
//  Created by Dhruv Rawat on 12/12/24.
//

import Foundation
import UIKit


extension UIViewController {
    
    static func id() -> String {
        return String(describing: self)
    }
    
    static func segueIdentifier() -> String {
        
        return "show" + String(describing: self)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension UICollectionViewCell{
    
    static func identifier() -> String{
        return String(describing: self)
    }
}

extension UITableViewCell{
    
    static func identifier() -> String{
        return String(describing: self)
    }
}

extension String {
    
    static func getString(_ message: Any?) -> String {
        
        guard let strMessage = message as? String else {
            guard let doubleValue = message as? Double else {
                guard let intValue = message as? Int else {
                    guard let int64Value = message as? Int64 else {
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 6
            formatter.minimumIntegerDigits = 1
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
                return ""
            }
            return formattedNumber
        }
        return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
    }
    
    func stringByTrimmingWhiteSpaceAndNewLine() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    var isNullOrEmpty : Bool {
        return self == nil || self.isEmpty == true
    }
}


extension UIView {
    
    func addShadow(cornerRadius : CGFloat, shadowRadius : CGFloat, shadowOpacity : Float, shadowColor : CGColor? = nil) {
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowColor = shadowColor ?? UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func addBottomShadow(shadowRadius : CGFloat, shadowOpacity : Float, shadowColor : UIColor) {
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
    }
    
    func addTopShadow(cornerRadius : CGFloat, shadowRadius : CGFloat, shadowOpacity : Float, shadowColor : UIColor) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: -2)
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = shadowOpacity
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func colouredRoundCorner(borderRadius : CGFloat, borderColor : UIColor, borderWidth : CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = borderRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func colouredLeftCorner(borderRadius : CGFloat, borderColor : UIColor, borderWidth : CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = borderRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func roundCorner(radius : CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func roundedRightCorner(radius : CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func roundedLeftCorner(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func topRoundedCorner(radius : CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func bottomRoundCorner(radius : CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func toastAnimation(duration: TimeInterval = 3.0) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.fadeOut()
            }
        })
    }
    
    func fadeOut(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func hideView() {
        self.isHidden = true
        self.alpha = 0
    }
    
    func showView() {
        self.isHidden = false
        self.alpha = 1
    }
}

extension Int
{
    static func getInt(_ value: Any?) -> Int {
        
        guard let intValue = value as? Int else {
            let strInt = String.getString(value)
            guard let intValueOfString = Int(strInt) else { return 0 }
            return intValueOfString
        }
        return intValue
    }
    
    func toString() -> String {
        
        return String(describing:self)
    }

    func getString() -> String{
        return "\(self)"
    }
}


extension UIAlertController {
    
    static func didShowOkAlert(alertMessage message: String, andHandler handler:@escaping () -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: AlertConstants.kAppName, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
            return handler()
        }
        alert.addAction(okAction)
        
        return alert
    }
}



