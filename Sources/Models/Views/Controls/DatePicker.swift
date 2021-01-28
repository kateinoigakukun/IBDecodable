//
//  DatePicker.swift
//  IBDecodable
//
//  Created by phimage on 01/04/2018.
//



public struct DatePicker: IBDecodable, ControlProtocol, IBIdentifiable {
    public let id: String
    public let elementClass: String = "UIDatePicker"

    public let key: String?
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
    public let isMisplaced: Bool?
    public let isAmbiguous: Bool?
    public let isHidden: Bool?
    public let verifyAmbiguity: VerifyAmbiguity?
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

    public let isEnabled: Bool?
    public let isHighlighted: Bool?
    public let isSelected: Bool?
    public let contentHorizontalAlignment: String?
    public let contentVerticalAlignment: String?

    public let datePickerMode: String?
    public let minuteInterval: String? // Integer??
    public let date: IBDate?
    public let style: String?
    public let useCurrentDate: Bool?
    public let countDownDuration: Int?
    public let minimumDate: IBDate?
    public let maximumDate: IBDate?

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color, date }
    enum ColorsCodingKeys: CodingKey { case key }
    enum DateCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> DatePicker {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .isHidden: return "hidden"
                case .isEnabled: return "enabled"
                case .isHighlighted: return "highlighted"
                case .isSelected: return "selected"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)
        let dateContainer = xml.container(keys: ExternalCodingKeys.self)
                .nestedContainerIfPresent(of: .date, keys: DateCodingKeys.self)

        return DatePicker(
            id:                                        try container.attribute(of: .id),
            key:                                       container.attributeIfPresent(of: .key),
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
            isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
            isAmbiguous:                               container.attributeIfPresent(of: .isAmbiguous),
            isHidden:                                  container.attributeIfPresent(of: .isHidden),
            verifyAmbiguity:                           container.attributeIfPresent(of: .verifyAmbiguity),
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
            verticalCompressionResistancePriority:     container.attributeIfPresent(of: .verticalCompressionResistancePriority),
            isEnabled:                                 container.attributeIfPresent(of: .isEnabled),
            isHighlighted:                             container.attributeIfPresent(of: .isHighlighted),
            isSelected:                                container.attributeIfPresent(of: .isSelected),
            contentHorizontalAlignment:                container.attributeIfPresent(of: .contentHorizontalAlignment),
            contentVerticalAlignment:                  container.attributeIfPresent(of: .contentVerticalAlignment),
            datePickerMode:                            container.attributeIfPresent(of: .datePickerMode),
            minuteInterval:                            container.attributeIfPresent(of: .minuteInterval),
            date:                                      dateContainer?.withAttributeElement(.key, CodingKeys.date.stringValue),
            style:                                     container.attributeIfPresent(of: .style),
            useCurrentDate:                            container.attributeIfPresent(of: .useCurrentDate),
            countDownDuration:                         container.attributeIfPresent(of: .countDownDuration),
            minimumDate:                               dateContainer?.withAttributeElement(.key, CodingKeys.minimumDate.stringValue),
            maximumDate:                               dateContainer?.withAttributeElement(.key, CodingKeys.maximumDate.stringValue)
        )
    }
}
