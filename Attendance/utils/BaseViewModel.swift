//
//  BaseViewModel.swift
//  JobDash
//
//  Created by CodeAegis's Macbook Pro i9 on 24/06/25.
//

import Foundation


class BaseViewModel {
    
    var onValidationError: ((String) -> Void)?
    var onApiFailure: ((ApiErrorModel) -> Void)?
    
}
