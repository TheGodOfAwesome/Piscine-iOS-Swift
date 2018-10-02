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
    var canOperate:Bool = false;
    var operation:String = "";
    var resultString:String = "";
    var newString:String = "";
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func onClick1(_ sender: UIButton) {
        newString = "1";
        resultString += newString;
        resultLabel.text = resultString;
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick2(_ sender: UIButton) {
        newString = "2";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick3(_ sender: UIButton) {
        newString = "3";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick4(_ sender: UIButton) {
        newString = "4";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick5(_ sender: UIButton) {
        newString = "5";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick6(_ sender: UIButton) {
        newString = "6";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick7(_ sender: UIButton) {
        newString = "7";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick8(_ sender: UIButton) {
        newString = "8";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick9(_ sender: UIButton) {
        newString = "9";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClick0(_ sender: UIButton) {
        newString = "0";
        resultString += newString;
        resultLabel.text = resultString
        print(newString);
        canOperate = true;
    }
    
    @IBAction func onClickPlus(_ sender: UIButton) {
        if (canOperate == true){
            calculate(sign: "+");
            print("+");
            canOperate = false;
        }
    }
    
    @IBAction func onClickMinus(_ sender: UIButton) {
        if (canOperate == true){
            calculate(sign: "-");
            print("-");
            canOperate = false;
        }
    }
    
    @IBAction func onClickDivide(_ sender: UIButton) {
        if (canOperate == true){
            calculate(sign: "/");
            print("/");
            canOperate = false;
        }
    }
    
    @IBAction func onClickMultiply(_ sender: UIButton) {
        if (canOperate == true){
            calculate(sign: "*");
            print("*");
            canOperate = false;
        }
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
        if (canOperate == true){
            calculate(sign: "=");
            print("=");
            canOperate = false;
        }
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
        canOperate = false;
        operation = "";
        resultString = "";
        newString = "";
        resultLabel.text = "0";
    }
    
    func clearFunc(){
        numberOnScreen = 0;
        numberBefore = 0;
        resultValue = 0;
        canCalculate = false;
        canOperate = false;
        operation = "";
        resultString = "";
        newString = "";
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
            clearFunc();
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
        //resultLabel.text = String(resultValue);
        //print();
        printResult(result: resultValue)
    }

    func printResult(result: Double){
        if (floor(result) == result) {
            let intRes:Int = Int(result);
            resultLabel.text = String(intRes);
        }else{
            resultLabel.text = String(result);
        }
    }
}
