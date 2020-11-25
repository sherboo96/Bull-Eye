//
//  ViewController.swift
//  Bull Eye
//
//  Created by Mahmoud Sherbeny on 10/21/20.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var silderView: UISlider!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var roundlbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    //MARK: - Variable
    var midValue = 50
    var scoreValue = 0
    var round = 0
    var differance = 0
    var target = 0
    var currentValue = 0
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSilderBar()
        resetAll()
        open()
    }

    //MARK: - IBAction
    @IBAction func silderViewAction(_ sender: UISlider) {
        currentValue = Int(sender.value.rounded())
        
    }
    
    @IBAction func hitPressed(_ sender: Any) {
        newRound()
        popAlartVC()
    }
    
    @IBAction func resestPressed(_ sender: Any) {
        resetAll()
    }
    
    
    //MARK: - Helper Function

    func setSilderBar() {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        silderView.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHightlight = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        silderView.setThumbImage(thumbImageHightlight, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let leftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = leftImage.resizableImage(withCapInsets: insets)
        silderView.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let rightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = rightImage.resizableImage(withCapInsets: insets)
        silderView.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func generateRandomNum() {
        target = Int.random(in: 2...99)
        targetLbl.text = "\(target)"
    }
    
    func resetAll() {
        generateRandomNum()
        
        scoreValue = 0
        round = 1
        
        silderView.value = Float(midValue)
        scoreLbl.text = "\(scoreValue)"
        roundlbl.text = "\(round)"
    }
    
    func newRound() {
        round += 1
        roundlbl.text = "\(round)"
        
        UserDefaults.standard.set(round, forKey: "round")
        UserDefaults.standard.synchronize()
        
        silderView.value = Float(midValue)
        
        calcScore()
    }
    
    func calcScore() {
        differance = target > currentValue ? target - currentValue : currentValue - target
        
        if target == currentValue {
            scoreValue += 200
            status = "Prefect"
        } else if differance < 3 {
            scoreValue += 175
            status = "Very Good"
        } else if differance < 6 {
            scoreValue += 150
            status = "Good"
        } else if differance < 9 {
            scoreValue += 125
            status = "Fair"
        } else if differance < 12 {
            scoreValue += 100
            status = "Bad"
        } else {
            scoreValue += 0
            status = "Very Bad"
        }
        
        scoreLbl.text = "\(scoreValue)"
        
        UserDefaults.standard.set(scoreValue, forKey: "score")
        UserDefaults.standard.synchronize()
        
    }
    
    func popAlartVC() {
        let massage = """
        Your Target = \(target)
        Your Current Value = \(currentValue)
        Your Score = \(scoreValue)
        Your Differance = \(differance)
        """
        
        let alert = UIAlertController(title: status, message: massage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okey", style: .default) {[weak self] (action) in
            guard let self = self else { return }
            self.generateRandomNum()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func open() {
        scoreValue = UserDefaults.standard.integer(forKey: "score")
        scoreLbl.text = "\(scoreValue)"
        
        round = UserDefaults.standard.integer(forKey: "round")
        roundlbl.text = "\(round)"
    }
}

