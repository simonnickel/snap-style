//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyle
import SwiftUI

struct ConfigurationColorScreen: View {
    
    typealias Accent = Style.AccentKey.Value.WrappedValue

    @Environment(\.self) private var environment
    @Environment(\.demoConfiguration) private var demoConfiguration

    @State private var mode: Mode = .pair

    private enum Mode {
        case pair, primary, secondary
    }

    let accentPairs: [(Accent, Accent)] = [
        (.blue, .fallbackSecondary),
        (.blue, .yellow),
        (.green, .fallbackSecondary),
        (.green, .cyan),
        (.teal, .fallbackSecondary),
        (.teal, .yellow),
        (.red, .fallbackSecondary),
        (.red, .yellow),
        (.orange, .fallbackSecondary),
        (.yellow, .fallbackSecondary),
        (.mint, .fallbackSecondary),
        (.cyan, .fallbackSecondary),
        (.purple, .fallbackSecondary),
        (.indigo, .fallbackSecondary),
        (.fallbackPrimary, .fallbackSecondary),
    ]

    let accents: [Accent] = [
        .fallbackPrimary,
        .fallbackSecondary,
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
    ]

    var body: some View {


        StyleScreen {

            viewPicker

            switch mode {
                case .pair:
                    contentPair
                case .primary:
                    contentPrimary
                case .secondary:
                    contentSecondary
            }
        }

    }

    private var viewPicker: some View {
        Picker(selection: $mode) {
            Text("Pair")
                .tag(Mode.pair)
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

    private var contentPair: some View {
        LazyVGrid(columns: [gridItem, gridItem]) {
            ForEach(accentPairs.indices, id: \.self) { index in
                let (primary, secondary) = accentPairs[index]
                Button {
                    demoConfiguration.accentPrimary = primary
                    demoConfiguration.accentSecondary = secondary
                } label: {
                    ColorItemView(selected: primary == demoConfiguration.accentPrimary && secondary == demoConfiguration.accentSecondary)
                        .styleOverride(accents: [
                            \.primary: .base(.definition(.value(primary)))
                        ])
                        .styleOverride(accents: [
                            \.secondary: .base(.definition(.value(secondary)))
                        ])
                }
            }
        }
        .padding()
    }

    private var contentPrimary: some View {
        LazyVGrid(columns: [gridItem, gridItem]) {
            ForEach(accents, id: \.self) { accent in
                Button {
                    demoConfiguration.accentPrimary = accent
                } label: {
                    ColorItemView(selected: accent == demoConfiguration.accentPrimary)
                        .styleOverride(accents: [
                            \.primary: .base(.definition(.value(accent)))
                        ])
                }
            }
        }
        .padding()
    }

    private var contentSecondary: some View {
        LazyVGrid(columns: [gridItem, gridItem]) {
            ForEach(accents, id: \.self) { accent in
                Button {
                    demoConfiguration.accentSecondary = accent
                } label: {
                    ColorItemView(selected: accent == demoConfiguration.accentSecondary)
                        .styleOverride(accents: [
                            \.secondary: .base(.definition(.value(accent)))
                        ])
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
