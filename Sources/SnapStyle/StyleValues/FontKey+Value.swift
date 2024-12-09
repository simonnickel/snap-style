//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.FontKey {
    
    public enum Value {
        case definition(Definition)
        case font(Font)
        case reference(SnapStyle.FontKey)
        case erase

        var wrappedValue: Font {
            switch self {
                case .definition(let definition): Font.system(size: definition.size)
                case .font(let font): font
                case .reference, .erase:
                    fatalError("A `.reference` FontValue should never be used to generate a value.")
            }
        }
    }
    
    public struct Definition {
        
        let size: CGFloat

        public init(size: CGFloat) {
            self.size = size
        }
        
    }
    
}
