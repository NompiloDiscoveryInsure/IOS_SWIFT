//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import UIKit
import Combine
import CombineCocoa


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
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = Themefont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.tapPublisher.sink{
            _ in
            self.handleCustomTipButton()
        }.store(in: &cancellables)
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
    
    //creates observable which passes input to viewSubject ---they accept/emit values
    private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    func reset() {
        tipSubject.send(.none)
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
    
//handle custom tip button
    private func handleCustomTipButton() {
        let alertController : UIAlertController = {
            let controller = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert)
            controller.addTextField{
                textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
                textField.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue
            }
            let cancelAction = UIAlertAction(
                title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(
                title: "OK", style: .default){
                    [weak self] _ in
                    guard let text = controller.textFields?.first?.text,
                          let value = Int(text) else {return}
                    self?.tipSubject.send(.custom(value: value))
                }
            [okAction, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        parentViewController?.present(alertController, animated: true)
    }
    
    //create an observe function that changes the state of the button
    private func observe(){
        tipSubject.sink {
            [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(
                    string: "$\(value)",
                    attributes: [.font: Themefont.bold(ofSize: 20)])
                text.addAttributes([
                    .font: Themefont.bold(ofSize: 14)
                ],range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    
    //set buttons to unselected state
    private func resetView(){
        [tenPercentTipButton,
        fifteenPercentTipButton,
        twentyPercentTipButton,
         customTipButton].forEach{
            $0.backgroundColor = ThemeColor.primary
        }
        let text = NSMutableAttributedString(
            string: "Custom tip",
            attributes: [.font: Themefont.bold(ofSize: 20)])
        customTipButton.setAttributedTitle(text, for: .normal)
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
