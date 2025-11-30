//
//  PostStorage.swift
//  CourtConnect
//
//  Created by {{partialupn}} on 11/25/25.
//

import Foundation

class PostStorage {
    static let shared = PostStorage()
    private let storageKey = "courtconnect_posts"
    
    private init() {}
    
    func getAllPosts() -> [String: [Post]] {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([String: [Post]].self, from: data) {
            return decoded
        }
        return [:]
    }
    
    func savePosts(_ posts: [String: [Post]]) {
        if let encoded = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    func addPost(_ post: Post, for sportId: String) {
        var allPosts = getAllPosts()
        if allPosts[sportId] == nil {
            allPosts[sportId] = []
        }
        allPosts[sportId]?.append(post)
        savePosts(allPosts)
    }
    
    func getPosts(for sportId: String) -> [Post] {
        return getAllPosts()[sportId] ?? []
    }
    
    func getPostCount(for sportId: String) -> Int {
        return getPosts(for: sportId).count
    }
    
    func addPlayerToPost(postId: String, sportId: String, playerName: String) {
        var allPosts = getAllPosts()
        
        if var posts = allPosts[sportId],
           let index = posts.firstIndex(where: { $0.id == postId }) {
            let newPlayer = JoinedPlayer(name: playerName, joinedAt: Date())
            posts[index].joinedPlayers.append(newPlayer)
            allPosts[sportId] = posts
            savePosts(allPosts)
        }
    }
}
