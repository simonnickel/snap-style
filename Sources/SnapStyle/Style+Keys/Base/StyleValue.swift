//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

public protocol StyleValue {
    
    associatedtype WrappedValue
    
    var wrappedValue: WrappedValue { get }
    
    var isErase: Bool { get }
    
}
