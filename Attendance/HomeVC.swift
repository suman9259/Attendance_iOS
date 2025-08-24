//
//  HomeVC.swift
//  Attendance
//
//  Created by CodeAegis's Macbook Pro i9 on 09/07/25.
//

import UIKit

class HomeVC: BaseVC, LocationDelegate {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var punchInView: UIView!
    @IBOutlet weak var punchOutView: UIView!
    
    private let viewmodel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationDelegate = self
        
        mainView.addShadow(cornerRadius: 8.0, shadowRadius: 4.0, shadowOpacity: 0.4)
        punchInView.roundCorner(radius: 8.0)
        punchOutView.roundCorner(radius: 8.0)
        
        //viewmodel.authenticateUserApi()
        
        setupViewModel()
        
        fetchCurrentLocation()
        
        addGestureForView(uiview: punchOutView, selector: #selector(punchoutViewTapped(gesture: )))
    }


    private func setupViewModel() {
        viewmodel.onApiFailure = { error in
            self.handleApiError(error: error)
        }
    }
    
    @objc func punchoutViewTapped(gesture: UITapGestureRecognizer) {
        _ = pushViewController(withName: PunchOutVC.id(), fromStoryboard: StoryBoardConstants.kMain)
    }
    
    func onLocationFetched(latitude: Double, longitude: Double) {
        print("latitude ::: \(latitude)  ::: \(longitude)")
    }
}
