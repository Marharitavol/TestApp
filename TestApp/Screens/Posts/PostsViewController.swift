//
//  PostsViewController.swift
//  TestApp
//
//  Created by Rita on 05.03.2026.
//

import UIKit

final class PostsViewController: BaseViewController {
    
    private let viewModel = PostsViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var sections: [ListSection] {
        viewModel.sections
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ListSection, PostItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        createDataSource()
        fetchPosts()
    }
    
    private func fetchPosts() {
        activityIndicator.startAnimating()
        
        viewModel.fetchPosts() { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.reloadData()
            }
        }
    }
    
    private func setupUI() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionLayout())
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.identifier)
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            
            let section = sections[sectionIndex]
            
            switch section.type {
            case .main:
                return createTableSection()
            }
        }
        return layout
    }
    
    private func createTableSection() -> NSCollectionLayoutSection {
        let heightDimension: NSCollectionLayoutDimension = .estimated(150)
        
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .estimated(150))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: heightDimension)
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .zero
        
        return layoutSection
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ListSection, PostItem>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let self, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as? PostCell else { return nil }
            
            cell.configure(with: item)
            
            cell.onExpandTap = { [weak self] in
                guard let self else { return }
                
                viewModel.toggleExpansion(for: indexPath.section, index: indexPath.item)
                reloadData()
            }
            
            return cell
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, PostItem>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension PostsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPost = sections[indexPath.section].items[indexPath.item]
        let detailVM = DetailViewModel(postId: selectedPost.postId)
        let detailVC = DetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

