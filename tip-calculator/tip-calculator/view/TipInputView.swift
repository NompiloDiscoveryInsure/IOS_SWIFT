//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import UIKit

class TipInputView: UIView{
    
    //1. Add header view
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Choose",
            bottomText: "Your tip")
        return view
    }()
    
    //2. create custom buttons
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = Themefont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    
    
    //4. create stack view for buttons
    
    //horizontal stack view
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        tenPercentTipButton,
        fifteenPercentTipButton,
        twentyPercentTipButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    //vertical stack view
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customTipButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    //5. Set up layout
    private func layout(){
        [headerView,buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints{ make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints{
            make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(buttonVStackView.snp.centerY)
            make.width.equalTo(68)
            make.height.equalTo(24)
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
        }
        
    }
    
    //3.1 button builder
    private func buildTipButton(tip: Tip) -> UIButton{
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        
        lazy var text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: Themefont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ])
        
        text.addAttributes([.font: Themefont.demibold(ofSize: 14)], range: NSMakeRange(2,1))
        
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
