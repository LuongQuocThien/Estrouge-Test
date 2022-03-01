//
//  UserProfileViewController.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import UIKit

final class UserProfileViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    var viewModel: UserProfileViewModel? {
        didSet {
            getUserProfile()
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    // MARK: - Private func
    private func getUserProfile() {
        HUD.show()
        viewModel?.getUserProfile { [weak self] result in
            HUD.dismiss()
            guard let this = self else { return }
            switch result {
            case .success:
                this.updateView()
            case .failure(_):
                break
            }
        }
    }
    
    private func updateView() {
        tableView.reloadData()
    }
    
    private func configTableView() {
        tableView.register(UINib(nibName: "UserListTableCell", bundle: nil), forCellReuseIdentifier: "UserListTableCell")
        tableView.register(UINib(nibName: "AboutUserTableCell", bundle: nil), forCellReuseIdentifier: "AboutUserTableCell")
        tableView.register(UINib(nibName: "UserStatsTableCell", bundle: nil), forCellReuseIdentifier: "UserStatsTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Objc
    @objc private func didPullToRefresh() {
        refreshControl.endRefreshing()
        getUserProfile()
    }
    
    // MARK: - IBAction
    @IBAction func onBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
