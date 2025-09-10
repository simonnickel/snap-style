//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style.Views.List.Row {
    
    public enum Variant<SelectionValue: Hashable> {
        
        // TODO: Add Segmented Control
        
        case plain
        
        /// Navigation style that pushes a value.
        case navigate(_ value: SelectionValue, isPresented: Bool = false)
        
        /// Navigation style that executes an action.
        case navigation(isPresented: Bool)
        
        /// Selection style to choose a single value.
        case selectValue(_ value: SelectionValue, selection: Binding<SelectionValue>)
        
        /// Select style to choose multiple values.
        case selectValues(_ value: SelectionValue, selection: Binding<[SelectionValue]>)
        
        /// Selection style, controlled via binding.
        case selected(Binding<Bool>)
        
        /// Switch style, controlled via binding.
        case enabled(Binding<Bool>)
        
        case pick(_ values: [SelectionValue], titleKeyPath: KeyPath<SelectionValue, String>, selection: Binding<SelectionValue>)
        
    }
    
}
