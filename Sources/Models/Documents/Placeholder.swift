//
//  Placeholder.swift
//  IBDecodable
//
//  Created by phimage on 08/04/2018.
//

import SWXMLHash

public struct Placeholder: IBDecodable, IBIdentifiable {

    public let id: String
    public let placeholderIdentifier: String
    public let userLabel: String?
    public let colorLabel: String?
    public let sceneMemberID: String?
    public let customClass: String?
    public let userComments: AttributedString?

    enum ExternalCodingKeys: CodingKey { case attributedString }
    enum AttributedStringCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexer) throws -> Placeholder {
        let container = xml.container(keys: CodingKeys.self)
        let attributedStringContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .attributedString, keys: AttributedStringCodingKeys.self)
        return Placeholder(
            id:                    try container.attribute(of: .id),
            placeholderIdentifier: try container.attribute(of: .placeholderIdentifier),
            userLabel:             container.attributeIfPresent(of: .userLabel),
            colorLabel:            container.attributeIfPresent(of: .colorLabel),
            sceneMemberID:         container.attributeIfPresent(of: .sceneMemberID),
            customClass:           container.attributeIfPresent(of: .customClass),
            userComments:          attributedStringContainer?.withAttributeElement(.key, "userComments")
        )
    }

}