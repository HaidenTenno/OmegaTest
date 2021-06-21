//
//  AlbumTableViewManager.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit

final class AlbumTableViewManager: NSObject {
    
    // ViewModel
    private let viewModel: AlbumViewModel
    
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Table view protocols
extension AlbumTableViewManager: UITableViewDelegate, UITableViewDataSource {
    
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
