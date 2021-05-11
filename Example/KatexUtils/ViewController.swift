//
//  ViewController.swift
//  KatexUtils
//
//  Created by nikesu on 03/05/2021.
//  Copyright (c) 2021 nikesu. All rights reserved.
//

import UIKit
import KatexUtils
import Combine

class ViewController: UIViewController {
    let latexs = [
        #"f(x, y)=\frac{1}{2 \pi \sigma_{1} \sigma_{2} \sqrt{1-\rho^{2}}} \exp \left\{-\frac{1}{2\left(1-\rho^{2}\right)}\left(\frac{\left(x-\mu_{1}\right)^{2}}{\sigma_{1}^{2}}-\frac{2 \rho\left(x-\mu_{1}\right)\left(y-\mu_{2}\right)}{\sigma_{1} \sigma_{2}}+\frac{\left(y-\mu_{2}\right)^{2}}{\sigma_{2}^{2}}\right)\right\}"#,
        #"a+b"#,
        #"a^2+b^2=c^2"#,
        #"c = \pm\sqrt{a^2 + b^2}\in\RR"#,
        #"F(x)=P(X \leq x)=\int_{-\infty}^{x} f(t) \, \mathrm{d} t, \quad x \in \R"#,
        #"""
        % \f is defined as #1f(#2) using the macro
        
        \f\relax{x} = \int_{-\infty}^\infty
        \f\hat\xi\,e^{2 \pi i \xi x}
        \,\mathrm{d}\xi
        """#
    ]

    lazy var katexView : KatexView = {
        let katexView = KatexView(latex: latexs[5],  options: [.displayMode: true, .macros: [#"\RR"#: #"\mathbb{R}"#, #"\f"#: #"#1f(#2)"#]])
        katexView.backgroundColor = .darkGray
        katexView.customCss = ".katex { color: white; }"
        return katexView
    }()
    
    lazy var textView : UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.spellCheckingType = .no
        textView.smartQuotesType = .no
        textView.smartDashesType = .no
        textView.smartInsertDeleteType = .no
        textView.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        return textView
    }()
    
    lazy var modeSwitch : UISwitch = {
        let modeSwitch = UISwitch()
        modeSwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
        modeSwitch.isOn = katexView.displayMode
        return modeSwitch
    }()
    
    lazy var displayModeLabel = UILabel()
    
    lazy var errorLabel = UILabel()

    var cancellables = [AnyCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(katexView)
        view.addSubview(textView)
        view.addSubview(modeSwitch)
        view.addSubview(displayModeLabel)
        view.addSubview(errorLabel)
        displayModeLabel.text = "Display Mode"
        displayModeLabel.textAlignment = .center
        textView.text = katexView.latex
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.numberOfLines = 0
        errorLabel.text = ""
        katexView.$status.sink { [weak self] (status) in
            switch status {
            case .error(let message):
                self?.errorLabel.text = "error: \(message)"
                self?.view.setNeedsLayout()
            case .finished:
                self?.errorLabel.text = ""
                self?.view.setNeedsLayout()
            default:
                break
            }
        }.store(in: &cancellables)
    }

    override func viewWillLayoutSubviews() {
        view.backgroundColor = .gray
        modeSwitch.backgroundColor = .white
        displayModeLabel.backgroundColor = .white
        displayModeLabel.textColor = .black
        katexView.frame = CGRect(x: 0, y: 100, width: min(katexView.intrinsicContentSize.width, UIScreen.main.bounds.width), height: min(katexView.intrinsicContentSize.height, 200))
        textView.frame = CGRect(x:0, y: 310, width: UIScreen.main.bounds.width, height: 200)
        displayModeLabel.sizeToFit()
        displayModeLabel.frame = CGRect(x: 0, y: 520, width: displayModeLabel.frame.width + 20, height: modeSwitch.frame.height)
        modeSwitch.frame.origin = CGPoint(x: displayModeLabel.frame.width, y: 520)
        errorLabel.frame.origin = CGPoint(x: 0, y: 530 + modeSwitch.frame.height)
        errorLabel.frame.size = errorLabel.sizeThatFits(UIScreen.main.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        katexView.latex = textView.text
    }
}


extension ViewController {
    @objc func switchAction(_ modeSwitch: UISwitch) {
        katexView.displayMode = modeSwitch.isOn
    }
}
