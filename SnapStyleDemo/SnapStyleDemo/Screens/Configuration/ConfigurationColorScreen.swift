//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyle
import SwiftUI

struct ConfigurationColorScreen: View {

    @Environment(\.self) private var environment
    @Environment(\.demoConfiguration) private var demoConfiguration

    @State private var mode: Mode = .primary

    private enum Mode {
        case primary, secondary
    }

    let accentPairs: [SnapStyle.Accent.Pair] = [
        .init(.blue, .fallbackAlternative),
        .init(.blue, .yellow),
        .init(.green, .fallbackAlternative),
        .init(.green, .cyan),
        .init(.teal, .fallbackAlternative),
        .init(.teal, .yellow),
        .init(.red, .fallbackAlternative),
        .init(.red, .yellow),
        .init(.orange, .fallbackAlternative),
        .init(.yellow, .fallbackAlternative),
        .init(.mint, .fallbackAlternative),
        .init(.cyan, .fallbackAlternative),
        .init(.purple, .fallbackAlternative),
        .init(.indigo, .fallbackAlternative),
        .init(.fallback, .fallbackAlternative),
    ]

    let accentsSecondary: [SnapStyle.Accent] = [
       .fallbackAlternative,
       .blue,
       .green,
       .teal,
       .red,
       .orange,
       .yellow,
       .mint,
       .cyan,
       .purple,
       .indigo,
       .fallback,
    ]

    var body: some View {


        StyleScreen {

            viewPicker

            if mode == .primary {
                contentPrimary
            } else {
                contentSecondary
            }
        }

    }

    private var viewPicker: some View {
        Picker(selection: $mode) {
            Text("Primary")
                .tag(Mode.primary)
            Text("Secondary")
                .tag(Mode.secondary)
        } label: {
            Text("Select")
        }
        .pickerStyle(.segmented)
    }

    private let gridItem: GridItem = GridItem(.flexible(minimum: 20, maximum: .infinity))

    private var contentPrimary: some View {
        LazyVGrid(columns: [gridItem, gridItem]) {
            ForEach(accentPairs, id: \.self) { accents in
                Button {
                    demoConfiguration.accents = accents
                } label: {
                    ColorItemView(selected: accents == demoConfiguration.accents)
                        .style(accents: accents)
                }
            }
        }
        .padding()
    }

    private var contentSecondary: some View {
        LazyVGrid(columns: [gridItem, gridItem]) {
            ForEach(accentsSecondary, id: \.self) { accent in
                let accents = SnapStyle.Accent.Pair(demoConfiguration.accents.primary, accent)
                Button {
                    demoConfiguration.accents = accents
                } label: {
                    ColorItemView(selected: demoConfiguration.accents.secondary == demoConfiguration.accents.secondary)
                        .style(accents: accents)
                }
            }
        }
        .padding()
    }
}


// MARK: - Preview

#Preview {
    ConfigurationColorScreen()
}
