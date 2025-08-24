//
//  SplashVC.swift
//  Attendance
//
//  Created by CodeAegis's Macbook Pro i9 on 09/07/25.
//

import UIKit

class SplashVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

       
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            _ = self.pushViewController(withName: HomeVC.id(), fromStoryboard: StoryBoardConstants.kMain)
//        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let miniApp = ModuleNameMiniApp()
            miniApp.launch(presenter: self, data: ModuleNameAbsherHelper())
        })
    }

}
