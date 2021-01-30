//
//  NewsCell.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/30/21.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.alpha = 0.7
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        [coverImageView, titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            coverImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            coverImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            coverImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            coverImageView.heightAnchor.constraint(equalToConstant: 184),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    func configure(data: News) {
        titleLabel.text = data.title
        guard let url = URL(string: data.urlToImage ?? "") else { return }
        DispatchQueue.main.async {
            self.coverImageView.load(url: url)
        }
    }
}

