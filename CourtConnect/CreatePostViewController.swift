//
//  CreatePostViewController.swift
//  CourtConnect
//
//  Created by {{partialupn}} on 11/25/25.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    var sport: Sport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Create Post"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
        
        iconLabel.text = sport.icon
        iconLabel.font = UIFont.systemFont(ofSize: 64)
        
        titleLabel.text = "Looking for \(sport.name) partners"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        setupTextField(nameTextField, placeholder: "Enter your name")
        setupTextField(timeTextField, placeholder: "e.g., Tomorrow 6 PM")
        setupTextField(locationTextField, placeholder: "e.g., Central Park Courts")
        
        notesTextView.layer.borderColor = UIColor.systemGray4.cgColor
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.cornerRadius = 8
        notesTextView.font = UIFont.systemFont(ofSize: 16)
        
        submitButton.setTitle("Submit Post", for: .normal)
        submitButton.backgroundColor = .systemIndigo
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 12
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let time = timeTextField.text, !time.isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your name and preferred time.")
            return
        }
        
        let location = locationTextField.text ?? ""
        let notes = notesTextView.text ?? ""
        
        let post = Post(
            name: name,
            time: time,
            location: location,
            notes: notes,
            sportId: sport.id
        )
        
        PostStorage.shared.addPost(post, for: sport.id)
        dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
