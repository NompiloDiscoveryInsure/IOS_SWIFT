//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {

    // SUT -> System Under Test
    private var sut: CalculatorVM!
    private var canceallables: Set<AnyCancellable>!
    
    private let logoViewTapSubject = PassthroughSubject<Void, Never>()
    //creates instance of sut
    override func setUp() {
        sut = .init()
        canceallables = .init()
        super.setUp()
    }
    
    //sets the sut
    override func tearDown() {
        super.tearDown()
        sut = nil
        canceallables = nil
    }
    
    func testResultTipFor1Person(){
        //given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink{
            result in
            XCTAssertEqual(result.amountPerPerson,100)
            XCTAssertEqual(result.totalBill,100)
            XCTAssertEqual(result.totalTip,0)
            
        }.store(in: &canceallables)
    }
    
    
    func testResultWithoutTipFor2Person(){
        //given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink{
            result in
            XCTAssertEqual(result.amountPerPerson,50)
            XCTAssertEqual(result.totalBill,100)
            XCTAssertEqual(result.totalTip,0)
            
        }.store(in: &canceallables)
    }
    
    func testResultWith10PercentTipFor2Person(){
        //given
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink{
            result in
            XCTAssertEqual(result.amountPerPerson,55)
            XCTAssertEqual(result.totalBill,110)
            XCTAssertEqual(result.totalTip,10)
            
        }.store(in: &canceallables)
    }
    
    
    func testResultWithCustomTipFor4Person(){
        //given
        let bill: Double = 200.0
        let tip: Tip = .custom(value: 200)
        let split: Int = 4
        let input = buildInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink{
            result in
            XCTAssertEqual(result.amountPerPerson,100)
            XCTAssertEqual(result.totalBill,400)
            XCTAssertEqual(result.totalTip,200)
            
        }.store(in: &canceallables)
    }
    
    
    private func buildInput(bill: Double, tip: Tip, split: Int) ->  CalculatorVM.Input{
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }

}
