//
//  BillInputView.swift
//  tip-calculator
//
//  Created by Nompilo Moyo on 2023/11/09.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView{
    
    // 1. Add top and bottom label calling custom header function
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Enter",
            bottomText: "Your bill")
        return view
    }()
    
    //2. Add in text area
    private let textFieldContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    //3. add currency label
    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(text: "$", font: Themefont.bold(ofSize: 24))
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    //4. create text field
    private lazy var textField: UITextField = {
       let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.font = Themefont.demibold(ofSize: 28)
        textfield.keyboardType = .decimalPad
        textfield.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textfield.tintColor = ThemeColor.text
        textfield.textColor = ThemeColor.text
        //add toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped))
        toolbar.items = [
        UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil),
        doneButton]
        toolbar.isUserInteractionEnabled = true
        textfield.inputAccessoryView = toolbar
        return textfield
    }()
    
    //creates observable which passes input to viewSubject ---they accept/emit values
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    //create observer function that takes input value
    private func observe(){
        textField.textPublisher.sink{[unowned self]
            text in
            billSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellables)
    }
    
    
    //4. generate layout
    private func layout(){
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        headerView.snp.makeConstraints{
            make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.height.equalTo(24)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints{
            make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)
        
        currencyDenominationLabel.snp.makeConstraints{
            make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints{
            make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.leading).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
    
    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
}

