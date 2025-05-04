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

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let genreLabel = UILabel()
    private let typeYearLabel = UILabel()
    private let textStack = UIStackView()

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
        contentView.layer.borderColor = UIColor.cardGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        setupPoster()
        setupTextStack()

        contentView.addSubviews(posterImageView, textStack)

        setupConstraints()
    }

    func setupPoster() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
    }

    func setupTextStack() {
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(genreLabel)
        textStack.addArrangedSubview(typeYearLabel)
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.setCustomSpacing(10, after: titleLabel)

        [titleLabel, genreLabel, typeYearLabel].forEach {
            $0.textColor = .white
            $0.numberOfLines = 1
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
        }

        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        genreLabel.font = .systemFont(ofSize: 14)
        genreLabel.alpha = 0.8
        typeYearLabel.font = .systemFont(ofSize: 14)
        typeYearLabel.alpha = 0.8
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),

            textStack.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            textStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            textStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func updateConfiguration() {
        posterImageView.image = configuration.image
        titleLabel.text = configuration.title
        genreLabel.text = configuration.genre
        typeYearLabel.text = "\(configuration.type), \(configuration.year)"
    }
}
