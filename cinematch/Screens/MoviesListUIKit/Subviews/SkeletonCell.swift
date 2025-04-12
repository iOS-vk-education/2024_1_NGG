//
//  SkeletonCell.swift
//  cinematch
//
//  Created by Ксения Панкратова on 12.04.2025.
//

import UIKit

final class SkeletonCell: UICollectionViewCell {

    private let backgroundImage = UIView()

    private let titleLabel = UILabel()
    private let genresLabel = UILabel()
    private let rightInfoLabel = UILabel()

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

        titleLabel.layoutIfNeeded()
        genresLabel.layoutIfNeeded()
        rightInfoLabel.layoutIfNeeded()

        titleLabel.layer.sublayers?.first?.frame = titleLabel.bounds
        genresLabel.layer.sublayers?.first?.frame = genresLabel.bounds
        rightInfoLabel.layer.sublayers?.first?.frame = rightInfoLabel.bounds
    }
}

extension SkeletonCell: SkeletonLoadable {
    func setup() {
        [titleLabel, genresLabel, rightInfoLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }

        titleLabel.layoutIfNeeded()
        let shimmerTitle = makeShimmerLayer(on: titleLabel)
        titleLabel.layer.insertSublayer(shimmerTitle, at: 0)

        genresLabel.layoutIfNeeded()
        let shimmerGenres = makeShimmerLayer(on: genresLabel)
        genresLabel.layer.insertSublayer(shimmerGenres, at: 0)

        rightInfoLabel.layoutIfNeeded()
        let shimmerRight = makeShimmerLayer(on: rightInfoLabel)
        rightInfoLabel.layer.insertSublayer(shimmerRight, at: 0)

        setupBackground()
    }

    func setupBackground() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.layer.cornerRadius = 15
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.backgroundColor = .cardGray
    }

    func layout() {
        addSubview(backgroundImage)
        addSubview(titleLabel)
        addSubview(genresLabel)
        addSubview(rightInfoLabel)

        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),

            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            genresLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            genresLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            genresLabel.heightAnchor.constraint(equalToConstant: 20),

            rightInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            rightInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            rightInfoLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            rightInfoLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
