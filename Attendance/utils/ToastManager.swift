//
//  ToastManager.swift
//  JobDash
//
//  Created by CodeAegis's Macbook Pro i9 on 03/05/25.
//

import Foundation
import UIKit
 
class ToastManager {
    static let shared = ToastManager()
    private var toastView: UIView?
 
    private init() {}
 
    func show(message: String, duration: Double = 2.0) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
 
        let image = UIImage(named: "ic_skill_toast")
        
        toastView?.removeFromSuperview()
 
        // Container view
        let toastContainer = UIView()
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 12
        toastContainer.clipsToBounds = true
 
        // Image view
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
 
        // Label
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
 
        // Horizontal stack
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
 
        toastContainer.addSubview(stack)
        window.addSubview(toastContainer)
        toastView = toastContainer
 
        // Constraints
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -16),
 
            toastContainer.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            toastContainer.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            toastContainer.widthAnchor.constraint(lessThanOrEqualToConstant: window.frame.width * 0.9)
        ])
 
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
 
        // Animate
        UIView.animate(withDuration: 0.3, animations: {
            toastContainer.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }) { _ in
                toastContainer.removeFromSuperview()
            }
        }
    }
}
