//
//  SkeletonCell.swift
//  cinematch
//
//  Created by Ксения Панкратова on 12.04.2025.
//

import UIKit

final class SkeletonCell: UICollectionViewCell {
    private let posterImageView = UIView()
    private let titleLabel = UILabel()
    private let genreLabel = UILabel()
    private let typeYearLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.layer.sublayers?.first?.frame = posterImageView.bounds
        titleLabel.layer.sublayers?.first?.frame = titleLabel.bounds
        genreLabel.layer.sublayers?.first?.frame = genreLabel.bounds
        typeYearLabel.layer.sublayers?.first?.frame = typeYearLabel.bounds
    }
}

extension SkeletonCell: SkeletonLoadable {
    func setup() {
        contentView.layer.borderColor = UIColor.cardGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true

        [titleLabel, genreLabel, typeYearLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }

        posterImageView.layoutIfNeeded()
        let shimmerImage = makeShimmerLayer(on: posterImageView)
        posterImageView.layer.insertSublayer(shimmerImage, at: 0)

        titleLabel.layoutIfNeeded()
        let shimmerTitle = makeShimmerLayer(on: titleLabel)
        titleLabel.layer.insertSublayer(shimmerTitle, at: 0)

        genreLabel.layoutIfNeeded()
        let shimmerGenres = makeShimmerLayer(on: genreLabel)
        genreLabel.layer.insertSublayer(shimmerGenres, at: 0)

        typeYearLabel.layoutIfNeeded()
        let shimmerRight = makeShimmerLayer(on: typeYearLabel)
        typeYearLabel.layer.insertSublayer(shimmerRight, at: 0)
    }

    func layout() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(genreLabel)
        addSubview(typeYearLabel)

        NSLayoutConstraint.activate([

            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),

            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            genreLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            genreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            genreLabel.heightAnchor.constraint(equalToConstant: 16),

            typeYearLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 12),
            typeYearLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            typeYearLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            typeYearLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
