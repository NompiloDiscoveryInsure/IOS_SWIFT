//
//  tip_calculatorSnapshotTests.swift
//  tip-calculatorTests
//
//  Created by Nompilo Moyo on 2023/11/17.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator

final class tip_CalculatorSnapshotTests: XCTestCase{
    
    private var screenWidth: CGFloat{
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView(){
        //given
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = LogoView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialResultView(){
        //given
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let view = ResultView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView(){
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialBillInputView(){
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    
    func testInitialSplitInputView(){
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    
    func testInitialCustomInputView(){
        //given
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let view = TipInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size),record: true)
    }
    
    
    
    
    
}


