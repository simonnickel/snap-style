//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct DebugKeyScreen: View {
    
    @State private var elementType: SnapStyle.Element.ElementType = .any
    @State private var elementHierarchy: SnapStyle.Element.Hierarchy = .primary
    
    public init() {}
        
    public var body: some View {
        VStack {
            config
            element
        }
    }
    
    private var config: some View {
        VStack {
            HStack {
                Picker("Element", selection: $elementType) {
                    ForEach(SnapStyle.Element.ElementType.allCases, id: \.self) { element in
                        Text("\(element)")
                    }
                }
                Picker("Hierarchy", selection: $elementHierarchy) {
                    ForEach(SnapStyle.Element.Hierarchy.allCases, id: \.self) { hierarchy in
                        Text("\(hierarchy)")
                    }
                }
            }
        }
    }
    
    private var element: some View {
        Text("Element")
            .style(element: elementType, hierarchy: elementHierarchy)
    }
    
}

#Preview {
    DebugKeyScreen()
}
