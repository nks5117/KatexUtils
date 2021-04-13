//
//  Bundle+KatexUtils.swift
//  KatexUtils
//
//  Created by nikesu on 2021/3/11.
//

import Foundation

extension Bundle {
    static let katexBundle : Bundle? = {
        guard let bundlePath = Bundle(for: KatexUtil.self).path(forResource: "KatexUtils", ofType: "bundle") else {
            return nil
        }
        return Bundle(path: bundlePath)
    }()
}

private class KatexUtil {

}
