//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension StyleListRow {
    
    public enum Variant {
        
        case plain

        /// Navigation style.
        case navigate(_ value: SelectionValue, isPresented: Bool = false)

        /// Selection style to choose a single value.
        case selectValue(_ value: SelectionValue, selection: Binding<SelectionValue>)

        /// Select style to choose multiple values.
        case selectValues(_ value: SelectionValue, selection: Binding<[SelectionValue]>)

        /// Selection style, controlled via binding.
        case selected(Binding<Bool>)

        /// Switch style, controlled via binding.
        case enabled(Binding<Bool>)
        
        case pick(_ values: [SelectionValue], selection: Binding<SelectionValue>)
        
    }
    
}
