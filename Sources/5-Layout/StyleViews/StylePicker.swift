//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapCore
import SwiftUI

public typealias StylePicker = Style.Views.Picker.PickerView
extension Style.Views {
    public enum Picker {}
}

extension Style.Views.Picker {
    
     // TODO: Currently it just wraps PickerTapable from SnapCore. Should it do highlighting on tap?
    
    public struct PickerView<Style: PickerStyle, Label: View, SelectionValue: Hashable, Content: View> : View {
        
        let style: Style
        let selection: Binding<SelectionValue>
        let content: () -> Content
        let label: () -> Label
        
        public init(style: Style = .automatic, selection: Binding<SelectionValue>, @ViewBuilder content: @escaping () -> Content, label: @escaping () -> Label) {
            self.style = style
            self.selection = selection
            self.content = content
            self.label = label
        }
        
        public var body: some View {
            PickerTapable(style: style, selection: selection, content: content, label: label)
        }
    }
    
}


// MARK: - Preview

#Preview {
    StylePickerExample()
}

package struct StylePickerExample: View {

    enum PickerValue: String, CaseIterable, Identifiable {
        case a
        case b
        case c
        
        var id: String { self.rawValue }
    }

    @State private var selection: PickerValue = .b

    package init() {}

    package var body: some View {
        StyleScreen {
            StyleStack(spacing: \.spacingGroups) {
                contentPicker(style: .segmented)
                    .style(component: .contentCard)
                contentPicker(style: .menu)
                    .style(component: .contentCard)
                #if !os(macOS)
                contentPicker(style: .wheel)
                    .style(component: .contentCard)
                #endif
                    
                
//                Picker(selection: $selection) {
//                    ForEach(PickerValue.allCases) { value in
//                        Text(value.rawValue)
//                            .tag(value)
//                    }
//                } label: {
//                    Text("Select Value")
//                }
//                .pickerStyle(.menu)

            }
        }
    }
    
    private func contentPicker<Style: PickerStyle>(style: Style) -> some View {
        StylePicker(style: style, selection: $selection, content: {
            ForEach(PickerValue.allCases) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }, label: {
            Text("Select Value")
        })
    }

}
