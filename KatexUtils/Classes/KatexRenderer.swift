//
//  KatexRenderer.swift
//  KatexUtils
//
//  Created by nikesu on 2021/3/9.
//

import JavaScriptCore
import UIKit

public class KatexRenderer {
    private static var katexJsPath: String = {
        guard let path = Bundle.katexBundle?.path(forResource: "katex/katex.min", ofType: "js") else {
            fatalError()
        }
        return path
    }()

    private static var katexJsString: String = {
        do {
            let katexJsString = try String(contentsOfFile: katexJsPath, encoding: .utf8)
            return katexJsString
        } catch {
            fatalError()
        }
    }()

    private static var jsContext: JSContext = {
        guard let context = JSContext(virtualMachine: JSVirtualMachine()) else {
            fatalError()
        }
        context.exceptionHandler = { context, exception in
            if let exc = exception {
                print("JS Exception:", exc.toString() ?? "")
            }
        }
        context.evaluateScript(katexJsString, withSourceURL: URL(fileURLWithPath: katexJsPath))
        return context
    }()

    @available(*, deprecated, message: "use renderToString(latex:options:) instead")
    public static func renderHtml(latex: String) -> String {
        jsContext.setObject(latex, forKeyedSubscript: "latex" as (NSCopying & NSObjectProtocol))
        if let html = jsContext.evaluateScript("katex.renderToString(latex)")?.toString() {
            return html
        }
        return ""
    }

    public static func renderToString(latex: String, options: [Key : Any]? = nil) -> String? {
        jsContext.setObject(latex, forKeyedSubscript: "latex" as (NSCopying & NSObjectProtocol))

        var jsOptions = [String : Any]()
        if let options = options {
            for (key, value) in options {
                jsOptions[key.rawValue] = value
            }
        }

        jsContext.setObject(jsOptions, forKeyedSubscript: "options" as (NSCopying & NSObjectProtocol))

        if let html = jsContext.evaluateScript("katex.renderToString(latex, options)")?.toString() {
            return html
        }

        return nil
    }
}

public extension KatexRenderer {
    struct Key : Equatable, Hashable, RawRepresentable {

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }

        public let rawValue: String

        public typealias RawValue = String

        public static let displayMode = Key("displayMode")
        public static let output = Key("output")
        public static let leqno = Key("leqno")
        public static let fleqn = Key("fleqn")
        public static let throwOnError = Key("throwOnError")
        public static let errorColor = Key("errorColor")
        public static let macros = Key("macros")
        public static let minRuleThickness = Key("minRuleThickness")
        public static let colorIsTextColor = Key("colorIsTextColor")
        public static let maxSize = Key("maxSize")
        public static let maxExpand = Key("maxExpand")
        public static let strict = Key("strict")
        public static let trust = Key("trust")
        public static let globalGroup = Key("globalGroup")
    }
}
