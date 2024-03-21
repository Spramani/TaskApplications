//
//  Storage.swift
//  LocalizationTask
//
//  Created by Shubham Ramani on 13/03/24.
//

import Foundation


func saveArrayToFile(array: [String], fileName: String) {
    let data = NSKeyedArchiver.archivedData(withRootObject: array)
    
    if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
        do {
            try data.write(to: filePath)
        } catch {
            print("Error while saving array: \(error)")
        }
    }
}

func loadArrayFromFile(fileName: String) -> [String]? {
    if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
        do {
            let data = try Data(contentsOf: filePath)
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
                return array
            }
        } catch {
            print("Error while loading array: \(error)")
        }
    }
    return nil
}
