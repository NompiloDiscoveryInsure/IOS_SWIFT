//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView{
    
    //1. Add header view
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Split",
            bottomText: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(
            text: "-",
            corners: [.layerMinXMaxYCorner, .layerMinXMaxYCorner])
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.decrementButton.rawValue
        button.tapPublisher.flatMap{[unowned self] _ in
          Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(
            text: "+",
            corners: [.layerMaxXMinYCorner, .layerMaxXMinYCorner])
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.incrementButton.rawValue
        button.tapPublisher.flatMap{[unowned self] _ in
         Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(
            text: "1",
            font: Themefont.bold(ofSize: 20),
            backgroundColor: .white)
            label.accessibilityIdentifier = ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    //creates observable which passes input to viewSubject ---they accept/emit values
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    func reset() {
        splitSubject.send(1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    private func layout(){
        [headerView, stackView].forEach(addSubview(_:))
        
        stackView.snp.makeConstraints{
            make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [incrementButton,decrementButton].forEach{
            button in
            button.snp.makeConstraints{
                make in
                make.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints{
            make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stackView.snp.centerY)
            make.trailing.equalTo(stackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }
    
    private func observe() {
        splitSubject.sink {[unowned self]
            quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellables)
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = Themefont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.addRoundCorners(corners: corners, radius: 8.0)
        return button
    }
}
