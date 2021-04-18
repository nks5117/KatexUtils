//
//  ViewController.swift
//  KatexUtils
//
//  Created by nikesu on 03/05/2021.
//  Copyright (c) 2021 nikesu. All rights reserved.
//

import UIKit
import KatexUtils

class ViewController: UIViewController {
    let latexs = [
        #"f(x, y)=\frac{1}{2 \pi \sigma_{1} \sigma_{2} \sqrt{1-\rho^{2}}} \exp \left\{-\frac{1}{2\left(1-\rho^{2}\right)}\left(\frac{\left(x-\mu_{1}\right)^{2}}{\sigma_{1}^{2}}-\frac{2 \rho\left(x-\mu_{1}\right)\left(y-\mu_{2}\right)}{\sigma_{1} \sigma_{2}}+\frac{\left(y-\mu_{2}\right)^{2}}{\sigma_{2}^{2}}\right)\right\}"#,
        #"a+b"#,
        #"a^2+b^2=c^2"#,
        #"c = \pm\sqrt{a^2 + b^2}\in\RR"#,
    ]

    lazy var katexView = KatexView(latex: latexs[0], options: [.displayMode: true, .macros: [#"\RR"#: #"\mathbb{R}"#]])
    
    lazy var textView = UITextView()
    
    lazy var modeSwitch : UISwitch = {
        let modeSwitch = UISwitch()
        modeSwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
        modeSwitch.isOn = katexView.displayMode
        return modeSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(katexView)
        view.addSubview(textView)
        view.addSubview(modeSwitch)
        textView.delegate = self
        textView.text = latexs[0]
    }

    override func viewWillLayoutSubviews() {
        view.backgroundColor = .blue
        modeSwitch.backgroundColor = .white
        katexView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 200)
        textView.frame = CGRect(x:0, y: 300, width: UIScreen.main.bounds.width, height: 200)
        modeSwitch.frame.origin = CGPoint(x: 10, y: 510)
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
