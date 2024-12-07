//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyle

public struct DebugValueScreen: View {
    @Environment(\.style) private var style

    public init() {}
    
    public var body: some View {
        List {
            ForEach(Array(style.fonts.keys), id: \.self) { key in

                section(key: key)

            }
        }
    }

    private func section(key: SnapStyle.FontKey) -> some View {

        Group {
            if let values = style.fonts[key] {
                let contexts: [SnapStyle.Context] = Array(values.valuesForContext.keys)

                Section {
                    ForEach(contexts, id: \.self) { context in
                        item(context: context, values: values)
                    }
                } header: {
                    Text("\(key) - \(contexts.count)")
                }
            } else {
                EmptyView()
            }
        }
    }

    private func item(context: SnapStyle.Context, values:  SnapStyle.Values<SnapStyle.FontKey.Value>) -> some View {
        VStack(alignment: .leading) {
            Text(context.description)
            Text(values.valuesForContext[context].debugDescription)
        }
    }
}

#Preview {
    DebugValueScreen()
        .styleOverride(
            fonts: [
                .title : { context in
                    switch context.item.hierarchy {
                        case.primary: .definition(.init(size: 12))
                        default: nil
                    }

                }
            ],
            surfaces: [
                .title : { context in
                    switch context.item.hierarchy {
                        case .primary: .surface(.init(foreground: Color.primary))
                        default: nil
                    }
                }
            ]
        )
}
