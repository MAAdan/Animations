//
//  EnumSequenceProtocol.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 30/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

protocol EnumSequence {
    associatedtype T: RawRepresentable where T.RawValue == Int
}

extension EnumSequence {
    static func all() -> AnySequence<T> {
        return AnySequence { return EnumGenerator() }
    }
}

private struct EnumGenerator<T: RawRepresentable>: IteratorProtocol where T.RawValue == Int {
    
    var index = 0
    mutating func next() -> T? {
        guard let item = T(rawValue: index) else {
            return nil
        }
        
        index += 1
        return item
    }
}
