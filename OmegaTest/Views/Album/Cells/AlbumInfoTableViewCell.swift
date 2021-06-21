//
//  AlbumInfoTableViewCell.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 21.06.2021.
//

import UIKit

class AlbumInfoTableViewCell: UITableViewCell {

    // UI
    private var globalStackView: UIStackView!
    private var logoImageView: UIImageView!
    private var titleLablel: UILabel!
    private var bandLabel: UILabel!
    private var yearOfReleaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        globalStackView.removeFromSuperview()
        logoImageView.removeFromSuperview()
        titleLablel.removeFromSuperview()
        bandLabel.removeFromSuperview()
        yearOfReleaseLabel.removeFromSuperview()
    }
}

// MARK: - ConfigurableCell
extension AlbumInfoTableViewCell: ConfigurableCell {

    func configure(viewModel: ViewModelItem) {
        guard let viewModel = viewModel as? AlbumViewModelInfoItem else { return }
        
        // self
        selectionStyle = .none
        backgroundColor = Design.Colors.tableBackground
        
        // globalStackView
        globalStackView = UIStackView()
        globalStackView.alignment = .center
        globalStackView.axis = .vertical
        globalStackView.spacing = 5
        globalStackView.distribution = .fill
        contentView.addSubview(globalStackView)
        
        // logoImageView
        logoImageView = UIImageView()
        if let url = URL(string: viewModel.value.artworkUrl100) {
            logoImageView.load(url: url)
        }
        globalStackView.addArrangedSubview(logoImageView)
        
        // titleLablel
        titleLablel = UILabel()
        titleLablel.textAlignment = .left
        titleLablel.numberOfLines = 0
        titleLablel.text = viewModel.value.collectionName
        titleLablel.font = Design.Fonts.RegularText.font
        titleLablel.textColor = Design.Fonts.RegularText.color
        globalStackView.addArrangedSubview(titleLablel)
        
        // bandLabel
        bandLabel = UILabel()
        bandLabel.textAlignment = .left
        bandLabel.text = viewModel.value.artistName
        bandLabel.font = Design.Fonts.RegularText.font
        bandLabel.textColor = Design.Fonts.RegularText.color
        globalStackView.addArrangedSubview(bandLabel)
        
        // yearOfReleaseLabel
        yearOfReleaseLabel = UILabel()
        yearOfReleaseLabel.textAlignment = .left
        if let releaseDate = DateCounter.getDateFromString(string: viewModel.value.releaseDate) {
            yearOfReleaseLabel.text = String(DateCounter.getYearFromDate(date: releaseDate))
        }
        yearOfReleaseLabel.font = Design.Fonts.RegularText.font
        yearOfReleaseLabel.textColor = Design.Fonts.RegularText.color
        globalStackView.addArrangedSubview(yearOfReleaseLabel)
        
        makeConstraints()
    }
}

// MARK: - Private
private extension AlbumInfoTableViewCell {
    
    private func makeConstraints() {
        // globalStackView
        globalStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        // logoImageView
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(logoImageView.snp.height)
        }
        
        // titleLablel
        titleLablel.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
        }
        
        // bandLabel
        bandLabel.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
        }
        
        // yearOfReleaseLabel
        yearOfReleaseLabel.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
        }
    }
}
