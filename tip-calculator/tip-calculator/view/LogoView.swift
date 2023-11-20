//
//  LogoView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import UIKit

class LogoView: UIView{
    
    //1. add image
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(imageLiteralResourceName: "icCalculatorBW"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    //2. create top label
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mrs Tip",
            attributes: [.font: Themefont.demibold(ofSize: 16)])
        text.addAttributes([.font: Themefont.bold(ofSize: 24)], range: NSMakeRange(3, 4) )// Changes size and font for the word tip
        label.attributedText = text
        return label
    }()
    
    //3. create bottom label
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: "Calculator",
                           font: Themefont.demibold(ofSize: 20),
                           textAlignment: .left
        )
    }()
    
    //4. Add a stack view to align image and logo text
    
    //vertical stack
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel])
        view.axis = .vertical
        view.spacing = -4
        view.alignment = .center
        return view
    }()
    
    //horizontal stack
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            imageView,
            vStackView])
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    //5. create layout that will implement the logo view
    private func layout(){
        addSubview(hStackView)
        hStackView.snp.makeConstraints{
            make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            make in
            make.height.equalTo(imageView.snp.width)
        }
    }
    
}
