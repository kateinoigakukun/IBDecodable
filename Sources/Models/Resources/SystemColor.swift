//
//  SystemColor.swift
//  IBDecodable
//
//  Created by kateinoigakukun on 2021/01/18.
//

import SWXMLHash

public struct SystemColor: IBDecodable, ResourceProtocol {
    public let name: String
    public let color: Color

    static func decode(_ xml: XMLIndexerType) throws -> SystemColor {
        let container = xml.container(keys: CodingKeys.self)
        return SystemColor(
            name:  try container.attribute(of: .name),
            color: try container.element(of: .color)
        )
    }
}
