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
    
    private func updateView() {
        userNameLabel.text = viewModel?.user?.userName
        gitUrlLabel.text = viewModel?.user?.url
    }
}
