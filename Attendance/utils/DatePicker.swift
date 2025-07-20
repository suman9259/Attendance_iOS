//
//  DatePicker.swift
//  qootuma
//
//  Created by Dhruv Rawat on 27/09/24.
//

import Foundation
import UIKit


let datePickerTopMargin: CGFloat = 0

class DatePicker: UIView {
    
    //MARK: ----------------Closures----------------
    private var callBack = {(response: Any?) -> () in}
    
    //MARK: ----------------Public Variables----------------
    var pickerView: UIDatePicker!
    var viewContainer: UIView!
    
    //MARK: ----------------Initializer Methods----------------
    convenience init(view: UIView, pickerMode mode: UIDatePicker.Mode, withHeaderTitle title: String, handler completionBlock: @escaping (_ response: Any?) -> ()) {
        
        let rect = view.bounds
        self.init(frame: rect)
        
        let viewHt = rect.size.height
        let cHt = 201
        let yValue = viewHt - CGFloat(cHt) - datePickerTopMargin
        
        viewContainer = UIView(frame: CGRect(x: 0, y: viewHt, width: FunctionsConstants.kScreenWidth, height: CGFloat(cHt)))
        
        pickerView = UIDatePicker(frame: CGRect(x: 60, y: 35, width: FunctionsConstants.kScreenWidth, height: 162))
        pickerView.date = Date()
        pickerView.datePickerMode = mode
        
        // Force 12-hour format
        pickerView.locale = Locale(identifier: "en_US_POSIX")
        
        if #available(iOS 13.4, *) {
            pickerView.preferredDatePickerStyle = .wheels
        }
        
        viewContainer.addSubview(pickerView)
        
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: FunctionsConstants.kScreenWidth, height: 35))
        viewHeader.backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        
        let btnCancel = getButton(xValue: 1.0, buttonTitle: "Cancel")
        viewHeader.addSubview(btnCancel)
        
        let lblHeaderTitle = UILabel(frame: CGRect(x: FunctionsConstants.kScreenWidth / 4, y: 0, width: FunctionsConstants.kScreenWidth / 2, height: 35))
        lblHeaderTitle.text = title
        lblHeaderTitle.textAlignment = .center
        viewHeader.addSubview(lblHeaderTitle)
        
        let btnDone = getButton(xValue: FunctionsConstants.kScreenWidth - 71.0, buttonTitle: "Done")
        viewHeader.addSubview(btnDone)
        
        viewContainer.addSubview(viewHeader)
        self.addSubview(viewContainer)
        
        view.addSubview(self)
        callBack = completionBlock
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options: .beginFromCurrentState, animations: {
            var frame = self.viewContainer.frame
            frame.origin.y = yValue
            self.viewContainer.frame = frame
        }, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ---------------Private Methods---------------
    private func getButton(xValue: CGFloat, buttonTitle title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: xValue, y: 1, width: 70, height: 35)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        
        if (title == "Cancel") {
            button.addTarget(self, action: #selector(tapCancel(sender:)), for: .touchUpInside)
        }
        else {
            button.addTarget(self, action: #selector(tapDone(sender:)), for: .touchUpInside)
        }
        return button
    }
    
    //MARK: ---------------Public Methods---------------
    func setMinimumDate(date: Date) {
        pickerView.minimumDate = date
    }
    
    func setMaximumDate(date: Date) {
        pickerView.maximumDate = date
    }
    
    func setCurrentDate(date: Date) {
        pickerView.date = date
    }
    
    func setDate(date: Date) {
        pickerView.setDate(date, animated: false)
    }
    
    //MARK: ---------------IBAction Methods---------------
    @objc func tapCancel(sender: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .beginFromCurrentState, animations: {
            var frame = self.viewContainer.frame
            frame.origin.y = self.frame.size.height
            self.viewContainer.frame = frame
        }) { (finished) in
            self.callBack(nil)
            self.removeFromSuperview()
        }
    }
    
    @objc func tapDone(sender: UIButton) {
        UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options: .beginFromCurrentState, animations: {
            var frame = self.viewContainer.frame
            frame.origin.y = self.frame.size.height
            self.viewContainer.frame = frame
        }) { (finished) in
            if finished {
                self.callBack(self.pickerView.date)
                self.removeFromSuperview()
            }
        }
    }
}
