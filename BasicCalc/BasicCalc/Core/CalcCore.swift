//
//  CalcCore.swift
//  BasicCalc
//
//  Created by Vitaliy Grinevetsky on 6/11/19.
//  Copyright © 2019 Vitaliy Grinevetsky. All rights reserved.
//

import Foundation

protocol CalcCoreDelegate:class{
    func calculatedResult(result:String, history:String?)
}


class  CalcCore {
    weak var delegate: CalcCoreDelegate?
    
    static private let operations  = ["+", "-", "/", "*"]

    internal var stack = [String]()
    
    internal var history: String?
    internal var result: String?
    
    func push(_ symbol:String){
        
        if CalcCore.operations.contains(symbol){ // operation
            handleOperation(symbol)
        }else if symbol == "."{ // .
            fractionAppending()
            return
        }else if symbol == "%"{ // calculate &&
            handlePercentage()
        }else if symbol == "±"{ // plus/minus operation
            handlePlusMinus()
        }else if  symbol == "="{
            calculateResult()
            return
        }else if symbol.isNumber{
            handleNumeric(symbol)
        }else if symbol == "C"{
            clear()
            return
        }else {
            print("Unknown")
        }
        calculateResult()
    }
    
    private func isLastOperation() -> Bool{
        guard let last = stack.last  else {
            return false
        }
        return CalcCore.operations.contains(last) ? true : false
        
    }
    
    private func handleOperation(_ currentOperation:String){
        
        guard var last = stack.last else {
            stack.append("0")
            stack.append(currentOperation)
            return
        }
    
        if CalcCore.operations.contains(last){
            print("handling operation")
            stack.removeLast() //remove last operation
            stack.append(currentOperation) // add operation
        }else {
            if last.contains("."){
                last = last + "0"
                stack[stack.count - 1] = last
            }
            stack.append(currentOperation)
        }
    }
    
    private func fractionAppending(){
        guard var last = stack.last else {
            stack.append("0.")
            return
        }
        if isLastOperation(){
            stack.append("0.")
        }else if last.contains("."){
            return
        }else{
            last = last + "."
            stack[stack.count - 1] = last
        }
    }
    
    private func handlePercentage(){
        guard let last = stack.last else {
            return
        }
        if !isLastOperation(){
            let res = doMath( last + "/100.0")
            stack.removeLast()
            stack.append(res)
        }
    }
    
    private func prepareExpression() -> String {
        
        var resValue = ""
        for currentValue in stack{
            if CalcCore.operations.contains(currentValue){
                resValue = resValue + currentValue
            }else {
                if currentValue.contains("."){
                    resValue = resValue + currentValue
                }else {
                    resValue = resValue + currentValue + ".0"
                }
            }
        }
        return resValue
    }
    
    private func doMath(_ string: String) -> String{
        guard let last = string.last else {
            return "0"
        }
        let res:String = last == "." ? string + "0" : string
            
        let expression = NSExpression(format: res)
        guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else {
            return "0"
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        guard let value = formatter.string(from: NSNumber(value: mathValue)) else {
            return "0"
        }
        print("\(value)")
        return value
    }
    
    private func handlePlusMinus(){
        guard var last = stack.last else {
            stack.append("-0")
            return
        }
        if isLastOperation(){
            stack.append("-0")
        }else {
            if last.contains("-"){
                last = last.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range:nil)
            }else{
                last = "-" + last
            }
            stack[stack.count - 1] = last
        }
        

    }
    
    private func handleNumeric(_ symbol:String){
        guard var last = stack.last else {
            stack.append(symbol)
            return
        }
        if isLastOperation() {
            stack.append(symbol)
        }else {
            if last == "0"{
                last = symbol
            }else if last == "-0"{
                last = "-" + symbol
            }else {
                last = last+symbol
            }
            stack.removeLast()
            stack.append(last)
        }
    }
    
    internal func clear(){
        stack.removeAll()
        delegate?.calculatedResult(result: "0", history:stack.joined())
    }
    
    private func calculateResult(){
        // need to handle  x/0 -> Error
        // -1! -> Impossible as well
        if isLastOperation(){
            return
        }
        let entireString = prepareExpression()
        let res = doMath(entireString)
        delegate?.calculatedResult(result: res, history:stack.joined(separator: " "))
    }
    
}
