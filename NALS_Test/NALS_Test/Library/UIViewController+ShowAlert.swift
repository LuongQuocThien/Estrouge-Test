//
//  UIViewController+ShowAlert.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            completion?()
            self.dismiss(animated: false)
        })
        alertController.addAction(action)
        alertController.preferredAction = action
        present(alertController, animated: true, completion: nil)
    }
}
