//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct StyleList<SelectionValue: Hashable, Content: View>: View {
    
    private let selection: Binding<SelectionValue?>?
    private let insetTop: Bool
    private let content: () -> Content
    
    public init(selection: Binding<SelectionValue?>?, insetTop: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.selection = selection
        self.insetTop = insetTop
        self.content = content
    }
    
    public init(insetTop: Bool = true, @ViewBuilder content: @escaping () -> Content) where SelectionValue == Never {
        self.selection = nil
        self.insetTop = insetTop
        self.content = content
    }
    
    public var body: some View {
        StyleScreen(component: .list, configuration: .list) {
            List {
                content()
                    .styleListRowInsets(\.zero)
            }
            .styleListSectionSpacing(\.paddingListSection)
            // TODO FB: Custom Section Spacing does not apply to top of first section. Needs to be smaller than actual section spacing. Would prefer to use `.contentMargins(.top, value, for: .scrollContent)`, but for some weird reason this is applied between first section header and content.
            .style(safeAreaPadding: insetTop ? \.paddingListSectionFirst : \.zero, .top)
            .style(safeAreaPadding: \.paddingListBottom, .bottom)
            .listIconWidthScope()
            // Need to disable to use custom background.
            .scrollContentBackground(.hidden)
            // SwiftUI prevents too small list rows, this messes with .listRowInsets though.
            .environment(\.defaultMinListRowHeight, 0)
        }
    }
}


// MARK: - Preview

#Preview {
    @Previewable @State var selection: String? = "Circle"
    
    NavigationStack {
        StyleList(selection: $selection) {
            Section {
                StyleListRow(.navigate("Star")) {
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.navigation(isPresented: false)) {
                    StyleLabel("Staroflife", systemImage: "staroflife")
                }
                StyleListRow(.navigate("Circle")) {
                    StyleLabel("Circle", systemImage: "circle")
                }
                StyleLabel("Triangle", systemImage: "triangle")
                StyleLabel("Rectangle", systemImage: "rectangle")
            } header: {
                Text("Section")
                    .styleListSectionHeaderLabel()
            }
            Section {
                StyleListRow(.navigate("Star")) {
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.navigate("Circle", isPresented: true)) {
                    StyleLabel("Circle", systemImage: "circle")
                }
                StyleLabel("Triangle", systemImage: "triangle")
                StyleLabel("Rectangle", systemImage: "rectangle")
            } header: {
                Text("Section with selected row")
                    .styleListSectionHeaderLabel()
            }
        }
    }
}
