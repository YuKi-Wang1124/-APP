//
//  ViewController.swift
//  房貸試算APP
//
//  Created by 王昱淇 on 2021/9/6.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var loanMoneyTextField: UITextField!
    @IBOutlet weak var annualInterestRateTextField: UITextField!
    @IBOutlet weak var monthsTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://bit.ly/3tlD3dK")
        
        let player = AVPlayer(url: url!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(origin: CGPoint(x: 10, y: 510), size: CGSize(width: 400, height: 362))
        view.layer.addSublayer(playerLayer)
        
        let image = UIImage(named: "TV")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: -40, y: 450), size: CGSize(width: 495, height: 500))
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        player.play()
    }


    @IBAction func caculate(_ sender: Any) {
        let loanMoneyText = loanMoneyTextField.text!
        let annualInterestRateText = annualInterestRateTextField.text!
        let monthsText = monthsTextField.text!
        loanMoneyTextField.endEditing(true)
        annualInterestRateTextField.endEditing(true)
        monthsTextField.endEditing(true)
        
        let loanMoney = Double(loanMoneyText)
        let annualInterestRate = Double(annualInterestRateText)
        let months = Double(monthsText)
        
        //1-1、平均每月應繳總額＝平均每月應繳本金金額＋平均每月應繳利息金額
        //　　　　　　＝貸款本金×每月應還本息金額之平均攤還率
        
        //每月應還本息金額之平均攤還率＝{[(1＋月利率)^月數]×月利率}÷{[(1＋月利率)^月數]－1}
        if loanMoney != nil, annualInterestRate != nil, months != nil {
            
            let monthsRate = annualInterestRate!/12/100
            let rate = pow((1 + monthsRate), months!)
            let amortizationRate = (rate * monthsRate) / (rate - 1)            
            let result = loanMoney! * amortizationRate
            
            resultLabel.text = "\(Int(result))"
        }
    }
}

