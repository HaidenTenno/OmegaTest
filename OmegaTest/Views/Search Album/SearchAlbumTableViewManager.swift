//
//  SearchAlbumTableViewManager.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit

final class SearchAlbumTableViewManager: NSObject {
    
    // ViewModel
    private let viewModel: SearchAlbumViewModel
    
    // Callbacks
    private let onAlbumSelect: (Int) -> Void
    
    init(viewModel: SearchAlbumViewModel, onAlbumSelect: @escaping (Int) -> Void) {
        self.viewModel = viewModel
        self.onAlbumSelect = onAlbumSelect
    }
}

// MARK: - Table view protocols
extension SearchAlbumTableViewManager: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        
        if let cell = cell as? ConfigurableCell {
            cell.configure(viewModel: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        if let viewModel = item as? SearchAlbumViewModelAlbumItem  {
            onAlbumSelect(viewModel.value.collectionID)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
