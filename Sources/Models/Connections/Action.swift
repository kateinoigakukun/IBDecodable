//
//  Action.swift
//  IBDecodable
//
//  Created by SaitoYuta on 2018/04/20.
//



public struct Action: IBDecodable, ConnectionProtocol {
    public let id: String
    public let destination: String
    public let selector: String
    public let eventType: String?

    static func decode(_ xml: XMLIndexerType) throws -> Action {
        let container = xml.container(keys: CodingKeys.self)
        return Action(
            id:          try container.attribute(of: .id),
            destination: try container.attribute(of: .destination),
            selector:    try container.attribute(of: .selector),
            eventType:   container.attributeIfPresent(of: .eventType)
        )
    }
}
