//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapCore
import SwiftUI

public typealias StyleToggle = Style.Views.Toggle.ToggleView
extension Style.Views {
    public enum Toggle {}
}

extension Style.Views.Toggle {
    
     // TODO: Currently it just wraps ToggleTapable from SnapCore. Should it do highlighting on tap?
    
    public struct ToggleView<Label: View>: View {
        
        private let label: () -> Label
        
        private let isOn: Binding<Bool>
        
        public init(isOn: Binding<Bool>, label: @escaping () -> Label) {
            self.isOn = isOn
            self.label = label
        }
        
        public var body: some View {
            ToggleTapable(isOn: isOn, label: label)
        }
    }
    
}


// MARK: - Preview

#Preview {
    StyleToggleExample()
}

package struct StyleToggleExample: View {

    @State private var isEnabled: Bool = true

    package init() {}

    package var body: some View {
        StyleScreen {
            VStack {
                StyleToggle(isOn: $isEnabled) {
                    Text("enabled")
                }
            }
            .style(component: .contentCard)
        }
    }

}
