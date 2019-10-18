//
//  LiteralValue.swift
//  LiteralValue
//
//  Created by David.Thorn on 18.10.19.
//  Copyright © 2019 David.Thorn. All rights reserved.
//

import Foundation

public protocol Convertable: Codable {
    init?(literalValue: String?)
}

extension Int: Convertable {
    public init?(literalValue: String?) {
        guard let value = literalValue else { return nil }
        self.init(value)
    }
}

extension Double: Convertable {
    public init?(literalValue: String?) {
        guard let value = literalValue else { return nil }
        self.init(value)
    }
}

extension CGFloat: Convertable {
    public init?(literalValue: String?) {
        guard let value = literalValue, let doubleValue = Double(value) else { return nil }
        self.init(doubleValue)
    }
}

extension Bool: Convertable {
    public init?(literalValue: String?) {
        guard let value = literalValue else { return nil }
        self.init(value)
    }
}

public struct Literal<T: Convertable>: Codable {
    
    typealias Value = T
    let value: Value?
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()
        do {
            value = try values.decode(T.self)
        } catch let error {
            guard let stringValue = try? values.decode(String.self) else {
                throw error
            }
            
            value = T(literalValue: stringValue)
        }
    }
    
}
