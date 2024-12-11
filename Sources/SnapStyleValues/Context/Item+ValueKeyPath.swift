//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.FontKey {
    
    public static func keyPath(for item: SnapStyle.Item.ItemType) -> ValueKeyPath {
        switch item {
            case .any: \.content // TODO: Is there a better default?
                
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
    
    public static func keyPath(for item: SnapStyle.Item.ItemType) -> ValueKeyPath {
        switch item {
            case .any: \.content // TODO: Is there a better default?

            case .title: \.title
            case .content: \.content
            case .label: \.label
            case .value: \.value
            case .cta: \.cta
            case .indicator: \.indicator
        }
    }
    
}
