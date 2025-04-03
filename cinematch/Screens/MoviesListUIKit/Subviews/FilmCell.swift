//
//  FilmCell.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import UIKit
import Foundation
import SkeletonView

extension FilmCell {
    struct Configuration: Hashable {
        var title = ""
        var genre = ""
        var type = ""
        var year = ""
        var image: UIImage?
        var isShimmering = false
    }
}

final class FilmCell: UICollectionViewCell {

    // MARK: Public Properties

    var configuration: Configuration {
        didSet {
            guard oldValue != configuration else { return }
            updateConfiguration()
        }
    }

    // MARK: UI Subviews

    private var backgroundImage = UIImageView()
    private var titleLabel = UILabel()
    private var genresLabel = UILabel()
    private var rightInfoLabel = UILabel()
    private let blurEffectView = UIVisualEffectView()

    private var infoStackView = UIStackView()
    private var verticalStackView = UIStackView()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        self.configuration = .init()
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FilmCell {

    func setup() {
        contentView.clipsToBounds = true

        setupBackgroundImage()
        setupInfoStackView()
        setupVerticalStackView()

        contentView.addSubviews(
            backgroundImage,
            verticalStackView
        )

        addConstraints()
        updateConfiguration()
    }

    func setupBackgroundImage() {
        backgroundImage = {
            let image = UIImageView()
            image.layer.cornerRadius = 15
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFill

            return image
        }()
    }

    func setupInfoStackView() {
        infoStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        genresLabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .systemFont(ofSize: 14)
            return label
        }()

        rightInfoLabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .systemFont(ofSize: 14)
            return label
        }()

        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false

        infoStackView.addArrangedSubview(genresLabel)
        infoStackView.addArrangedSubview(spacer)
        infoStackView.addArrangedSubview(rightInfoLabel)
    }

    func setupVerticalStackView() {
        verticalStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            stack.spacing = 12
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        titleLabel = {
            let title = UILabel()
            title.textColor = .white
            title.font = .systemFont(ofSize: 28)
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
        }()

        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(infoStackView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21),
        ])
    }

    func updateConfiguration() {
//        if configuration.isShimmering {
//            showSkeleton()
//        } else {
//            removeSkeleton()

            backgroundImage.image = configuration.image
            titleLabel.text = configuration.title
            genresLabel.text = configuration.genre
            rightInfoLabel.text = "\(configuration.type) \(configuration.year)"
//        }
    }
}
