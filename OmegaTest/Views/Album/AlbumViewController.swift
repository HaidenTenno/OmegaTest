//
//  AlbumViewController.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit
import Combine

class AlbumViewController: UIViewController {

    // UI
    private var tableView: UITableView!
    
    // ViewModel
    private var viewModel: AlbumViewModel
    
    // TableManager
    private var tableManager: AlbumTableViewManager?
    
    // Combine
    private var cancellables = Set<AnyCancellable>()
        
    // Public
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        setupTableManager()
        viewModel.delegate = self
    }
}

// MARK: - Private
private extension AlbumViewController {
    
    private func setupTableManager() {
        tableManager = AlbumTableViewManager(viewModel: viewModel)
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
    }
}

// MARK: - UI
private extension AlbumViewController {
    
    private func setupView() {
        // self
        view.backgroundColor = Design.Colors.background
        
        // tableView
        tableView = UITableView()
        tableView.backgroundColor = Design.Colors.tableBackground
        tableView.bounces = true
        view.addSubview(tableView)
        
        // register cells
        tableView.register(AlbumInfoTableViewCell.self, forCellReuseIdentifier: Config.IDs.Cells.albumInfo)
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: Config.IDs.Cells.track)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        // tableView
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavBar() {
        navigationItem.title = "Album"
    }
}

// MARK: - AlbumViewModelDelegate
extension AlbumViewController: AlbumViewModelDelegate {
    
    func albumViewModelDidReceiveNewData(_ viewModel: AlbumViewModel) {
        tableView.reloadData()
    }
}
