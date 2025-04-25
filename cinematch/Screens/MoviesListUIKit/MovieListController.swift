//
//  MovieListController.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import UIKit
import SwiftUI

final class MovieListController: UIViewController {
    private let viewModel: MovieListViewModelInput & MovieListDisplayData & MovieListViewModelOutput

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

        viewModel.loadMovies { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: - Setup

    private func setup() {
        setupCollectionView()
        setupView()
        setupLoadMoreButton()
    }

    private func setupView() {
        view.backgroundColor = .background
        view.addSubview(collectionView)
        view.addSubview(loadMoreButton)
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilmCell.self)
        collectionView.register(SkeletonCell.self)
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
        let count = viewModel.stories.count
        if viewModel.uiProperties.isLoadingMore {
            return count + 20
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let count = viewModel.stories.count
        if indexPath.item < count {
            let config = viewModel.configuration(at: indexPath.item)!
            let cell = collectionView.dequeueReusableCell(FilmCell.self, for: indexPath)
            cell.configuration = config
            return cell
        } else {
            return collectionView.dequeueReusableCell(SkeletonCell.self, for: indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !viewModel.uiProperties.isLoadingMore,
              indexPath.item < viewModel.stories.count else {
            return
        }
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

// MARK: - Actions

@objc
private extension MovieListController {
    func didTapProfile() {
        viewModel.didTapProfile()
    }

    func didTapLoadMore() {
        loadMoreButton.isHidden = true

        viewModel.loadMovies { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Constants

private extension MovieListController {
    enum Constants {
        static let cellSpacing: CGFloat = 16
        static let cellHeight: CGFloat = 110
    }
}
