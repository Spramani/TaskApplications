//
//  ImgCVC.swift
//  DrawPicture
//
//  Created by Shubham Ramani on 11/03/24.
//

import UIKit

protocol ClickProtocol {
    func click(data:String)
}

class ImgCVC: UICollectionViewCell {
    
    
    var delegate : ClickProtocol?
    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.layer.cornerRadius = 10
            imgView.layer.borderColor = UIColor.black.cgColor
            imgView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var plusButton: UIButton!{
        didSet{
            plusButton.layer.cornerRadius = 10
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func tappedPlusButton(_ sender: UIButton) {
        print("dfsd")
        delegate?.click(data: "")
    
    }
}
