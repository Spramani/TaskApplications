//
//  ViewControllerVC.swift
//  DrawPicture
//
//  Created by Shubham Ramani on 11/03/24.
//

import UIKit
import Photos

class ViewControllerVC: UIViewController {

    var loadedImages: [UIImage] = []// Array to store loaded images

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(UINib(nibName: "ImgCVC", bundle: nil), forCellWithReuseIdentifier: "ImgCVC")
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchImagesFromAlbum(albumName: "Draw")
    }

    override func viewDidDisappear(_ animated: Bool) {
        loadedImages = []
    }
    
}



extension ViewControllerVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    // Collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCVC", for: indexPath) as! ImgCVC
        print(indexPath.row)
        
        if loadedImages.count > 0 {
            if indexPath.row < loadedImages.count  {
                cell.imgView.isHidden = false
                cell.plusButton.isHidden = true
                
                let savedImage = loadedImages[indexPath.row]
                cell.imgView.image = savedImage
            }else{
                cell.imgView.isHidden = true
                cell.plusButton.isHidden = false
            }
        }
        cell.delegate = self
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("fdfsdf")
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
         return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.width/2 - 20)
       //  return CGSize(width: UIScreen.main.bounds.width/2-10, height: UIScreen.main.bounds.width/2-10)

     }
}

extension ViewControllerVC: ClickProtocol {
    func click(data: String) {
        let vc = HomeVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ViewControllerVC {
    
      func fetchImagesFromAlbum(albumName: String) {
          PHPhotoLibrary.requestAuthorization { status in
              guard status == .authorized else {
                  print("Permission to access photo library denied")
                  return
              }
              
              let fetchOptions = PHFetchOptions()
              fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
              let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
              
              guard let album = albums.firstObject else {
                  print("Album not found")
                  return
              }
              
              let assets = PHAsset.fetchAssets(in: album, options: nil)
              self.loadedImages = []
              self.loadImages(from: assets)
          }
      }
      
      // Method to load images from fetched assets
      func loadImages(from assetCollection: PHFetchResult<PHAsset>) {
          for index in 0..<assetCollection.count {
              let asset = assetCollection[index]
              // Request image for the asset
              PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { image, _ in
                  guard let image = image else {
                      print("Failed to retrieve image")
                      return
                  }
                  // Add the loaded image to the array
                  self.loadedImages.append(image)
                  // Reload the collection view to reflect the new image
                  DispatchQueue.main.async {
                      self.collectionView.reloadData()
                  }
              }
          }
      }
}
