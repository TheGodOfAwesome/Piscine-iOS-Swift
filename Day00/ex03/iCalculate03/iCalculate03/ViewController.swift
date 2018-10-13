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
    
    var numberOnScreen:Double = 0;
    var numberBefore:Double = 0;
    var resultValue:Double = 0;
    var canCalculate:Bool = false;
    var operation:String = "";
    var resultString:String = "";
    var newString:String = "";
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func onClick1(_ sender: UIButton) {
        newString = "1";
        resultString += newString;
        resultLabel.text = resultString;
        print(newString);
    }
    
    @IBAction func onClick2(_ sender: UIButton) {
        newString = "2";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick3(_ sender: UIButton) {
        newString = "3";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick4(_ sender: UIButton) {
        newString = "4";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick5(_ sender: UIButton) {
        newString = "5";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick6(_ sender: UIButton) {
        newString = "6";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick7(_ sender: UIButton) {
        newString = "7";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick8(_ sender: UIButton) {
        newString = "8";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick9(_ sender: UIButton) {
        newString = "9";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClick0(_ sender: UIButton) {
        newString = "0";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
    }
    
    @IBAction func onClickPlus(_ sender: UIButton) {
        calculate(sign: "+");
        print("+");
    }
    
    @IBAction func onClickMinus(_ sender: UIButton) {
        calculate(sign: "-");
        print("-");
    }
    
    @IBAction func onClickDivide(_ sender: UIButton) {
        calculate(sign: "/");
        print("/");
    }
    
    @IBAction func onClickMultiply(_ sender: UIButton) {
        calculate(sign: "*");
        print("*");
    }
    
    @IBAction func onClickNegate(_ sender: UIButton) {
        newString = "-";
        resultString = newString + resultString;
        resultLabel.text = resultString
        print("NEG");
    }
    
    @IBAction func onClickAllClear(_ sender: UIButton) {
        clearAll();
        print("AC");
    }
    
    @IBAction func onClickEquals(_ sender: UIButton) {
        calculate(sign: "=");
        print("=");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clearAll(){
        numberOnScreen = 0;
        numberBefore = 0;
        resultValue = 0;
        canCalculate = false;
        operation = "";
        resultString = "";
        newString = "";
        resultLabel.text = "0";
    }
    
    func calculate(sign: String){
        resultString = "";
        if(sign == "+"){
            if(operation != ""){
                doMath(sign: sign)
                numberBefore = resultValue;
            }
            else
            {
                if(resultLabel.text!.contains("-")){
                    numberBefore = Double(resultLabel.text!)! * -1;
                } else {
                    numberBefore = Double(resultLabel.text!)!;
                }
            }
            resultLabel.text = "+";
            operation = "+";
        }
        if(sign == "-"){
            if(operation != ""){
                doMath(sign: sign)
                numberBefore = resultValue;
            }
            else
            {
                if(resultLabel.text!.contains("-")){
                    numberBefore = Double(resultLabel.text!)! * -1;
                } else {
                    numberBefore = Double(resultLabel.text!)!;
                }
            }
            resultLabel.text = "-";
            operation = "-";
        }
        if(sign == "*"){
            if(operation != ""){
                doMath(sign: sign)
                numberBefore = resultValue;
            }
            else
            {
                if(resultLabel.text!.contains("-")){
                    numberBefore = Double(resultLabel.text!)! * -1;
                } else {
                    numberBefore = Double(resultLabel.text!)!;
                }
            }
            resultLabel.text = "*";
            operation = "*";
        }
        if(sign == "/"){
            if(operation != ""){
                doMath(sign: sign)
                numberBefore = resultValue;
            }
            else
            {
                if(resultLabel.text!.contains("-")){
                    numberBefore = Double(resultLabel.text!)! * -1;
                } else {
                    numberBefore = Double(resultLabel.text!)!;
                }
            }
            resultLabel.text = "/";
            operation = "/";
        }
        if(sign == "="){
            doMath(sign: sign);
        }
    }
    
    func doMath(sign: String){
        if(resultLabel.text!.contains("-")){
            numberOnScreen = Double(resultLabel.text!)! * -1;
        } else {
            numberOnScreen = Double(resultLabel.text!)!;
        }
        if(operation == "+"){
            operation = "";
            resultValue = numberBefore  + numberOnScreen;
        }
        if(operation == "-"){
            operation = "";
            resultValue = numberBefore  - numberOnScreen;
        }
        if(operation == "/"){
            operation = "";
            if(numberOnScreen == 0) {
                resultLabel.text = String("DIV BY 0!");
                return;
            }
            else {
                resultValue = numberBefore  / numberOnScreen;
            }
            
        }
        if(operation == "*"){
            operation = "";
            resultValue = numberBefore  * numberOnScreen;
        }
        resultLabel.text = String(resultValue)
    }

}
