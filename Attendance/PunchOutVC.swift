//
//  PunchOutVC.swift
//  Attendance
//
//  Created by CodeAegis's Macbook Pro i9 on 09/07/25.
//

import UIKit
import AWSCore
import AWSRekognition
import SVProgressHUD

class PunchOutVC: BaseVC, ImageDelegate {

    
    @IBOutlet weak var btnBack: UIImageView!
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var imgPreview: UIImageView!
    
    @IBOutlet weak var btnCapture: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAWS()
        imageDelegate = self
        preview.colouredRoundCorner(borderRadius: 8.0, borderColor: UIColor.lightGray, borderWidth: 0.9)
    }
    
    private func configureAWS() {
        
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: .USEast1,
            identityPoolId: "us-east-1:2f9d3c4f-b428-4c05-9478-5163fae204ef"
        )

        let configuration = AWSServiceConfiguration(
            region: .USEast1,
            credentialsProvider: credentialsProvider
        )

        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    func onImageSelected(image: UIImage) {
        detectFaces(image: image)
        imgPreview.image = image
        showProgressHUD()
    }
    
    private func detectFaces(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            return
        }

        let rekognitionImage = AWSRekognitionImage()
        rekognitionImage?.bytes = imageData

        let request = AWSRekognitionDetectFacesRequest()
        request?.image = rekognitionImage
        request?.attributes = ["ALL"]

        let rekognitionClient = AWSRekognition.default()

        rekognitionClient.detectFaces(request!) { response, error in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if let error = error {
                    self.showToast(withMessage: "Face detection failed")
                    return
                }

                if let faceDetails = response?.faceDetails, !faceDetails.isEmpty {
                    self.btnCapture.isEnabled = false
                    self.showToast(withMessage: "Face Detected")
                } else {
                    self.showToast(withMessage: "No Face Detected. Try Again!!")
                }
            }
        }
    }
    
    private func showProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.show()
    }
    
    
    @IBAction func btnTakeSelfieTapped(_ sender: Any) {
        self.openImagePicker(withSourceType: .camera, mediaType: .image)
    }
    
    @objc func backBtnTapped(gesture: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
}
