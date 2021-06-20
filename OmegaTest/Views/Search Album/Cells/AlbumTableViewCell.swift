//
//  AlbumTableViewCell.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    // UI
    private var globalStackView: UIStackView!
    private var logoAndTitleStackView: UIStackView!
    private var logoImageView: UIImageView!
    private var titleLablel: UILabel!
    private var bandLabel: UILabel!
    private var numberOfTracksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        globalStackView.removeFromSuperview()
        logoAndTitleStackView.removeFromSuperview()
        logoImageView.removeFromSuperview()
        titleLablel.removeFromSuperview()
        bandLabel.removeFromSuperview()
        numberOfTracksLabel.removeFromSuperview()
    }
}

// MARK: - ConfigurableCell
extension AlbumTableViewCell: ConfigurableCell {
    
    func configure(viewModel: ViewModelItem) {
        guard let viewModel = viewModel as? SearchAlbumViewModelAlbumItem else { return }
        
        // self
        selectionStyle = .default
        backgroundColor = Design.Colors.tableBackground
        
        //  globalStackView
        globalStackView = UIStackView()
        globalStackView.alignment = .center
        globalStackView.axis = .vertical
        globalStackView.spacing = 5
        globalStackView.distribution = .fill
        contentView.addSubview(globalStackView)
        
        //  logoAndTitleStackView
        logoAndTitleStackView = UIStackView()
        logoAndTitleStackView.alignment = .leading
        logoAndTitleStackView.axis = .horizontal
        logoAndTitleStackView.spacing = 10
        logoAndTitleStackView.distribution = .fill
        globalStackView.addArrangedSubview(logoAndTitleStackView)
        
        //  logoImageView
        logoImageView = UIImageView()
        if let url = URL(string: viewModel.value.artworkUrl100) {
            logoImageView.load(url: url)
        }
        logoAndTitleStackView.addArrangedSubview(logoImageView)
        
        //  titleLablel
        titleLablel = UILabel()
        titleLablel.textAlignment = .left
        titleLablel.numberOfLines = 0
        titleLablel.text = viewModel.value.collectionName
        titleLablel.font = Design.Fonts.RegularText.font
        titleLablel.textColor = Design.Fonts.RegularText.color
        logoAndTitleStackView.addArrangedSubview(titleLablel)
        
        //  bandLabel
        bandLabel = UILabel()
        bandLabel.textAlignment = .left
        bandLabel.text = viewModel.value.artistName
        bandLabel.font = Design.Fonts.RegularText.font
        bandLabel.textColor = Design.Fonts.RegularText.color
        globalStackView.addArrangedSubview(bandLabel)
        
        //  numberOfTracksLabel
        numberOfTracksLabel = UILabel()
        numberOfTracksLabel.textAlignment = .left
        let trackOrTracks = viewModel.value.trackCount > 1 ? "tracks" : "track"
        numberOfTracksLabel.text = "\(viewModel.value.trackCount) \(trackOrTracks)"
        numberOfTracksLabel.font = Design.Fonts.RegularText.font
        numberOfTracksLabel.textColor = Design.Fonts.RegularText.color
        globalStackView.addArrangedSubview(numberOfTracksLabel)
        
        makeConstraints()
    }
}

// MARK: - Private
private extension AlbumTableViewCell {
    
    private func makeConstraints() {
        //  globalStackView
        globalStackView.snp.remakeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        //  logoAndTitleStackView
        logoAndTitleStackView.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
        }
        
        //  logoImageView
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(logoImageView.snp.height)
        }
        
        //  titleLablel
        titleLablel.snp.makeConstraints { make in
            make.top.equalTo(logoAndTitleStackView)
            make.bottom.equalTo(logoAndTitleStackView)
        }
        
        //  bandLabel
        bandLabel.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
        }
        
        //  numberOfTracksLabel
        numberOfTracksLabel.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
        }
    }
}
