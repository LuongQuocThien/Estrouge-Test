//
//  UserProfileViewController.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import UIKit

final class UserProfileViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: UserProfileViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateView() {
        configTableView()
    }
    
    private func configTableView() {
        tableView.register(UINib(nibName: "UserListTableCell", bundle: nil), forCellReuseIdentifier: "UserListTableCell")
        tableView.register(UINib(nibName: "AboutUserTableCell", bundle: nil), forCellReuseIdentifier: "AboutUserTableCell")
        tableView.register(UINib(nibName: "UserStatsTableCell", bundle: nil), forCellReuseIdentifier: "UserStatsTableCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let viewModel = viewModel,
                let rowType = UserProfileViewModel.RowType(rawValue: indexPath.row) else { return cell }
        switch rowType {
        case .userBasicInfo:
            guard let cel = tableView.dequeueReusableCell(withIdentifier: "UserListTableCell", for: indexPath) as? UserListTableCell else { break }
            cel.viewModel = viewModel.userListTableCellViewModel()
            cell = cel
        case .about:
            guard let cel = tableView.dequeueReusableCell(withIdentifier: "AboutUserTableCell", for: indexPath) as? AboutUserTableCell else { break }
            cel.viewModel = viewModel.aboutUserTableCellViewModel()
            cell = cel
        case .stats:
            guard let cel = tableView.dequeueReusableCell(withIdentifier: "UserStatsTableCell", for: indexPath) as? UserStatsTableCell else { break }
            cel.viewModel = viewModel.userStatsTableCellViewModel()
            cell = cel
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
