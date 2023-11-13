//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/13.
//

import UIKit

class HeaderView: UIView{
    
    private let topLable: UILabel = {
        LabelFactory.build(
            text: nil,
            font: Themefont.bold(ofSize: 18))
    }()
    
    private let bottomLable: UILabel = {
        LabelFactory.build(
            text: nil,
            font: Themefont.regular(ofSize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[
        topSpacerView,
        topLable,
        bottomLable,
        bottomSpacerView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -6
        return stackView
    }()
    
    
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    private func layout(){
        addSubview(stackView)
        stackView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
        topSpacerView.snp.makeConstraints{
            make in
            make.height.equalTo(bottomSpacerView)
        }
    }
    
    func configure(topText: String, bottomText: String){
        topLable.text = topText
        bottomLable.text = bottomText
    }
}
