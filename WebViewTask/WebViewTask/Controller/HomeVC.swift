//
//  HomeVC.swift
//  WebViewTask
//
//  Created by Shubham Ramani on 07/03/24.
//

//2 - Load HTML in web view. Inject local java script, CSS code inside html. When user clock on button then in native Color in HTML should change.


import UIKit
import WebKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var wkWebView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let htmlPath = Bundle.main.path(forResource: "Index", ofType: "html") {
            let htmlURL = URL(fileURLWithPath: htmlPath)
            wkWebView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
        }
    }
    
    @IBAction func tappedRefreshButton(_ sender: UIButton) {
        wkWebView.evaluateJavaScript("changeRandomColor()")
    }
    
    
}
