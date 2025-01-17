//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {
    
    public static func keyPath(for component: SnapStyle.Component.ComponentType) -> ValueBuilderKeyPath? {
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
            case .indicator: \.indicator
        }
    }
    
}

extension SnapStyle.SurfaceKey {
    
    public static func keyPath(for component: SnapStyle.Component.ComponentType) -> ValueBuilderKeyPath? {
        switch component {
            case .card: \.card

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
            case .indicator: \.indicator
        }
    }
    
}
