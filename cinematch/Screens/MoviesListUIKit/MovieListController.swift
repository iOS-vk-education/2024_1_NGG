//
//  MovieListController.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import UIKit
import SkeletonView
import SwiftUI

final class MovieListController: UIViewController {
    private let viewModel: MovieListViewModelInput & MovieListDisplayData & MovieListViewModelOutput
    @State private var coordinator = Coordinator()

    private var movies: [FilmCell.Configuration] = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: Constants.cellSpacing,
                                           left: Constants.cellSpacing,
                                           bottom: Constants.cellSpacing,
                                           right: Constants.cellSpacing)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    init(viewModel: MovieListViewModelInput & MovieListDisplayData & MovieListViewModelOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        viewModel.onAppear { [weak self] in
            self?.updateMovies()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: - Setup

    private func setup() {
        setupNavigationBar()
        setupCollectionView()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .background
        view.addSubview(collectionView)
    }

    private func setupNavigationBar() {
        navigationItem.title = Constants.title

        let avatarButton = UIButton(type: .custom)

        if let imageData = viewModel.user.image,
           let avatarImage = UIImage(data: imageData) {
            avatarButton.setImage(avatarImage.withRenderingMode(.alwaysOriginal), for: .normal)
            avatarButton.imageView?.contentMode = .scaleAspectFill
        } else {
            avatarButton.backgroundColor = .background
            avatarButton.layer.borderWidth = 2
            avatarButton.layer.borderColor = UIColor.textFieldGray.cgColor
        }

        avatarButton.layer.cornerRadius = 10
        avatarButton.clipsToBounds = true
        avatarButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)

        NSLayoutConstraint.activate([
            avatarButton.widthAnchor.constraint(equalToConstant: 36),
            avatarButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        avatarButton.translatesAutoresizingMaskIntoConstraints = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatarButton)

        navigationController?.navigationBar.tintColor = .white
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilmCell.self)
    }

    private func updateMovies() {
        movies = viewModel.stories.map {
            FilmCell.Configuration(
                title: $0.title,
                genre: $0.genre,
                type: $0.type,
                year: "\($0.year)",
                image: UIImage(data: $0.mainImage),
                isShimmering: false
            )
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MovieListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FilmCell.self, for: indexPath)
        cell.configuration = movies[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedStory = viewModel.stories[indexPath.item]
        openNextScreen(for: .storyDetails(selectedStory), viewModel: viewModel, coordinator: coordinator)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - Constants.cellSpacing * 2
        return CGSize(width: width, height: Constants.cellHeight)
    }
}

// MARK: - Actions

@objc private extension MovieListController {
    func didTapProfile() {
        openNextScreen(for: .profile, viewModel: viewModel, coordinator: coordinator)
    }
}

// MARK: - Constants

private extension MovieListController {
    enum Constants {
        static let title = "Список фильмов"
        static let cellSpacing: CGFloat = 16
        static let cellHeight: CGFloat = 110
    }
}
