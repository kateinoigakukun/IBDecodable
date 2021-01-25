//
//  ImageView.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

public struct ImageView: IBDecodable, ViewProtocol, IBIdentifiable {
    public let id: String
    public let elementClass: String = "UIImageView"

    public let key: String?
    public let adjustsImageSizeForAccessibilityContentSizeCategory: Bool?
    public let autoresizingMask: AutoresizingMask?
    public let autoresizesSubviews: Bool?
    public let alpha: Float?
    public let clipsSubviews: Bool?
    public let constraints: [Constraint]?
    public let contentMode: String?
    public let customClass: String?
    public let customModule: String?
    public let customModuleProvider: String?
    public let userLabel: String?
    public let colorLabel: String?
    public let fixedFrame: Bool?
    public let image: String?
    public let imageReference: ImageReference?
    public let preferredSymbolConfiguration: PreferredSymbolConfiguration?
    public let highlightedImage: String?
    public let catalog: String?
    public let isMisplaced: Bool?
    public let isAmbiguous: Bool?
    public let isHidden: Bool?
    public let verifyAmbiguity: VerifyAmbiguity?
    public let multipleTouchEnabled: Bool?
    public let opaque: Bool?
    public let rect: Rect?
    public let subviews: [AnyView]?
    public let translatesAutoresizingMaskIntoConstraints: Bool?
    public let userInteractionEnabled: Bool?
    public let viewLayoutGuide: LayoutGuide?
    public let userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public let connections: [AnyConnection]?
    public let variations: [Variation]?
    public let tag: Int?
    public let backgroundColor: Color?
    public let tintColor: Color?
    public let semanticContentAttribute: String?
    public let insetsLayoutMarginsFromSafeArea: Bool?
    public let layoutMarginsFollowReadableWidth: Bool?

    public let preservesSuperviewLayoutMargins: Bool?
    public let horizontalHuggingPriority: Int?
    public let verticalHuggingPriority: Int?
    public let horizontalCompressionResistancePriority: Int?
    public let verticalCompressionResistancePriority: Int?

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> ImageView {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .isHidden: return "hidden"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return ImageView(
            id:                                        try container.attribute(of: .id),
            key:                                       container.attributeIfPresent(of: .key),
            adjustsImageSizeForAccessibilityContentSizeCategory: container.attributeIfPresent(of: .adjustsImageSizeForAccessibilityContentSizeCategory),
            autoresizingMask:                          container.elementIfPresent(of: .autoresizingMask),
            autoresizesSubviews:                       container.attributeIfPresent(of: .autoresizesSubviews),
            alpha:                                     container.attributeIfPresent(of: .alpha),
            clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
            constraints:                               constraintsContainer?.elementsIfPresent(of: .constraint),
            contentMode:                               container.attributeIfPresent(of: .contentMode),
            customClass:                               container.attributeIfPresent(of: .customClass),
            customModule:                              container.attributeIfPresent(of: .customModule),
            customModuleProvider:                      container.attributeIfPresent(of: .customModuleProvider),
            userLabel:                                 container.attributeIfPresent(of: .userLabel),
            colorLabel:                                container.attributeIfPresent(of: .colorLabel),
            fixedFrame:                                container.attributeIfPresent(of: .fixedFrame),
            image:                                     container.attributeIfPresent(of: .image),
            imageReference:                            container.elementIfPresent(of: .imageReference),
            preferredSymbolConfiguration:              container.elementIfPresent(of: .preferredSymbolConfiguration),
            highlightedImage:                          container.attributeIfPresent(of: .highlightedImage),
            catalog:                                   container.attributeIfPresent(of: .catalog),
            isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
            isAmbiguous:                               container.attributeIfPresent(of: .isAmbiguous),
            isHidden:                                  container.attributeIfPresent(of: .isHidden),
            verifyAmbiguity:                           container.attributeIfPresent(of: .verifyAmbiguity),
            multipleTouchEnabled:                      container.attributeIfPresent(of: .multipleTouchEnabled),
            opaque:                                    container.attributeIfPresent(of: .opaque),
            rect:                                      container.elementIfPresent(of: .rect),
            subviews:                                  container.childrenIfPresent(of: .subviews),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
            viewLayoutGuide:                           container.elementIfPresent(of: .viewLayoutGuide),
            userDefinedRuntimeAttributes:              container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                               container.childrenIfPresent(of: .connections),
            variations:                                variationContainer.elementsIfPresent(of: .variation),
            tag:                                       container.attributeIfPresent(of: .tag),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            semanticContentAttribute:                  container.attributeIfPresent(of: .semanticContentAttribute),
            insetsLayoutMarginsFromSafeArea:           container.attributeIfPresent(of: .insetsLayoutMarginsFromSafeArea),
            layoutMarginsFollowReadableWidth:          container.attributeIfPresent(of: .layoutMarginsFollowReadableWidth),
            preservesSuperviewLayoutMargins:           container.attributeIfPresent(of: .preservesSuperviewLayoutMargins),
            horizontalHuggingPriority:                 container.attributeIfPresent(of: .horizontalHuggingPriority),
            verticalHuggingPriority:                   container.attributeIfPresent(of: .verticalHuggingPriority),
            horizontalCompressionResistancePriority:   container.attributeIfPresent(of: .horizontalCompressionResistancePriority),
            verticalCompressionResistancePriority:     container.attributeIfPresent(of: .verticalCompressionResistancePriority)
        )
    }
}

public struct ImageReference: IBDecodable, IBKeyable {
    public let key: String?
    public let image: String?
    public let catalog: String?
    public let renderingMode: String?
    public let symbolScale: String?

    static func decode(_ xml: XMLIndexerType) throws -> ImageReference {
        let container = xml.container(keys: CodingKeys.self)
        return ImageReference(
            key: container.attributeIfPresent(of: .key),
            image: container.attributeIfPresent(of: .image),
            catalog: container.attributeIfPresent(of: .catalog),
            renderingMode: container.attributeIfPresent(of: .renderingMode),
            symbolScale: container.attributeIfPresent(of: .symbolScale)
        )
    }
}


public struct PreferredSymbolConfiguration: IBDecodable, IBKeyable {
    public enum Configuration: Encodable {
        public func encode(to encoder: Encoder) throws {}

        case pointSize(Int)
        case font(Font)
        case unknown(String)
    }
    public let key: String?
    public let configuration: Configuration?
    public let scale: String?
    public let weight: String?

    enum ExternalCodingKeys: CodingKey {
        case configurationType
        case pointSize
        case fontDescription
    }

    static func decode(_ xml: XMLIndexerType) throws -> PreferredSymbolConfiguration {
        let container = xml.container(keys: CodingKeys.self)
        let externalContainer = xml.container(keys: ExternalCodingKeys.self)
        let configurationType: String? = externalContainer.attributeIfPresent(of: .configurationType)
        let configuration: Configuration?
        switch configurationType {
        case "pointSize":
            configuration = try .pointSize(externalContainer.attribute(of: .pointSize))
        case "font":
            configuration = try .font(externalContainer.element(of: .fontDescription))
        case let configurationType?:
            configuration = .unknown(configurationType)
        case nil:
            configuration = nil
        }
        return PreferredSymbolConfiguration(
            key: container.attributeIfPresent(of: .key),
            configuration: configuration,
            scale: container.attributeIfPresent(of: .scale),
            weight: container.attributeIfPresent(of: .weight)
        )
    }
}
