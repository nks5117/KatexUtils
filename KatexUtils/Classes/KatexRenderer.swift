//
//  KatexRenderer.swift
//  KatexUtils
//
//  Created by nikesu on 2021/3/9.
//

import JavaScriptCore
import UIKit

public class KatexRenderer {
    private static var katex = Katex()

    public static func renderToString(latex: String, options: [Katex.Key : Any]? = nil) throws -> String {
        try katex.renderToString(latex: latex, options: options)
    }
}
