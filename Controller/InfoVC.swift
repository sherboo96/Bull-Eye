//
//  InfoVC.swift
//  Bull Eye
//
//  Created by Mahmoud Sherbeny on 10/21/20.
//

import UIKit
import WebKit

class InfoVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var myWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadHTMLFile()
    }
    
    //MARK: - IBAction
    
    @IBAction func closePressedBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helper Function
    
    func loadHTMLFile() {
        guard let htmlPath = Bundle.main.path(forResource: "BullsEye", ofType: "html") else { return }
        let htmlURL = URL(fileURLWithPath: htmlPath)
        let htmlURLRequest = URLRequest(url: htmlURL)
        myWebView.load(htmlURLRequest)
    }
}
