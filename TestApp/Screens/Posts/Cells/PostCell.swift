//
//  PostCell.swift
//  TestApp
//
//  Created by Rita on 05.03.2026.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    static let identifier = "PostCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let previewTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private let expandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Expand", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var expandButtonHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        expandButtonHeightConstraint = expandButton.heightAnchor.constraint(equalToConstant: 45)
        expandButtonHeightConstraint?.isActive = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(previewTextLabel)
        contentView.addSubview(expandButton)
        contentView.addSubview(heartImage)
        contentView.addSubview(likesCount)
        contentView.addSubview(dateOfPost)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        previewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        likesCount.translatesAutoresizingMaskIntoConstraints = false
        dateOfPost.translatesAutoresizingMaskIntoConstraints = false
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            previewTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            previewTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            previewTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            heartImage.topAnchor.constraint(equalTo: previewTextLabel.bottomAnchor, constant: 12),
            heartImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            heartImage.heightAnchor.constraint(equalToConstant: 20),
            heartImage.widthAnchor.constraint(equalToConstant: 20),
            
            likesCount.centerYAnchor.constraint(equalTo: heartImage.centerYAnchor),
            likesCount.leadingAnchor.constraint(equalTo: heartImage.trailingAnchor, constant: 8),
            
            dateOfPost.centerYAnchor.constraint(equalTo: heartImage.centerYAnchor),
            dateOfPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            expandButton.topAnchor.constraint(equalTo: heartImage.bottomAnchor, constant: 8),
            expandButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            expandButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            expandButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

        expandButtonHeightConstraint = expandButton.heightAnchor.constraint(equalToConstant: 45)
        expandButtonHeightConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onExpandTap: (() -> Void)?

    @objc private func expandButtonTapped() {
        onExpandTap?()
    }
    
    func configure(with model: PostItem) {
        titleLabel.text = model.title
        previewTextLabel.text = model.previewText
        likesCount.text = "\(model.likesCount)"
        dateOfPost.text = model.timeAgo
        
        previewTextLabel.numberOfLines = model.isExpanded ? 0 : 2
        let isShorten = isTextShorten(text: model.previewText)
        
        if isShorten {
            expandButton.isHidden = false
            expandButtonHeightConstraint?.constant = 45
            let buttonTitle = model.isExpanded ? "Collapse" : "Expand"
            expandButton.setTitle(buttonTitle, for: .normal)
        } else {
            expandButton.isHidden = true
            expandButtonHeightConstraint?.constant = 0
            previewTextLabel.numberOfLines = 0
        }
    }
    
    private func isTextShorten(text: String) -> Bool {
        guard let font = previewTextLabel.font else { return false }
        
        let maxSize = CGSize(width: frame.width - 32, height: CGFloat.greatestFiniteMagnitude)
        let textHeight = text.boundingRect(with: maxSize,
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: font],
                                         context: nil).height
        let lineHeight = font.lineHeight
        
        return textHeight > lineHeight * 2
    }
}
