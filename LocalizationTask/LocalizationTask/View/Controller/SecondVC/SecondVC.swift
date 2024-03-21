//
//  SecondVC.swift
//  LocalizationTask
//
//  Created by Shubham Ramani on 13/03/24.
//

import UIKit

class SecondVC: UIViewController {
    var descriptionLabels: String = ""
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Second Page".localized()
        
        
        // Set properties for titleLabel
        titleLabel.text = "\(descriptionLabels)"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        // Set properties for descriptionLabel
        descriptionLabel.text = "it is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).".localized()
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.black
        
        // Create a UIStackView
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        // Add the stackView to the view hierarchy
        self.view.addSubview(stackView)
        
        // Set constraints for the stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                   stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                   stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
