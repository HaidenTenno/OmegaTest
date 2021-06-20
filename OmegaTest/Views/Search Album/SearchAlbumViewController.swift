//
//  SearchAlbumViewController.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit

class SearchAlbumViewController: UIViewController {

    // UI
    private var tableView: UITableView!
    
    // Private
//    private var userEmail: String
    
    // ViewModel
    //private var viewModel: SearchAlbumViewModel
    
    // TableManager
    //private var tableManager: SearchAlbumTableViewManager
    
    // Services
    private let userRepository: UserRepository
    
    // Callbacks
    private let onAlbumSelect: (/*Album*/) -> Void
    
    // Public
    init(userEmail: String, userRepository: UserRepository, onAlbumSelect: @escaping () -> Void) {
//        self.userEmail = userEmail
        self.userRepository = userRepository
        self.onAlbumSelect = onAlbumSelect
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUser()
    }
}

// MARK: - Private
private extension SearchAlbumViewController {
    
    private func setupUser() {
        
    }
}

// MARK: - UI
private extension SearchAlbumViewController {
    
    private func setupView() {
        // self
        view.backgroundColor = Design.Colors.background
        
        // tableView
        tableView = UITableView()
        tableView.backgroundColor = Design.Colors.background
        tableView.bounces = true
        view.addSubview(tableView)
        
        // register cells
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: Config.IDs.Cells.userInfo)
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Config.IDs.Cells.album)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        // tableView
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
