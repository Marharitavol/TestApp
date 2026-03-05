//
//  DetailViewController.swift
//  TestApp
//
//  Created by Rita on 05.03.2026.
//

import UIKit
import Kingfisher

final class DetailViewController: BaseViewController {
    
    private var viewModel: DetailViewModel!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let placesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        return imageView
    }()
    
    private let likesCount: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private let dateOfPost: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    init(viewModel: DetailViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarTitle.text = "Detail"
        view.backgroundColor = .white
        setupLayout()
        fetchPostDetails()
    }
    
    private func fetchPostDetails() {
        viewModel.fetchPostDetails { [weak self] post in
            DispatchQueue.main.async {
                self?.updateUI(with: post)
            }
        }
    }
    
    private func updateUI(with post: Post) {
        titleLabel.text = post.title
        infoLabel.text = post.text
        dateOfPost.text = post.formattedDate
        likesCount.text = "\(post.likesCount ?? 0)"
        
        placesImage.kf.indicatorType = .activity
        if let imageString = post.postImage, let url = URL(string: imageString) {
            placesImage.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(heartImage)
        contentView.addSubview(likesCount)
        contentView.addSubview(dateOfPost)
        contentView.addSubview(placesImage)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        likesCount.translatesAutoresizingMaskIntoConstraints = false
        dateOfPost.translatesAutoresizingMaskIntoConstraints = false
        placesImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            placesImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            placesImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placesImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placesImage.heightAnchor.constraint(equalToConstant: 500),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: placesImage.bottomAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            heartImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heartImage.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            heartImage.widthAnchor.constraint(equalToConstant: 24),
            heartImage.heightAnchor.constraint(equalToConstant: 24),
            
            dateOfPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateOfPost.centerYAnchor.constraint(equalTo: likesCount.centerYAnchor),
            dateOfPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            likesCount.leadingAnchor.constraint(equalTo: heartImage.trailingAnchor, constant: 10),
            likesCount.centerYAnchor.constraint(equalTo: heartImage.centerYAnchor),
        ])
    }
}
