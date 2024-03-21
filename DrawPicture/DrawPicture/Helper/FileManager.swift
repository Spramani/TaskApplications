//
//  FileManager.swift
//  DrawPicture
//
//  Created by Shubham Ramani on 11/03/24.
//

import Foundation
import UIKit
import Photos

protocol LoadImageProtocol {
    func storeData()
}

class FileManager {
    static var shared:FileManager?
    
    let albumName = "Draw"
    var images: [UIImage] = []
    
    func storeImageInFolder(image: UIImage) {
           PHPhotoLibrary.requestAuthorization { status in
               guard status == .authorized else {
                   print("Permission to access photo library denied")
                   
                   return
               }
               
               // Check if the album exists, if not, create it
               let fetchOptions = PHFetchOptions()
               fetchOptions.predicate = NSPredicate(format: "title = %@", self.albumName)
               let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
               
               if let album = albums.firstObject {
                   // Album exists, add the image to it
                   self.addImageToAlbum(image: image, album: album)
               } else {
                   // Album does not exist, create it
                   PHPhotoLibrary.shared().performChanges({
                       PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: self.albumName)
                   }) { success, error in
                       if success {
                           // Album created successfully, now add the image to it
                           let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
                           if let album = albums.firstObject {
                               self.addImageToAlbum(image: image, album: album)
                           }
                       } else {
                           print("Error creating album:", error?.localizedDescription ?? "")
                       }
                   }
               }
           }
       }
       
       // Method to add image to the specified album
       func addImageToAlbum(image: UIImage, album: PHAssetCollection) {
           PHPhotoLibrary.shared().performChanges({
               let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
               guard let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset else {
                   print("Error: Could not get asset placeholder")
                   return
               }
               let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
               albumChangeRequest?.addAssets([assetPlaceholder] as NSArray)
           }) { success, error in
               if success {
                   print("Image added to album successfully")
               } else {
                   print("Error adding image to album:", error?.localizedDescription ?? "")
               }
           }
       }
}

