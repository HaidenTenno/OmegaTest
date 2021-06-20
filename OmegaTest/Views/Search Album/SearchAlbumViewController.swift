//
//  SearchAlbumViewController.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit
import Combine

class SearchAlbumViewController: UIViewController {

    // UI
    private var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
        
    // ViewModel
    private var viewModel: SearchAlbumViewModel
    
    // TableManager
    private var tableManager: SearchAlbumTableViewManager?
        
    // Combine
    private var cancellables = Set<AnyCancellable>()
    
    // Callbacks
    private let onAlbumSelect: (Int) -> Void
    
    // Public
    init(viewModel: SearchAlbumViewModel, onAlbumSelect: @escaping (Int) -> Void) {
        self.viewModel = viewModel
        self.onAlbumSelect = onAlbumSelect
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
    }
}

// MARK: - Private
private extension SearchAlbumViewController {
    
    private func setupTableManager() {
        tableManager = SearchAlbumTableViewManager(viewModel: viewModel, onAlbumSelect: onAlbumSelect)
    }
    
    private func setupSearchBarListeners() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher.map {($0.object as! UISearchTextField).text }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { query in
                print(query ?? "")
                // Call API TO SEARCH
            }
            .store(in: &cancellables)
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
    
    private func setupNavBar() {
        navigationItem.title = "Search albums"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        setupSearchBarListeners()
    }
}
