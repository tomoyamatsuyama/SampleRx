//
//  ViewController.swift
//  SampleRx
//
//  Created by Tomoya Matsuyama on 2018/03/10.
//  Copyright © 2018年 Tomoya Matsuyama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var button: UIButton!
    private let disposeBag = DisposeBag()
    
    private func labelSet(text: String) {
        guard let text = textField.text else { return }
        label.text = text
    }
    
    private func bind() {
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self] text in
                guard let `self` = self else { return }
                self.labelSet(text: text)
            })
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.asObservable()
            .map { $0.count > 0}
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.isEnabled = false
        bind()
    }
}

