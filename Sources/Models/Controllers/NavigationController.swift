//
//  NavigationController.swift
//  IBDecodable
//
//  Created by phimage on 02/04/2018.
//

import SWXMLHash

public struct NavigationController: IBDecodable, ViewControllerProtocol {

    public let elementClass: String = "UINavgigationController"
    public let id: String
    public let customClass: String?
    public let customModule: String?
    public let customModuleProvider: String?
    public var storyboardIdentifier: String?
    public let layoutGuides: [ViewControllerLayoutGuide]?
    public let userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public let connections: [AnyConnection]?
    public let tabBarItem: TabBar.TabBarItem?
    public let navigationBar: NavigationBar?
    public var rootView: ViewProtocol? { return navigationBar }

    enum LayoutGuidesCodingKeys: CodingKey { case viewControllerLayoutGuide }

    static func decode(_ xml: XMLIndexer) throws -> NavigationController {
        let container = xml.container(keys: CodingKeys.self)
        let layoutGuidesContainer = container.nestedContainerIfPresent(of: .layoutGuides, keys: LayoutGuidesCodingKeys.self)
        return NavigationController(
            id:                           try container.attribute(of: .id),
            customClass:                  container.attributeIfPresent(of: .customClass),
            customModule:                 container.attributeIfPresent(of: .customModule),
            customModuleProvider:         container.attributeIfPresent(of: .customModuleProvider),
            storyboardIdentifier:         container.attributeIfPresent(of: .storyboardIdentifier),
            layoutGuides:                 layoutGuidesContainer?.elementsIfPresent(of: .viewControllerLayoutGuide),
            userDefinedRuntimeAttributes: container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                  container.childrenIfPresent(of: .connections),
            tabBarItem:                   container.elementIfPresent(of: .tabBarItem),
            navigationBar:                container.elementIfPresent(of: .navigationBar)
        )
    }
}