//
//  UserListViewController.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import UIKit

final class UserListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var headerHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    var viewModel = UserListViewModel()
    
    private var previousScrollOffset: CGFloat = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configView()
        loadDBData()
        getUserList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configGradientView()
    }
    
    // MARK: - Private func
    private func configView() {
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
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.cgColor]
        gradientLayer.shouldRasterize = true
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
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
                if this.viewModel.users.isEmpty {
                    this.showAlert(message: error.localizedDescription)
                }
            }
            this.updateView()
        }
    }
    
    private func loadDBData() {
        viewModel.getDBData()
    }
    
    // MARK: - Objc
    @objc private func didPullToRefresh() {
        refreshControl.endRefreshing()
        getUserList()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
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

// MARK: - UIScrollViewDelegate
extension UserListViewController: UIScrollViewDelegate {
    
    private func updateBarView(isShow: Bool) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = isShow ? Config.barViewHeight : 0
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height

        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > 0
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < maxOffset

        var newHeight = headerHeightConstraint.constant
        if isScrollingDown {
            newHeight = max(0, headerHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeight = min(Config.barViewHeight, headerHeightConstraint.constant + abs(scrollDiff))
        }

        if newHeight != self.headerHeightConstraint.constant {
            headerHeightConstraint.constant = newHeight
            setScrollPosition(previousScrollOffset)
        }

        previousScrollOffset = scrollView.contentOffset.y
    }

    private func setScrollPosition(_ position: CGFloat) {
        tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: position)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling()
        }
    }

    private func scrollViewDidStopScrolling() {

        let isShow = headerHeightConstraint.constant > Config.barViewHeight / 2
        updateBarView(isShow: isShow)
    }
}

// MARK: - Config
extension UserListViewController {
    
    struct Config {
        static let barViewHeight: CGFloat = 48
    }
}
