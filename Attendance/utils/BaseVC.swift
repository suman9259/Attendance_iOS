//
//  BaseVC.swift
//  locksmith-user
//
//  Created by Dhruv Rawat on 12/12/24.
//

import UIKit
import CoreMedia
import CoreLocation
import MessageUI
import UniformTypeIdentifiers
import PDFKit

class BaseVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    lazy var imagePicker = UIImagePickerController()
    var imageDelegate : ImageDelegate?
    
    var locationManager = CLLocationManager()
    var locationDelegate : LocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func openWebpage(urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL or can't open")
        }
    }
    
    func openDialler(number: String) {
        let phoneNumber = "tel://\(number)"
        if let url = URL(string: phoneNumber) {
            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                if !success {
                    print("Failed to open the dialer.")
                }
            })
        }
    }
    
    func openEmail(email : String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients([email])
            
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            print("Cannot send mail")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func pushViewController(withName name: String, fromStoryboard storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }
    
    func pushViewController(withName name: String, fromStoryboard storyboard: String, presentingVC: UIViewController) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        
        if let tabBarController = presentingVC as? UITabBarController,
           let navController = tabBarController.selectedViewController as? UINavigationController {
            navController.pushViewController(viewController, animated: true)
        } else if let navController = presentingVC as? UINavigationController {
            navController.pushViewController(viewController, animated: true)
        }
        
        return viewController
    }
    
    public func addGestureForImage(imageView : UIImageView, selector : Selector){
        let gesture = UITapGestureRecognizer(target: self, action: selector)
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
    }
    
    public func addGestureForView(uiview : UIView, selector : Selector){
        let gesture = UITapGestureRecognizer(target: self, action: selector)
        uiview.addGestureRecognizer(gesture)
        uiview.isUserInteractionEnabled = true
    }
    
    public func addGestureForLabel(label : UILabel, selector : Selector){
        let gesture = UITapGestureRecognizer(target: self, action: selector)
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
    }
    
    public func setAttributes(font : String, textSize : Float, textColor :String, data : String) -> NSMutableAttributedString {
        var mutableString = NSMutableAttributedString()
        
        mutableString = NSMutableAttributedString(string: data, attributes: [NSAttributedString.Key.font:UIFont(name: font, size: CGFloat(textSize))!])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: textColor) ?? UIColor.blue, range: NSRange(location:0,length: data.count))
        
        return mutableString
    }
    
    public func showToast(withMessage message: String,_ completion:(() ->Void)? = nil){
        
        let alert = UIAlertController(title: AlertConstants.kAppName, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Ok", style: .cancel) { (_) in
            
            DispatchQueue.main.async { completion?() }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    public func showAlert(withMessage message: String,_ completion:(() ->Void)? = nil){
        
        let alert = UIAlertController(title: AlertConstants.kAppName, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Ok", style: .default) { (_) in
            
            DispatchQueue.main.async { completion?() }
        }
        let cancelAction =  UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
            
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func getAddressFromLatLon(latitude: Double, longitude: Double, handler completionBlock: @escaping (_ formattedAddress: String?,_ city: String?,_ zipcode: String?,_ state: String?,_ streetName: String?, _ country: String?) -> ())  {
        
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(CLLocation.init(latitude: latitude, longitude:longitude)) { (places, error) in
            if error == nil{
                let placeMark = places! as [CLPlacemark]
                
                if placeMark.count > 0 {
                    let placeMark = places![0]
                    var addressString : String = ""
                    var city: String = ""
                    var street: String = ""
                    var zip: String = ""
                    var state: String = ""
                    
                    var country: String = ""
                    if placeMark.subThoroughfare != nil {
                        addressString = addressString + placeMark.subThoroughfare! + ", "
                    }
                    if placeMark.thoroughfare != nil {
                        //            streetAddress = placeMark.thoroughfare! + ", "
                        street = placeMark.thoroughfare!
                        addressString = addressString + placeMark.thoroughfare! + ", "
                    }
                    if placeMark.subLocality != nil {
                        street = (placeMark.thoroughfare == nil) ? placeMark.subLocality! : placeMark.thoroughfare!
                        addressString = addressString + placeMark.subLocality! + ", "
                    }
                    
                    if placeMark.locality != nil {
                        city = placeMark.locality!
                        addressString = addressString + placeMark.locality! + ", "
                    }
                    if placeMark.administrativeArea != nil {
                        state = placeMark.administrativeArea!
                        addressString = addressString + placeMark.administrativeArea! + ", "
                    }
                    if placeMark.isoCountryCode != nil {
                        country = placeMark.isoCountryCode!
                    }
                    if placeMark.postalCode != nil {
                        zip = placeMark.postalCode! + " "
                        addressString = addressString + placeMark.postalCode! + " "
                    }
                    completionBlock(addressString, city ,zip, state, street, country)
                }
            }
        }
    }
    
    func getCoordinatesFromAddress(for address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let location = placemarks?.first?.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        }
    }
    
    func handleApiError(error : ApiErrorModel) {
        
        if error.errorCode != .UNAUTHORIZED {
            if error.errorData != nil {
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: error.errorData!)
                    showToast(withMessage: errorModel.errors?.first?.msg ?? errorModel.message ?? "")
                } catch {
                    
                }
            }
        }
    }
}


extension BaseVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showCameraGalleryAlert() {
        let alert = UIAlertController(title: "Please choose a source type", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openImagePicker(withSourceType: .camera, mediaType: .image)
        }
        let galleryAction = UIAlertAction(title: "Choose From Library", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.openImagePicker(withSourceType: .photoLibrary, mediaType: .image)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel){
            UIAlertAction in
        }
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openImagePicker(withSourceType type: UIImagePickerController.SourceType, mediaType: MediaType) {
        if UIImagePickerController.isSourceTypeAvailable(type) {
            self.imagePicker.delegate = self
            self.imagePicker.mediaTypes = mediaType.CameraMediaType
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = type
            
            // Set front camera if using the camera
            if type == .camera, UIImagePickerController.isCameraDeviceAvailable(.front) {
                self.imagePicker.cameraDevice = .front
            }
            
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            // Handle unavailable source type
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        self.dismiss(animated: true) {
            self.imageDelegate?.onImageSelected(image: selectedImage)
        }
    }
}


extension BaseVC : CLLocationManagerDelegate {
    
    func fetchCurrentLocation() {
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            self.locationManager.startUpdatingLocation()
            self.fetchCoordinates()
        } else {
            self.checkLocation()
        }
    }
    
    private func checkLocation() -> Void {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                if let bundleId = Bundle.main.bundleIdentifier,
                   let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)"){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)}
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
                self.fetchCoordinates()
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    private func fetchCoordinates() {
        locationDelegate?.onLocationFetched(latitude: self.locationManager.location?.coordinate.latitude ?? 0.0, longitude: self.locationManager.location?.coordinate.longitude ?? 0.0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let location = locations.last! as CLLocation
        locationDelegate?.onLocationFetched(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}


protocol ImageDelegate {
    func onImageSelected(image : UIImage)
}

protocol PdfDelegate {
    func onPdfSelected(url : URL)
}

protocol LocationDelegate {
    func onLocationFetched(latitude : Double, longitude : Double)
}

protocol LocationRepeatDelegate {
    func onRepeatLocation(location : CLLocation)
}
