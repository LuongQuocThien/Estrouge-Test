//
//  UIImageView+LoadImage.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import SDWebImage

extension UIImageView {
    
    func loadImage(imageUrl: String?, completion: (() -> Void)? = nil) {
        guard let imageUrl = imageUrl else {
            completion?()
            return
        }

        SDWebImageManager.shared.loadImage(
            with: URL(string: imageUrl),
            options: .highPriority,
            progress: nil) { (image, _, _, _, _, _) in
            self.image = image
            completion?()
        }
    }
}
