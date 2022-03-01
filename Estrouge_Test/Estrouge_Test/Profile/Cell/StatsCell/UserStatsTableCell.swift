//
//  UserStatsTableCell.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import UIKit

final class UserStatsTableCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var pubRepoValueLabel: UILabel!
    @IBOutlet weak var followerValueLabel: UILabel!
    @IBOutlet weak var followingValueLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: UserStatsTableCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Private func
    private func updateView() {
        pubRepoValueLabel.text = "\(viewModel?.totalPubRepo ?? 0)"
        followerValueLabel.text = "\(viewModel?.totalFollower ?? 0)"
        followingValueLabel.text = "\(viewModel?.totalFollowing ?? 0)"
    }
}
