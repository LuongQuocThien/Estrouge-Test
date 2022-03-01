//
//  AboutUserTableCell.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import UIKit

final class AboutUserTableCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var bioLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: AboutUserTableCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Private func
    private func updateView() {
        bioLabel.text = viewModel?.about
    }
}
