//
//  BasicCalcTests.swift
//  BasicCalcTests
//
//  Created by Vitaliy Grinevetsky on 6/11/19.
//  Copyright © 2019 Vitaliy Grinevetsky. All rights reserved.
//

import XCTest
@testable import BasicCalc

class BasicCalcTests: XCTestCase {
    
    let core = CalcCore()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppendSymbol(){
        core.clear()
        core.push("1")
        
    }
    
    func testClear(){
        core.clear()
    }
    
    func testAddTwoSymbols(){
        core.clear()
        core.push("1")
        core.push("2")
    }
    
    func testAddOperationToEmpty(){
        core.clear()
        core.push("*")
    }
    
    func getLast() -> String{
        guard let last = core.stack.last else {
            return "@"
        }
        return last
    }
    func getFullString() -> String {
        return core.stack.joined(separator:"")
    }
    func testFractionFirstOperand(){
        core.clear()
        core.push("1")
        core.push(".")
        core.push("1")
        XCTAssertTrue(core.stack.joined(separator:"") == "1.1", "Error in last")
    }
    
    func testComa(){
        core.clear()
        core.push("1")
        core.push(".")
        core.push("-")
        core.push("2")
        XCTAssertTrue(core.stack.joined(separator:"") == "1.0-2", "Error in last")
    }
    
    func testMultipleZeros(){
        core.clear()
        core.push("0")
        core.push("0")
        core.push("0")
        XCTAssertTrue(core.stack.joined(separator:"") == "0", "Error in last")
    }
    
    
    func testFractionSecondOperand(){
        core.clear()
        core.push("1")
        core.push("-")
        core.push("2")
        core.push(".")
        core.push("3")
        XCTAssertTrue(core.stack.joined(separator:"") == "1-2.3", "Error in last")
    }
    
    
    func testPlusOperation() {
        core.clear()
        core.push("+")
        XCTAssertTrue(core.stack.joined(separator:"") == "0+", "Error in last")
    }
    
    func testMinusOperation() {
        core.clear()
        core.push("-")
        XCTAssertTrue(core.stack.joined(separator:"") == "0-", "Error in last")
    }
    
    func testDivideOperation() {
        core.clear()
        core.push("/")
        XCTAssertTrue(core.stack.joined(separator:"") == "0/", "Error in last")
    }
    
    func testHandleOperandandOperation(){
        core.clear()
        core.push("1")
        core.push("+")
        XCTAssertTrue(core.stack.joined(separator:"") == "1+", "Error in last")
    }
    
    func testHandleLongNumericAndOperation(){
        core.clear()
        core.push("1")
        core.push("1")
        core.push("-")
        core.push(("9"))
        XCTAssertTrue(core.stack.joined(separator:"") == "11-9", "Error in last")
    }
    
    func testPlusMinusForFirstOperand(){
        core.clear()
        core.push("±")
        XCTAssertTrue(core.stack.joined(separator:"") == "-0", "Error in last")
        core.push("1")
        XCTAssertTrue(core.stack.joined(separator:"") == "-1", "Error in last")
        core.push("±")
        XCTAssertTrue(core.stack.joined(separator:"") == "1", "Error in last")
        core.push("±")
        XCTAssertTrue(core.stack.joined(separator:"") == "-1", "Error in last")
    }
    
    func testReplaceOperation(){
        core.clear()
        core.push("+")
        XCTAssertTrue(core.stack.joined(separator:"") == "0+", "Error in last")
        core.push("-")
        XCTAssertTrue(core.stack.joined(separator:"") == "0-", "Error in last")
    }
    func testResetOperation(){
        core.clear()
        XCTAssertTrue(core.stack.joined(separator:"") == "", "Error in last")
        core.push("1")
        core.push("+")
        core.push("1")
        XCTAssertTrue(core.stack.joined(separator:"") == "1+1", "Error in last")
        core.push("C")
        XCTAssertTrue(core.stack.joined(separator:"") == "", "Error in last")
    }
    
    func testPlusMinusForSecondOperandZero() {
        core.clear()
        core.push("1")
        core.push("-")
        core.push("±")
        XCTAssertTrue(core.stack.joined() == "1--0", "Error in last")
    }
    
    func testPlusMinusForSecondOperand() {
        core.clear()
        core.push("1")
        core.push("-")
        core.push("1")
        core.push("±")
        XCTAssertTrue(core.stack.joined() == "1--1", "Error in last")
    }
    
    func testPercentageFirstOperand(){
        core.clear()
        core.push("1")
        core.push("0")
        core.push("0")
        core.push("%")
        XCTAssertTrue(core.stack.joined() == "1", "Error in last")
        core.push("%")
        XCTAssertTrue(core.stack.joined() == "0.01", "Error in last")
    }
    
    func testPercentageSecondOperand(){
        core.clear()
        core.push("1")
        core.push("-")
        core.push("2")
        core.push("%")
        XCTAssertTrue(core.stack.joined() == "1-0.02", "Error in last")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
