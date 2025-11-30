//
//  AvailablePlayersViewController.swift
//  CourtConnect
//
//  Created by {{partialupn}} on 11/25/25.
//

import UIKit

class AvailablePlayersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createPostButton: UIButton!
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var emptyIconLabel: UILabel!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    var sport: Sport!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
    }
    
    private func setupUI() {
        title = sport.name
        
        createPostButton.setTitle("Create Post", for: .normal)
        createPostButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        createPostButton.tintColor = .white
        createPostButton.backgroundColor = .systemIndigo
        createPostButton.layer.cornerRadius = 12
        
        emptyIconLabel.text = sport.icon
        emptyIconLabel.font = UIFont.systemFont(ofSize: 64)
        emptyTitleLabel.text = "No posts yet"
        emptyTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        emptyMessageLabel.text = "Be the first to create a post for \(sport.name)!"
        emptyMessageLabel.font = UIFont.systemFont(ofSize: 16)
        emptyMessageLabel.textColor = .systemGray
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    private func loadPosts() {
        posts = PostStorage.shared.getPosts(for: sport.id)
        tableView.reloadData()
        updateEmptyState()
    }
    
    private func updateEmptyState() {
        emptyStateView.isHidden = !posts.isEmpty
        tableView.isHidden = posts.isEmpty
    }
    
    @IBAction func createPostTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showCreatePost", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreatePost",
           let navController = segue.destination as? UINavigationController,
           let destination = navController.topViewController as? CreatePostViewController {
            destination.sport = sport
        }
    }
}

extension AvailablePlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.configure(with: posts[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension AvailablePlayersViewController: PostTableViewCellDelegate {
    func didTapJoin(on post: Post) {
        let alert = UIAlertController(title: "Join Game", message: "Enter your name to join this game", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Your name"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Join", style: .default) { [weak self] _ in
            guard let self = self,
                  let name = alert.textFields?.first?.text,
                  !name.isEmpty else { return }
            
            PostStorage.shared.addPlayerToPost(postId: post.id, sportId: self.sport.id, playerName: name)
            self.loadPosts()
            
            let successAlert = UIAlertController(title: "Success!", message: "You've joined the game! \(post.name) will see you in their players list.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(successAlert, animated: true)
        })
        
        present(alert, animated: true)
    }
}
