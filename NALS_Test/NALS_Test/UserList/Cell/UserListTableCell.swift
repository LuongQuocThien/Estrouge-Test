//
//  UserListTableCell.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import UIKit

final class UserListTableCell: UITableViewCell {

    @IBOutlet private weak var avataImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var gitUrlLabel: UILabel!
    
    var viewModel: UserListTableCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.avataImageView.layer.cornerRadius = self.avataImageView.frame.height / 2
        }
    }
    
    private func updateView() {
        avataImageView.loadImage(imageUrl: viewModel?.avataUrl)
        userNameLabel.text = viewModel?.userName
        gitUrlLabel.text = viewModel?.url
    }
}
