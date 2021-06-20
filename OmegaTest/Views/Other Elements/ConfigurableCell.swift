//
//  ConfigurableCell.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit

protocol ViewModelItem {
    var identifier: String { get }
}

protocol ConfigurableCell: UITableViewCell {
    func configure(viewModel: ViewModelItem)
}
