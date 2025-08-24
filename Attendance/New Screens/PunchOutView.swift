//
//  PunchOutView.swift
//  Attendance
//
//  Created by Prince on 23/08/25.
//
import SwiftUI
import AWSCore
import AWSRekognition
import AVFoundation
import InteriorAbsherSDK

// MARK: - PunchOutView
struct PunchOutView: View {
    
    // MARK: - State Properties
    @State private var capturedImage: UIImage? = nil                // Holds captured selfie image
    @State private var isImagePickerPresented = false               // Controls camera presentation
    @State private var showProgressHUD = false                      // Shows loading indicator while detecting face
    @State private var errorMessage: String = "face error"          // Error message when detection fails
    @State private var showFaceError = false                        // Toggles error UI
    
    let tabs = ["mark attendance", "permission application"]        // Tabs (unused but kept for consistency)
    @State private var selectedTab: Int = 0                         // Currently selected tab (unused)
    
    @State private var captureButtonText: String = "Take Selfie"    // Button text (changes after success/failure)
    @State private var isFaceDetected = false                       // Whether a face was successfully detected
    @State private var showAttendanceLog = false                    // Controls navigation to Attendance Log
    
    // MARK: - Init
    /// Configure AWS services on initialization
    init() {
        configureAWS()
    }
    
    // MARK: - Body
    var body: some View {
        MOIBaseUIView(
            configuration: BaseUIConfiguration(
                headerType: .Small,
                headerImage: nil,
                title: "Time Attendance",
                onEditClicked: nil,
                onShareClicked: nil,
                onMenuClicked: { print("Menu tapped") },
                onTitleClicked: { print("Title tapped") },
                showNotification: false,
                showBack: true
            ),
            header: EmptyView(),
            footer: EmptyView()
        ) {
            VStack(spacing: 20) {
                
                // MARK: - Image Preview / Error View
                if !isFaceDetected {
                    if showFaceError {
                        // Error placeholder if face not detected
                        VStack(spacing: 20) {
                            Image("Face_Error")
                            Text(errorMessage)
                                .font(Typography.Small.bold)
                                .foregroundStyle(Color.black)
                        }
                        .frame(height: 300)
                        .padding()
                    } else {
                        // Captured image or preview placeholder
                        ZStack {
                            if let image = capturedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                                    )
                            } else {
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color.gray, lineWidth: 0.9)
                                    .overlay(Text("Image Preview").foregroundColor(.gray))
                            }
                        }
                        .frame(height: 300)
                        .padding()
                    }
                }
                
                // MARK: - Capture Button
                Button(action: {
                    if isFaceDetected {
                        // Navigate to attendance log if face is detected
                        showAttendanceLog = true
                    } else {
                        // Open camera to capture selfie again
                        isImagePickerPresented = true
                    }
                }) {
                    if isFaceDetected {
                        // Success button style
                        HStack {
                            Text(captureButtonText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            Image("info_icon")
                        }
                    } else {
                        // Initial / Retry button style
                        Text(captureButtonText)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .buttonStyle(ThemeButtonStyle(dimens: .Large, colorStyle: isFaceDetected ? .green(.solid) : .gold(.solid)))
                .padding(.horizontal)
                .fullScreenCover(isPresented: $showAttendanceLog) {
                    AttendanceLogsView()
                }
                
                Spacer()
            }
            // MARK: - Progress HUD Overlay
            .overlay(
                Group {
                    if showProgressHUD {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        ProgressView("Detecting Face...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                    }
                }
            )
            // MARK: - Camera Sheet
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: .camera) { image in
                    if let image = image {
                        self.showFaceError = false
                        self.capturedImage = image
                        self.detectFaces(image: image)   // Trigger AWS Rekognition
                    }
                }
            }
        }
    }
    
    // MARK: - AWS Configuration
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
    
    // MARK: - Face Detection
    /// Detects faces from the captured selfie using AWS Rekognition.
    private func detectFaces(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            errorMessage = "Failed to convert image"
            showFaceError = true
            return
        }
        
        let rekognitionImage = AWSRekognitionImage()
        rekognitionImage?.bytes = imageData
        
        let request = AWSRekognitionDetectFacesRequest()
        request?.image = rekognitionImage
        request?.attributes = ["ALL"]
        
        let rekognitionClient = AWSRekognition.default()
        
        showProgressHUD = true
        rekognitionClient.detectFaces(request!) { response, error in
            DispatchQueue.main.async {
                showProgressHUD = false
                if let _ = error {
                    // Face detection failed
                    errorMessage = "Face detection failed"
                    captureButtonText = "Try again"
                    isFaceDetected = false
                    isImagePickerPresented = false
                    showFaceError = true
                    return
                }
                
                if let faceDetails = response?.faceDetails, !faceDetails.isEmpty {
                    // Face detected successfully
                    showFaceError = false
                    captureButtonText = "Successfully punched in"
                    isFaceDetected = true
                    errorMessage = ""
                } else {
                    // No face detected in image
                    errorMessage = "No Face Detected"
                    captureButtonText = "Try again"
                    isFaceDetected = false
                    showFaceError = true
                    isImagePickerPresented = false
                }
            }
        }
    }
}

// MARK: - UIKit Camera Integration
/// UIKit wrapper for UIImagePickerController to capture selfies.
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    var completion: (UIImage?) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.cameraDevice = .front
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as? UIImage
            parent.completion(image)
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.completion(nil)
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Preview
#Preview {
    PunchOutView()
}
