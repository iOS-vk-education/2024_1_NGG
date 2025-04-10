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
    private let coordinator = NavigationControllerCoordinator()

    private let loadMoreButton = UIButton()

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

    private var displayConfigurations: [FilmCell.Configuration] {
        if viewModel.stories.isEmpty || viewModel.uiProperties.isLoadingMore {
            return Array(repeating: FilmCell.Configuration(isShimmering: true), count: 6)
        } else {
            return viewModel.stories.map {
                FilmCell.Configuration(
                    title: $0.title,
                    genre: $0.genre,
                    type: $0.type,
                    year: "\($0.year)",
                    image: UIImage(data: $0.mainImage),
                    isShimmering: false
                )
            }
        }
    }

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
        viewModel.setCoordinator(coordinator)
        coordinator.navigationController = self.navigationController

        viewModel.loadMovies { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
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
        setupLoadMoreButton()
    }

    private func setupView() {
        view.backgroundColor = .background
        view.isSkeletonable = false
        collectionView.isSkeletonable = false
        view.addSubview(collectionView)
        view.addSubview(loadMoreButton)
    }

    private func setupNavigationBar() {
        navigationItem.title = Constants.title
        let avatarButton = UIButton(type: .custom)

        if let imageData = viewModel.user.image,
           let avatarImage = UIImage(data: imageData) {
            avatarButton.setImage(avatarImage, for: .normal)
            avatarButton.imageView?.contentMode = .scaleAspectFill
        } else {
            avatarButton.backgroundColor = .background
            avatarButton.layer.borderWidth = 2
            avatarButton.layer.borderColor = UIColor.textFieldGray.cgColor
        }

        avatarButton.layer.cornerRadius = 10
        avatarButton.clipsToBounds = true
        avatarButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        avatarButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarButton.widthAnchor.constraint(equalToConstant: 36),
            avatarButton.heightAnchor.constraint(equalToConstant: 36)
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatarButton)
    }

    private func setupCollectionView() {
        collectionView.isSkeletonable = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilmCell.self)
    }

    private func setupLoadMoreButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 36)
        let plusImage = UIImage(systemName: "plus.circle", withConfiguration: config)

        loadMoreButton.setImage(plusImage, for: .normal)
        loadMoreButton.tintColor = .white
        loadMoreButton.backgroundColor = .clear
        loadMoreButton.clipsToBounds = true
        loadMoreButton.isHidden = true
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadMoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loadMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loadMoreButton.widthAnchor.constraint(equalToConstant: 56),
            loadMoreButton.heightAnchor.constraint(equalToConstant: 56)
        ])

        loadMoreButton.addTarget(self, action: #selector(didTapLoadMore), for: .touchUpInside)
    }
}

// MARK: - UICollectionViewDataSource

extension MovieListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayConfigurations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let config = displayConfigurations[indexPath.item]
        let cell = collectionView.dequeueReusableCell(FilmCell.self, for: indexPath)
        cell.configuration = config
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedStory = viewModel.stories[indexPath.item]
        viewModel.didTapCell(story: selectedStory)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        let shouldShow = viewModel.uiProperties.canLoadMorePages &&
        offsetY > contentHeight - frameHeight * 1.5

        loadMoreButton.isHidden = !shouldShow
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

extension MovieListController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        FilmCell.reuseIdentifier
    }
}

// MARK: - Actions

@objc
private extension MovieListController {
    func didTapProfile() {
        viewModel.didTapProfile()
    }

    func didTapLoadMore() {
        loadMoreButton.isHidden = true

        viewModel.loadMovies { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
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
