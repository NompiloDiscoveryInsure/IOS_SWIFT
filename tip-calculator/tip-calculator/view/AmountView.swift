//
//  AmountView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/13.
//

import UIKit

class AmountView: UIView{
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: title,
            font: Themefont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: textAlignment)
    }()
    
    
    private lazy var AmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "$0",
            attributes:
                [.font: Themefont.bold(ofSize: 24)])
        text.addAttributes([.font: Themefont.bold(ofSize: 16)],
                           range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
        
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[
            titleLabel,
            AmountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(title: String, textAlignment: NSTextAlignment){
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double){
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [.font: Themefont.bold(ofSize: 24)])
        text.addAttributes([
            .font: Themefont.bold(ofSize: 16)],
            range: NSMakeRange(0, 1))
        AmountLabel.attributedText = text
    }
    
    private func layout(){
        addSubview(stackView)
        stackView.snp.makeConstraints({
            make in
            make.edges.equalToSuperview()
        })
    }
}
