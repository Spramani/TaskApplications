//
//  HomeVC.swift
//  DrawPicture
//
//  Created by Shubham Ramani on 11/03/24.
//

import UIKit

class HomeVC: UIViewController {
    
    var isErase:Bool = false

    
    @IBOutlet weak var progressBar: UISlider!
    
    @IBOutlet weak var drawingView: DrawingView!{
        didSet{
            drawingView.layer.borderColor = UIColor.black.cgColor
            drawingView.layer.borderWidth = 1
            drawingView.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        drawingView.currentLineWidth = CGFloat(progressBar.value)
        
    
    }
    
      @IBAction func tappedEraseButton(_ sender: UIButton) {
        isErase = !isErase
        self.showToast(message: isErase ? "Erase Mode ON" : "Erase Mode OFF", font: .systemFont(ofSize: 12.0))
        drawingView.toggleEraseMode(bool:isErase)
    }
    
    @IBAction func tappedSliderView(_ sender: UISlider) {
        drawingView.currentLineWidth = CGFloat(sender.value)
    }
    
    @IBAction func tappedColorButton(_ sender: UIButton) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self // Set the delegate to handle color selection
        present(colorPicker, animated: true, completion: nil)
    }
    
    @IBAction func tappedPencilButton(_ sender: UIButton) {
     //   UIView.animate(withDuration: 0.3) { [self] in
         //   blurView.isHidden = !blurView.isHidden
     //   }
    }
    
    @IBAction func tappedUndoButton(_ sender: UIButton) {
        drawingView.undo()
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedClearButton(_ sender: UIButton) {
        drawingView.clear()

    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if let image = drawingView.getImage() {
            // Save the image
            FileManager().storeImageInFolder(image: image)
//            FileManager.shared?.storeImageInFolder(image: image, folderName: "Draw")
                self.showToast(message: "Image Save In Gallery", font: .systemFont(ofSize: 12.0))
      
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
           
        }
    }

    
    
}




extension HomeVC: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        // Use the selectedColor as needed, for example, set it to a view's background color
//        view.backgroundColor = selectedColor
        drawingView.changeColor(selectedColor)

    }
}
