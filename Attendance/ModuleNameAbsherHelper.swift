//
//  ModuleNameAbsherHelper.swift
//  Attendance
//
//  Created by Prince on 22/08/25.
//


import SwiftUI
import InteriorAbsherSDK

public class ModuleNameAbsherHelper: IAbsherHelper {
    public func getUserToken() -> AbsherResponse<String> {
        return AbsherResponse(success: true, data: "token_from_miniapp")
    }
    
    public func getUserFullNameAr() -> AbsherResponse<String> {
        return AbsherResponse(success: true, data: "المستخدم")
    }
}

public class ModuleNameMiniApp: IMiniApp {
    public func launch(presenter: UIViewController, data: any IAbsherHelper) {
        // Apply the helper (token, username, etc.)
        AbsherService.applyHelper(data)

        // Wrap your SwiftUI view in a hosting controller
        let hostingVC = UIHostingController(rootView: HomeView())
        hostingVC.view.backgroundColor = .clear
        hostingVC.modalPresentationStyle = .fullScreen
        presenter.present(hostingVC, animated: true)
    }
}

