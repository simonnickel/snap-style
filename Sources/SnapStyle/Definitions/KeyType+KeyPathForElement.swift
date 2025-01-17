//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {
    
    public static func keyPath(for component: SnapStyle.Component.ComponentType) -> ValueBuilderKeyPath? { // TODO: Should not be optional. Return reference in definition instead, to allow override.
        switch component {
            default: nil
        }
    }
    
    public static func keyPath(for element: SnapStyle.Element.ElementType) -> ValueBuilderKeyPath {
        switch element {
            case .any: \.content
                
            case .title: \.title
            case .content: \.content
            case .label: \.label
            case .icon: \.icon
            case .value: \.value
            case .cta: \.cta
        }
    }
    
}

extension SnapStyle.SurfaceKey {
    
    public static func keyPath(for component: SnapStyle.Component.ComponentType) -> ValueBuilderKeyPath {
        switch component {
            case .any: \.contentComponent
            case .screen: \.screen
            case .content: \.contentComponent
            case .list: \.list
            case .card: \.card
        }
    }
    
    public static func keyPath(for element: SnapStyle.Element.ElementType) -> ValueBuilderKeyPath {
        switch element {
            case .any: \.content

            case .title: \.title
            case .content: \.content
            case .label: \.label
            case .icon: \.icon
            case .value: \.value
            case .cta: \.cta
        }
    }
    
}
