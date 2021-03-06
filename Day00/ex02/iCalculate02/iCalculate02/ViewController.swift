//
//  ViewController.swift
//  iCalculate02
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/01.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var resultString = ""
    var newString = ""
    
    @IBOutlet weak var resulLabel: UILabel!
    
    @IBAction func onClick1(_ sender: UIButton) {
        newString = "1";
        resultString += newString;
        resulLabel.text = resultString;
        print(newString);
    }
    
    @IBAction func onClick2(_ sender: UIButton) {
        newString = "2";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick3(_ sender: UIButton) {
        newString = "3";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick4(_ sender: UIButton) {
        newString = "4";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick5(_ sender: UIButton) {
        newString = "5";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick6(_ sender: UIButton) {
        newString = "6";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick7(_ sender: UIButton) {
        newString = "7";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick8(_ sender: UIButton) {
        newString = "8";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick9(_ sender: UIButton) {
        newString = "9";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick0(_ sender: UIButton) {
        newString = "0";
        resultString += newString;
        resulLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClickPlus(_ sender: UIButton) {
        print("+");
    }
    
    @IBAction func onClickMinus(_ sender: UIButton) {
        print("-");
    }
    
    @IBAction func onClickDivide(_ sender: UIButton) {
        print("/");
    }
    
    @IBAction func onClickMultiply(_ sender: UIButton) {
        print("*");
    }
    
    @IBAction func onClickNegate(_ sender: UIButton) {
        newString = "-";
        resultString = newString + resultString;
        resulLabel.text = resultString
        print("NEG");
    }
    
    @IBAction func onClickAllClear(_ sender: UIButton) {
        print("AC");
    }
    
    @IBAction func onClickEquals(_ sender: UIButton) {
        print("=");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
