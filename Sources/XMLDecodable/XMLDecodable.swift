//
//  XMLDecodable.swift
//  IBDecodable
//
//  Created by SaitoYuta on 2018/04/22.
//
import Foundation

typealias XMLAttribute = (name: String, text: String)
protocol XMLAttributeDecodable {
    static func decode(_ attribute: XMLAttribute) throws -> Self
}

protocol XMLDecodable {

    static func decode(_ xml: XMLIndexerType) throws -> Self
}

func decodeValue<T: XMLDecodable>(_ xml: XMLIndexerType) throws -> T {
    return try T.decode(xml)
}

func decodeValue<T: XMLDecodable>(_ xml: XMLIndexerType) -> T? {
    return try? T.decode(xml)
}

protocol KeyDecodable: Encodable {
}

enum XMLAttributeDecodeError: Error {
    case attributeDeserializationFailed(type: String, attribute: XMLAttribute)
}

extension String: XMLAttributeDecodable {
    static func decode(_ attribute: XMLAttribute) throws -> String {
        attribute.text
    }
}
extension Int: XMLAttributeDecodable {
    static func decode(_ attribute: XMLAttribute) throws -> Int {
        guard let value = Int(attribute.text) else {
            throw XMLAttributeDecodeError.attributeDeserializationFailed(
                type: "Int", attribute: attribute
            )
        }
        return value
    }
}
extension Float: XMLAttributeDecodable {
    static func decode(_ attribute: XMLAttribute) throws -> Float {
        guard let value = Float(attribute.text) else {
            throw XMLAttributeDecodeError.attributeDeserializationFailed(
                type: "Float", attribute: attribute
            )
        }
        return value
    }
}
extension Bool: XMLAttributeDecodable {
    static func decode(_ attribute: XMLAttribute) throws -> Bool {
        guard let value = Bool(attribute.text) else {
            throw XMLAttributeDecodeError.attributeDeserializationFailed(
                type: "Bool", attribute: attribute
            )
        }
        return value
    }
}
extension Double: XMLAttributeDecodable {
    static func decode(_ attribute: XMLAttribute) throws -> Double {
        guard let value = Double(attribute.text) else {
            throw XMLAttributeDecodeError.attributeDeserializationFailed(
                type: "Double", attribute: attribute
            )
        }
        return value
    }
}
