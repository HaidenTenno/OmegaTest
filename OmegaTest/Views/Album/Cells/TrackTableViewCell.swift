//
//  TrackTableViewCell.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 21.06.2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    // UI
    private var trackNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        trackNameLabel.removeFromSuperview()
    }
}

// MARK: - ConfigurableCell
extension TrackTableViewCell: ConfigurableCell {
    
    func configure(viewModel: ViewModelItem) {
        guard let viewModel = viewModel as? AlbumViewModelTrackItem else { return }
        
        // self
        selectionStyle = .none
        backgroundColor = Design.Colors.tableBackground
        
        // trackNameLabel
        trackNameLabel = UILabel()
        trackNameLabel.textAlignment = .left
        trackNameLabel.numberOfLines = 0
        trackNameLabel.text = viewModel.value.trackName
        trackNameLabel.font = Design.Fonts.RegularText.font
        trackNameLabel.textColor = Design.Fonts.RegularText.color
        contentView.addSubview(trackNameLabel)
        
        makeConstraints()
    }
}

// MARK: - Private
private extension TrackTableViewCell {
    
    private func makeConstraints() {
        // trackNameLabel
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
    }
}
