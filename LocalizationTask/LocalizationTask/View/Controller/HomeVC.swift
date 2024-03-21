//
//  HomeVC.swift
//  LocalizationTask
//
//  Created by Shubham Ramani on 13/03/24.
//

import UIKit

class HomeVC: UIViewController {
    
    let textField = UITextField()
    let textLabel = UILabel()
    let tableView = UITableView()
    let refectorButton = UIButton()
    
    var stringData:[String] = [String]()
 
    override func viewWillAppear(_ animated: Bool) {
       
        stringData = loadArrayFromFile(fileName: "str") ?? []
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: Notification.Name("LanguageDidChange"), object: nil)
        
       
        setUi()
        setUserInterface()
    }
    
    @objc func languageDidChange() {
        setUi()
    }
    
    func setUi(){
        viewSwipe()
        
        let rightButton = UIBarButtonItem(title: "Modified".localized(), style: .plain, target: self, action: #selector(openOptions))
        
        self.navigationItem.rightBarButtonItem = rightButton
        let value = UserDefaults.standard.string(forKey: "app_lang")
        
        self.navigationItem.title = "Localization".localized()
        
        

        textField.placeholder = "Enter text".localized()
        textLabel.text = "Label".localized()
        refectorButton.setTitle("Submit".localized(), for: .normal)
        tableView.reloadData()

    }
    
    func viewSwipe(){
        let value = UserDefaults.standard.string(forKey: "app_lang")
        self.navigationController?.navigationBar.semanticContentAttribute = (value == "ar") ? .forceRightToLeft : .forceLeftToRight
        tableView.semanticContentAttribute = (value == "ar") ? .forceRightToLeft : .forceLeftToRight
        textField.textAlignment = UserDefaults.standard.string(forKey: "app_lang") == "ar" ? .right : .left
        view.semanticContentAttribute = (value == "ar") ? .forceRightToLeft : .forceLeftToRight
    }
    
    @objc func buttonTapped() {
        stringData.append(textField.text ?? "")
        tableView.reloadData()
        textField.text = ""
        textLabel.text = ""
        saveArrayToFile(array: stringData, fileName: "str")
    }
    
    @objc func openOptions() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let option1Action = UIAlertAction(title: "English", style: .default) { [self] (_) in
            Bundle.setLanguage(lang: "en")
            setUi()
            self.showToast(message: "English", font: .systemFont(ofSize: 12.0))

        }
        let option2Action = UIAlertAction(title: "Hindi", style: .default) { [self] (_) in
            Bundle.setLanguage(lang: "hi")
            setUi()
            self.showToast(message: "Hindi", font: .systemFont(ofSize: 12.0))

        }
        let option3Action = UIAlertAction(title: "Arabic", style: .default) { [self] (_) in
            
            let currentLanguage = Locale.preferredLanguages.first
            print("Current device language: \(currentLanguage ?? "Unknown")")
            
            if currentLanguage ?? "" != "ar-IN" {
                showAlert(title: "Confirm".localized(), message: "Are you sure You want to Change in arabic Language your native languages is not in arabic languages.".localized()) { status in
                    if status == "ok" {
                        Bundle.setLanguage(lang: "ar")
                        self.setUi()
                        self.showToast(message: "Arabic", font: .systemFont(ofSize: 12.0))

                    }else{
                        
                    }
                }
            }

            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(option1Action)
        alertController.addAction(option2Action)
        alertController.addAction(option3Action)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        // Remove observer when the view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension HomeVC {
    func setUserInterface(){
        //
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        //
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        
        //
        refectorButton.backgroundColor = .blue
        refectorButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        refectorButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(refectorButton)
        
        //
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CellTVC.self, forCellReuseIdentifier: "CellTVC") // Register cell class
        view.addSubview(tableView)
        
        
        //
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            refectorButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            refectorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            refectorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: refectorButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}


extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTVC", for: indexPath) as! CellTVC
        
        // Configure cell
        cell.titleLabel.text = "Title Data".localized()
        let value = UserDefaults.standard.string(forKey: "app_lang")
        cell.titleLabel.semanticContentAttribute = (value == "ar") ? .forceRightToLeft : .forceLeftToRight
        cell.iconImageView.semanticContentAttribute = (value == "ar") ? .forceRightToLeft : .forceLeftToRight
        cell.subtitleLabel.semanticContentAttribute = (value == "ar") ? .forceRightToLeft : .forceLeftToRight
        cell.subtitleLabel.text = stringData[indexPath.row]
        cell.contentView.semanticContentAttribute = (value == "ar") ? .forceRightToLeft : .forceLeftToRight

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondVC()
        vc.descriptionLabels = stringData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}


extension HomeVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            textLabel.text = newText
        }
        return true
    }
}
