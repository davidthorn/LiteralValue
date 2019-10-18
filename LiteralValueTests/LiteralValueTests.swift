//
//  LiteralValueTests.swift
//  LiteralValueTests
//
//  Created by David.Thorn on 18.10.19.
//  Copyright © 2019 David.Thorn. All rights reserved.
//

import XCTest
@testable import LiteralValue

class LiteralValueTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        struct Test1: Encodable {
            let num: String
            let bool: String
            let double: String
            let cgfloat: String
        }
        
        struct Test1a: Encodable {
            let num: Int
            let bool: Bool
            let double: Double
            let cgfloat: CGFloat
        }
        
        struct Test2: Decodable {
            let num: Literal<Int>
            let bool: Literal<Bool>
            let double: Literal<Double>
            let cgfloat: Literal<CGFloat>
        }
        
        let value = Test1.init(num: "one", bool: "falsey", double: "one.33344", cgfloat: "two.2345")
        let encodedValue = try! JSONEncoder().encode(value)
        let literalInt = try! JSONDecoder().decode(Test2.self, from: encodedValue)
        
        let value1 = Test1a.init(num: 1, bool: false, double: 1.33344, cgfloat: 1.2345)
        let encodedValue1 = try! JSONEncoder().encode(value1)
        let literalInt1 = try! JSONDecoder().decode(Test2.self, from: encodedValue1)
        
        let a = literalInt.bool.value
        let b = literalInt.num.value
        let c = literalInt.cgfloat.value
        let d = literalInt.double.value
        
        let e = literalInt1.bool.value
        let f = literalInt1.num.value
        let g = literalInt1.cgfloat.value
        let h = literalInt1.double.value
        
        let dict: [String: Any?] = [
            "num" : "1",
            "bool": "true",
            "double" : "2.222",
            "cgfloat" : "5.433"
        ]
        
        let dict1: [String: Any?] = [
            "num" : 1,
            "bool": true,
            "double" : 2.222,
            "cgfloat" : 5.433
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: dict1, options: .prettyPrinted)
        
        let decodedLiteral = try! JSONDecoder().decode(Test2.self, from: jsonData)
        let i = decodedLiteral.bool.value
        let j = decodedLiteral.num.value
        let k = decodedLiteral.cgfloat.value
        let l = decodedLiteral.double.value
    }

}
