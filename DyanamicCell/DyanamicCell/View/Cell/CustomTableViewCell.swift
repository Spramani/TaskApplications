//
//  CustomTableViewCell.swift
//  DyanamicCell
//
//  Created by Shubham Ramani on 12/03/24.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
    var customLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Create and configure the UILabel
        customLabel = UILabel()
        customLabel.numberOfLines = 0 // Allow multiple lines
        customLabel.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        contentView.addSubview(customLabel)
        
        // Constraints for the label
        NSLayoutConstraint.activate([
            customLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            customLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        // Configure the label with the provided text
        customLabel.text = text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the preferred max layout width of the label
        customLabel.preferredMaxLayoutWidth = contentView.bounds.width - 16 // Adjust for cell padding
    }
}


