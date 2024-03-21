//
//  HomeVC.swift
//  DyanamicCell
//
//  Created by Shubham Ramani on 12/03/24.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var dataArray: [ArrayItem] = []
    var subTableView: UITableView?
    var expandedIndexPath: IndexPath?
    var subCellsIndices: [IndexPath] = []
    var count = 0
    var expand: [IndexPath] = [IndexPath]()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.updateUIConstraintsForSize(size)
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func updateUIConstraintsForSize(_ size: CGSize) {
        tableView =  UITableView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        view.addSubview(tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let screenSize = UIScreen.main.bounds.size
        
        let tableViewWidth = screenSize.width
        let tableViewHeight = screenSize.height
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: tableViewWidth, height: tableViewHeight), style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        view.addSubview(tableView)
        
        ApiHandler().jsonCall { [self] data in
            self.dataArray = data.multidimensional_arrays ?? []
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    // MARK: - UITableViewDataSource methods
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let item = dataArray[indexPath.row]
       
        let id = [1,2,3,4,5]
        if id.contains(where: {$0 == item.id})  {
            count = 0
            let indentation = String(repeating: " ", count: count)
            cell.customLabel.text = "\(indentation) indexPathRow:\(indexPath.row) \(item.description ?? "")"
        }else{
            count = count + 1
            let indentation = String(repeating: " ", count: count)
            cell.customLabel.text = "\(indentation) indexPathRow:\(indexPath.row) \(item.description ?? "")"

        }
        
        
        if let subLayers = item.sub_layers {
            cell.accessoryType = .disclosureIndicator
            cell.customLabel?.textColor = UIColor.blue
            
        } else {
            cell.accessoryType = .none
            cell.customLabel?.textColor = UIColor.black
        }
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        guard let subLayers = dataArray[indexPath.row].sub_layers else {
            return
        }
        

        
        if indexPath == expandedIndexPath {
            // Collapse the selected cell
            expandedIndexPath = nil
            var indexPathsToRemove: [IndexPath] = []
            for subIndex in subCellsIndices {
                indexPathsToRemove.append(subIndex)
            }
            guard let ind = dataArray.firstIndex(where: {$0.id == dataArray[indexPath.row].id}) else { return }
            let indexx = dataArray[ind]
            
            dataArray.removeSubrange((indexPath.row + 1)...(indexPath.row + subLayers.count))
            subCellsIndices.removeAll()
            tableView.reloadData()
        } else {
            // Expand the selected cell
            
            if expand.contains(where: {$0 == indexPath}) {
                let ind = expand.firstIndex(where: {$0 == indexPath})!
                expand.remove(at: ind)
            }else{
                count = 0
                expand.append(indexPath)
                expandedIndexPath = indexPath
                var indexPathsToInsert: [IndexPath] = []
                for (index, subLayer) in subLayers.enumerated() {
                    let newIndex = indexPath.row + index + 1
                    
                    dataArray.insert(ArrayItem(id: subLayer.id, description: subLayer.description, sub_layers: subLayer.sub_layers), at: newIndex)
                    let newIndexPath = IndexPath(row: newIndex, section: 0)
                    indexPathsToInsert.append(newIndexPath)
                    subCellsIndices.append(newIndexPath)
                }
                tableView.insertRows(at: indexPathsToInsert, with: .top)
                
            }
        }
    }
    
}
