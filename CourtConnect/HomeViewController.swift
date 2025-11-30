//
//  HomeViewController.swift
//  CourtConnect
//
//  Created by {{partialupn}} on 11/25/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sports = [
        Sport(id: "badminton", name: "Badminton", icon: "🏸", color: .systemBlue),
        Sport(id: "basketball", name: "Basketball", icon: "🏀", color: .systemOrange),
        Sport(id: "tennis", name: "Tennis", icon: "🎾", color: .systemGreen),
        Sport(id: "volleyball", name: "Volleyball", icon: "🏐", color: .systemPurple)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func setupUI() {
        title = "CourtConnect"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SportCollectionViewCell.self, forCellWithReuseIdentifier: "SportCell")
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = (view.bounds.width - spacing * 3) / 2
        layout.itemSize = CGSize(width: width, height: width * 0.9)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionView.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayers",
           let destination = segue.destination as? AvailablePlayersViewController,
           let sport = sender as? Sport {
            destination.sport = sport
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCollectionViewCell
        let sport = sports[indexPath.item]
        let count = PostStorage.shared.getPostCount(for: sport.id)
        cell.configure(with: sport, count: count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = sports[indexPath.item]
        performSegue(withIdentifier: "showPlayers", sender: sport)
    }
}
