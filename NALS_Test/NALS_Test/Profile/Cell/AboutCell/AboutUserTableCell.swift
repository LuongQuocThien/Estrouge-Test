//
//  AboutUserTableCell.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import UIKit

final class AboutUserTableCell: UITableViewCell {

    @IBOutlet private weak var bioLabel: UILabel!
    
    var viewModel: AboutUserTableCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        bioLabel.text = viewModel?.about
    }
}
