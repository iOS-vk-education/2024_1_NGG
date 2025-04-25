//
//  FilmCell.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import UIKit

extension FilmCell {
    struct Configuration: Hashable {
        var title = ""
        var genre = ""
        var type = ""
        var year = ""
        var image: UIImage?
    }
}

final class FilmCell: UICollectionViewCell {

    var configuration: Configuration {
        didSet {
            guard oldValue != configuration else { return }
            updateConfiguration()
        }
    }

    private let backgroundImage = UIImageView()
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let dimmingView = UIView()

    private let titleLabel = UILabel()
    private let genresLabel = UILabel()
    private let rightInfoLabel = UILabel()

    override init(frame: CGRect) {
        configuration = .init()
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FilmCell {

    func setup() {
        contentView.clipsToBounds = true

        setupBackground()
        setupLabels()

        contentView.addSubview(backgroundImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(rightInfoLabel)

        setupConstraints()
    }

    func setupBackground() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.layer.cornerRadius = 15
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.backgroundColor = .cardGray

        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        dimmingView.translatesAutoresizingMaskIntoConstraints = false

        blurEffectView.alpha = 0.4
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImage.addSubview(dimmingView)
        backgroundImage.addSubview(blurEffectView)
    }

    func setupLabels() {
        [titleLabel, genresLabel, rightInfoLabel].forEach {
            $0.textColor = .white
            $0.numberOfLines = 1
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
        }

        titleLabel.font = .systemFont(ofSize: 28, weight: .medium)
        genresLabel.font = .systemFont(ofSize: 14)
        rightInfoLabel.font = .systemFont(ofSize: 14)
        rightInfoLabel.textAlignment = .right
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            dimmingView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            dimmingView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),

            blurEffectView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
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

    func updateConfiguration() {
        backgroundImage.image = configuration.image
        titleLabel.text = configuration.title
        genresLabel.text = configuration.genre
        rightInfoLabel.text = "\(configuration.type) \(configuration.year)"
    }
}
