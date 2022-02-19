//
//  UserListViewController.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import UIKit

final class UserListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    var viewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configView()
        getUserList()
    }
    
    private func configView() {
        configGradientView()
        configTableView()
    }
    
    private func updateView() {
        errorLabel.isHidden = !viewModel.users.isEmpty
        tableView.isHidden = viewModel.users.isEmpty
        tableView.reloadData()
    }
    
    private func configTableView() {
        tableView.register(UINib(nibName: "UserListTableCell", bundle: nil), forCellReuseIdentifier: "UserListTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
    }
    
    private func configGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.5).cgColor, UIColor.white.cgColor]
        gradientLayer.shouldRasterize = true
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    private func getUserList() {
        HUD.show()
        viewModel.getUserList { [weak self] result in
            HUD.dismiss()
            guard let this = self else { return }
            switch result {
            case .success:
                this.updateView()
            case .failure(let error):
                this.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    @objc private func didPullToRefresh() {
        refreshControl.endRefreshing()
        getUserList()
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableCell", for: indexPath) as? UserListTableCell
        else { return UITableViewCell() }
        cell.viewModel = viewModel.userListTableCellViewModel(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UserProfileViewController()
        vc.viewModel = viewModel.userProfileViewModel(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}
