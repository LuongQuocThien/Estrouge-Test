//
//  ImageManager.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import SDWebImage

final class ImageManager {

    static let shared = ImageManager()

    func downloadImage(
        imageURLList: [String],
        completion: @escaping ([UIImage?]) -> Void) {
        let group = DispatchGroup()
        var images: [UIImage?] = []
        for (imageIndex, url) in imageURLList.enumerated() {
            group.enter()
            images.append(nil)
            loadImage(with: url, for: imageIndex) { image, index in
                if index < images.count {
                    images[index] = image
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(images)
        }
    }

    private func loadImage(with urlString: String, for index: Int, completion: @escaping ((UIImage?, Int) -> Void)) {
        SDWebImageManager.shared.loadImage(
            with: URL(string: urlString),
            options: .highPriority,
            progress: nil) { (image, _, _, _, _, _) in
            completion(image, index)
        }
    }
}

