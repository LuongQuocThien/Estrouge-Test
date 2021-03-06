//
//  UserListTableCell.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import UIKit

final class UserListTableCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var avataImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var gitUrlLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: UserListTableCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        avataImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.avataImageView.layer.cornerRadius = self.avataImageView.frame.height / 2
        }
    }
    
    // MARK: - Private func
    private func updateView() {
        if let imageData = viewModel?.imageData {
            avataImageView.image = UIImage(data: imageData)
        }
        userNameLabel.text = viewModel?.userName
        gitUrlLabel.text = viewModel?.url
    }
}
