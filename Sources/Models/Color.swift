//
//  Color.swift
//  IBDecodable
//
//  Created by phimage on 10/05/2018.
//



public enum Color: IBDecodable {

    public typealias CalibratedWhite = (key: String?, white: Float, alpha: Float)
    public typealias CalibratedRGB = SRGB
    public typealias SRGB = (key: String?, red: Float, blue: Float, green: Float, alpha: Float)
    public typealias GenericGamma22Gray = CalibratedWhite
    public typealias Named = (key: String?, name: String)
    public typealias Catalog = (key: String?, name: String, catalog: String)
    case calibratedWhite(CalibratedWhite)
    case calibratedRGB(CalibratedRGB)
    case genericGamma22Gray(GenericGamma22Gray)
    case sRGB(SRGB)
    case name(Named)
    case systemColor(Named)
    case catalog(Catalog)

    public var calibratedRGB: CalibratedRGB? {
        switch self {
        case .calibratedRGB(let calibratedRGB):
            return calibratedRGB
        default: return nil
        }
    }

    public var sRGB: SRGB? {
        switch self {
        case .sRGB(let sRGB):
            return sRGB
        default: return nil
        }
    }

    public var calibratedWhite: CalibratedWhite? {
        switch self {
        case .calibratedWhite(let calibratedWhite):
            return calibratedWhite
        default: return nil
        }
    }

    public func encode(to encoder: Encoder) throws { fatalError() }

    enum CodingKeys: CodingKey {
        case key
        case colorSpace
        case systemColor
        case cocoaTouchSystemColor
    }

    enum CalibratedWhiteCodingKeys: CodingKey {
        case white, alpha
    }

    enum CalibratedRGBCodingKeys: CodingKey {
        case red, blue, green, alpha
    }

    enum sRGBCodingKeys: CodingKey {
        case red, blue, green, alpha
    }

    enum CustomCodingKeys: CodingKey {
        case customColorSpace
    }

    enum NamedCodingKeys: CodingKey {
        case name
    }

    enum CatalogCodingKeys: CodingKey {
        case name, catalog
    }

    static func decode(_ xml: XMLIndexerType) throws -> Color {
        let container = xml.container(keys: CodingKeys.self)
        let key: String? = container.attributeIfPresent(of: .key)

        if let systemColor: String = container.attributeIfPresent(of: .systemColor) {
            return .systemColor((key, systemColor))
        }

        if let colorSpace: String = container.attributeIfPresent(of: .colorSpace) {
            switch colorSpace {
            case "calibratedWhite":
                let calibratedWhiteContainer = xml.container(keys: CalibratedWhiteCodingKeys.self)
                return try .calibratedWhite((key:   key,
                                             white: calibratedWhiteContainer.attribute(of: .white),
                                             alpha: calibratedWhiteContainer.attribute(of: .alpha)))
            case "calibratedRGB":
                let calibratedRGBContainer = xml.container(keys: CalibratedRGBCodingKeys.self)
                return try .calibratedRGB((key:   key,
                                           red:   calibratedRGBContainer.attribute(of: .red),
                                           blue:  calibratedRGBContainer.attribute(of: .blue),
                                           green: calibratedRGBContainer.attribute(of: .green),
                                           alpha: calibratedRGBContainer.attribute(of: .alpha)
                ))
            case "custom":
                let container = xml.container(keys: CustomCodingKeys.self)
                let customColorSpace: String = try container.attribute(of: .customColorSpace)
                switch customColorSpace {
                case "sRGB":
                    let sRGBContainer = xml.container(keys: sRGBCodingKeys.self)
                    return try .sRGB((key:   key,
                                      red:   sRGBContainer.attribute(of: .red),
                                      blue:  sRGBContainer.attribute(of: .blue),
                                      green: sRGBContainer.attribute(of: .green),
                                      alpha: sRGBContainer.attribute(of: .alpha)
                    ))
                case "genericGamma22GrayColorSpace":
                    let calibratedWhiteContainer = xml.container(keys: CalibratedWhiteCodingKeys.self)
                    return try .genericGamma22Gray((key:   key,
                                                    white: calibratedWhiteContainer.attribute(of: .white),
                                                    alpha: calibratedWhiteContainer.attribute(of: .alpha)))
                default:
                    throw IBError.unsupportedColorSpace(customColorSpace)
                }
            case "catalog":
                let container = xml.container(keys: CatalogCodingKeys.self)
                return try .catalog((key:     key,
                                     name:    container.attribute(of: .name),
                                     catalog: container.attribute(of: .catalog)))
            default:
                throw IBError.unsupportedColorSpace(colorSpace)
            }
        } else {
            if let systemColor: String = container.attributeIfPresent(of: .cocoaTouchSystemColor) {
                return .systemColor((key, systemColor))
            }
            let container = xml.container(keys: NamedCodingKeys.self)
            return .name((key, try container.attribute(of: .name)))
        }
    }
}

// MARK: AttributeProtocol

extension Color: AttributeProtocol {

    public var key: String? {
        switch self {
        case .calibratedWhite(let calibratedWhite):
            return calibratedWhite.key
        case .calibratedRGB(let calibratedRgb):
            return calibratedRgb.key
        case .sRGB(let srgb):
            return srgb.key
        case .genericGamma22Gray(let genericGamma22Gray):
            return genericGamma22Gray.key
        case .name(let named):
            return named.key
        case .systemColor(let named):
            return named.key
        case .catalog(let catalog):
            return catalog.key
        }
    }

}
