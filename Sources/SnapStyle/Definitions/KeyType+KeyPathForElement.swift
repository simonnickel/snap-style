//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {
    
    public static func keyPath(for element: SnapStyle.Element.ElementType) -> ValueKeyPath {
        switch element {
            case .any: \.content
                
            case .title: \.title
            case .content: \.content
            case .label: \.label
            case .value: \.value
            case .cta: \.cta
            case .indicator: \.indicator
        }
    }
    
}

extension SnapStyle.SurfaceKey {
    
    public static func keyPath(for element: SnapStyle.Element.ElementType) -> ValueKeyPath {
        switch element {
            case .any: \.content

            case .title: \.title
            case .content: \.content
            case .label: \.label
            case .value: \.value
            case .cta: \.cta
            case .indicator: \.indicator
        }
    }
    
}
