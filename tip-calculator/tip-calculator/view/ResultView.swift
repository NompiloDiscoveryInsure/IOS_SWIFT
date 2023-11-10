//
//  ResultView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import UIKit

class ResultView: UIView{
    
    
    //1 Create header label
    private let headerLabel: UILabel = {
        LabelFactory.build(
            text: "Total p/person",
            font: Themefont.demibold(ofSize: 18))
    }()
    
    //2. create amount label
    private let AmountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0",
            attributes:[ .font: Themefont.bold(ofSize: 48)
                       ])
        text.addAttributes([
            .font: Themefont.bold(ofSize: 24)],
                           range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    // 3. create seperator line
    private let horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.seperator
        return view
    }()
    
    
    //4. Add a stack view to align image and logo text
    
    //vertical stack
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            AmountPerPersonLabel,
            horizontalLine,
            buildSpacerView(height: 0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    //horizontal stack
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            AmountView(title: "Total bill", textAlignment: .left),
            UIView(),
            AmountView(title: "Total Tip", textAlignment: .right)])
        stackView.axis = .horizontal
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
    
    //5. put together overall layout
    private func layout(){
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints{
            make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            
        }
        
        horizontalLine.snp.makeConstraints{
            make in
            make.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 0), color: .black, radius: 12.0, opacity: 0.1)
        
    }
    
    //6. create space element to add space below horizontal line
    private func buildSpacerView(height:CGFloat) -> UIView{
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    //7. create amountview class
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
        
        
        private lazy var AmoutLabel: UILabel = {
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
                AmoutLabel
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
        
        private func layout(){
            addSubview(stackView)
            stackView.snp.makeConstraints({
                make in
                make.edges.equalToSuperview()
            })
        }
        
    }
}


