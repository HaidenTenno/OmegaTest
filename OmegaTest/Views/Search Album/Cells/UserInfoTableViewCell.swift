//
//  UserInfoTableViewCell.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    // UI
    private var userInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        userInfoLabel.removeFromSuperview()
    }
}

// MARK: - ConfigurableCell
extension UserInfoTableViewCell: ConfigurableCell {
    
    func configure(viewModel: ViewModelItem) {
        guard let viewModel = viewModel as? SearchAlbumViewModelUserItem else { return }
        
        // self
        selectionStyle = .none
        backgroundColor = Design.Colors.tableBackground
        
        // userInfoLabel
        userInfoLabel = UILabel()
        userInfoLabel.textAlignment = .left
        userInfoLabel.text = "User: \(viewModel.value.firstName) \(viewModel.value.lastName)"
        userInfoLabel.font = Design.Fonts.RegularText.font
        userInfoLabel.textColor = Design.Fonts.RegularText.color
        contentView.addSubview(userInfoLabel)
        
        makeConstraints()
    }
}

// MARK: - Private
private extension UserInfoTableViewCell {
    
    private func makeConstraints() {
        // userInfoLabel
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
    }
}
