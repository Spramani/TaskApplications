//
//  HomeVC.swift
//  JsonCreateUI
//
//  Created by Shubham Ramani on 08/03/24.
//

import UIKit

class HomeVC: UIViewController {
    var userForm: UserFormResponse?
    let imagePicker = UIImagePickerController()
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // Parse JSON
        ApiHandler.shared.jsonCall { data in
            self.userForm = data
            self.createFormUI(userForm: data)
        }
    }
    
    @objc func submitButtonPressed() {
        // Handle submit button press
        print("Submit button pressed!")
    }
    
    @objc func imageViewTapped() {
           present(imagePicker, animated: true, completion: nil)
       }
}

extension HomeVC {
    // MARK: - Create UI
    func createFormUI(userForm: UserFormResponse) {
        
        var previousField: UIView?
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Create title label
        let titleLabel = UILabel()
        titleLabel.text = userForm.form.title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(titleLabel)
        
        // Constraints for the title label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
        
        
        for field in userForm.form.fields {
            let viewToAdd: UIView
            
            switch field.type {
                
            case "label":
                let label = UILabel()
                label.text = field.text
                label.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(label)
                viewToAdd = label
            case "textfield":
                let textField = UITextField()
                textField.placeholder = field.placeholder
                textField.borderStyle = .roundedRect
                textField.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(textField)
                applyLayoutProperties(textField, properties: field.layout)
                viewToAdd = textField
            case "imageview":
                imageView.image = UIImage(named: field.placeholder ?? "")
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                scrollView.addSubview(imageView)
                NSLayoutConstraint.activate([
                    imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor), // Center horizontally
                    imageView.widthAnchor.constraint(equalToConstant: 200),
                    imageView.heightAnchor.constraint(equalToConstant: 200)
                ])
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tapGestureRecognizer)
                
                viewToAdd = imageView
            case "toggle":
                let toggleSwitch = UISwitch()
                toggleSwitch.isOn = false
                toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
                let toggleLabel = UILabel()
                toggleLabel.text = field.text
                toggleLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let stackView = UIStackView(arrangedSubviews: [toggleLabel, toggleSwitch])
                stackView.axis = .horizontal
                stackView.spacing = 10
                stackView.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(stackView)
                viewToAdd = stackView
            case "button":
                let button = UIButton(type: .system)
                button.setTitle(field.text, for: .normal)
                button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(button)
                applyLayoutProperties(button, properties: field.layout)
                viewToAdd = button
            case "segment":
                let segmentControl = UISegmentedControl(items: field.items)
                segmentControl.selectedSegmentIndex = 0 // Set default selection index if needed
                segmentControl.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(segmentControl)
                NSLayoutConstraint.activate([
                    
                    segmentControl.heightAnchor.constraint(equalToConstant: 50)
                ])
                viewToAdd = segmentControl
            case "datepicker":
                let datePickerLabel = UILabel()
                datePickerLabel.text = field.text ?? "Select Date"
                datePickerLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let datePicker = UIDatePicker()
                datePicker.datePickerMode = .date // Set date picker mode as needed
                datePicker.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(datePicker)
                applyLayoutProperties(datePicker, properties: field.layout)
                
                let stackView = UIStackView(arrangedSubviews: [datePickerLabel, datePicker])
                stackView.axis = .horizontal
                stackView.spacing = 0
                stackView.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(stackView)
                viewToAdd = stackView
            default:
                continue
            }
            
            // Constraints for the view to add
            NSLayoutConstraint.activate([
                viewToAdd.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                viewToAdd.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
            ])
            
            if let previousField = previousField {
                viewToAdd.topAnchor.constraint(equalTo: previousField.bottomAnchor, constant: 15).isActive = true
            } else {
                viewToAdd.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
            }
            previousField = viewToAdd
        }
        
        // Constraint for the bottom of the last field to the bottom of the scroll view
        if let lastField = previousField {
            NSLayoutConstraint.activate([
                
                lastField.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
            ])
        }
    }
    
    func applyLayoutProperties(_ view: UIView, properties: LayoutProperties?) {
        
        guard let properties = properties else { return }
        if let backgroundColor = properties.backgroundColor {
            view.backgroundColor = UIColor(hex: backgroundColor)
        }
        if let borderColor = properties.borderColor, let borderWidth = properties.borderWidth {
            view.layer.borderColor = UIColor(hex: borderColor).cgColor
            view.layer.borderWidth = borderWidth
        }
        if let textColor = properties.textColor, let view = view as? UILabel {
            view.textColor = UIColor(hex: textColor)
        }
        
        if let view = view as? UITextField {
            view.layer.cornerRadius = 5
        }
        
        if let textColor = properties.textColor, let view = view as? UIButton {
            view.setTitleColor(UIColor(hex: textColor), for: .normal)
            view.layer.cornerRadius = 10
        }
    }
}


extension HomeVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[.editedImage] as? UIImage {
               imageView.image = pickedImage
           }
           dismiss(animated: true, completion: nil)
       }
       
       // Delegate method to handle image selection cancellation
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
}
