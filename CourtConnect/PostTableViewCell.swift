//
//  PostTableViewCell.swift
//  CourtConnect
//
//  Created by {{partialupn}} on 11/25/25.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func didTapJoin(on post: Post)
}

class PostTableViewCell: UITableViewCell {
    
    weak var delegate: PostTableViewCellDelegate?
    private var currentPost: Post?
    
    let avatarView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let avatarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notesBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .systemIndigo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.circle.fill")
        imageView.tintColor = .systemIndigo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let joinedPlayersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let joinedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.2.fill")
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var notesBottomConstraint: NSLayoutConstraint?
    private var joinButtonTopConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground
        
        avatarView.addSubview(avatarLabel)
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeIcon)
        contentView.addSubview(timeLabel)
        contentView.addSubview(locationIcon)
        contentView.addSubview(locationLabel)
        contentView.addSubview(joinButton)
        contentView.addSubview(joinedIcon)
        contentView.addSubview(joinedPlayersLabel)
        
        joinButton.addTarget(self, action: #selector(joinTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            
            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: avatarView.topAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            timeIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeIcon.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            timeIcon.widthAnchor.constraint(equalToConstant: 18),
            timeIcon.heightAnchor.constraint(equalToConstant: 18),
            
            timeLabel.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 8),
            timeLabel.centerYAnchor.constraint(equalTo: timeIcon.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            locationIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationIcon.topAnchor.constraint(equalTo: timeIcon.bottomAnchor, constant: 8),
            locationIcon.widthAnchor.constraint(equalToConstant: 18),
            locationIcon.heightAnchor.constraint(equalToConstant: 18),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8),
            locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            joinButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            joinButton.widthAnchor.constraint(equalToConstant: 80),
            joinButton.heightAnchor.constraint(equalToConstant: 36),
            
            joinedIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            joinedIcon.widthAnchor.constraint(equalToConstant: 18),
            joinedIcon.heightAnchor.constraint(equalToConstant: 18),
            
            joinedPlayersLabel.leadingAnchor.constraint(equalTo: joinedIcon.trailingAnchor, constant: 8),
            joinedPlayersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            joinedPlayersLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        joinButtonTopConstraint = joinButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12)
        joinButtonTopConstraint?.isActive = true
        
        joinedIcon.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 12).isActive = true
        joinedPlayersLabel.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 12).isActive = true
    }
    
    @objc private func joinTapped() {
        guard let post = currentPost else { return }
        delegate?.didTapJoin(on: post)
    }
    
    func configure(with post: Post) {
        currentPost = post
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        gradient.colors = [UIColor.systemIndigo.cgColor, UIColor.systemPurple.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = 25
        avatarView.layer.insertSublayer(gradient, at: 0)
        
        avatarLabel.text = String(post.name.prefix(1)).uppercased()
        nameLabel.text = post.name
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateLabel.text = "Posted \(formatter.string(from: post.createdAt))"
        
        timeLabel.text = post.time
        locationLabel.text = post.location.isEmpty ? "Location not specified" : post.location
        
        // Handle notes
        if !post.notes.isEmpty {
            if notesBackgroundView.superview == nil {
                contentView.addSubview(notesBackgroundView)
                notesBackgroundView.addSubview(notesLabel)
                
                joinButtonTopConstraint?.isActive = false
                
                NSLayoutConstraint.activate([
                    notesBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    notesBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    notesBackgroundView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12),
                    
                    notesLabel.leadingAnchor.constraint(equalTo: notesBackgroundView.leadingAnchor, constant: 12),
                    notesLabel.trailingAnchor.constraint(equalTo: notesBackgroundView.trailingAnchor, constant: -12),
                    notesLabel.topAnchor.constraint(equalTo: notesBackgroundView.topAnchor, constant: 12),
                    notesLabel.bottomAnchor.constraint(equalTo: notesBackgroundView.bottomAnchor, constant: -12)
                ])
                
                joinButtonTopConstraint = joinButton.topAnchor.constraint(equalTo: notesBackgroundView.bottomAnchor, constant: 12)
                joinButtonTopConstraint?.isActive = true
            }
            notesLabel.text = post.notes
            notesBackgroundView.isHidden = false
        } else {
            notesBackgroundView.isHidden = true
        }
        
        // Display joined players
        if post.joinedPlayers.isEmpty {
            joinedIcon.isHidden = true
            joinedPlayersLabel.isHidden = true
        } else {
            joinedIcon.isHidden = false
            joinedPlayersLabel.isHidden = false
            
            let playerNames = post.joinedPlayers.map { $0.name }.joined(separator: ", ")
            joinedPlayersLabel.text = "Joined: \(playerNames) (\(post.joinedPlayers.count) player\(post.joinedPlayers.count == 1 ? "" : "s"))"
        }
    }
}
