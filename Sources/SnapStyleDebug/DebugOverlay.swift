//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

#if DEBUG
extension View {
    func debugOverlay(info: String? = nil, color: Color? = .yellow) -> some View {
        self.modifier(DebugOverlayModifier(info: info, color: color))
    }
}

internal struct DebugOverlayModifier: ViewModifier {
    
    @Environment(\.geometrySizeScreen) private var geometrySizeScreen
    @Environment(\.geometrySizeContent) private var geometrySizeContent
    @Environment(\.geometrySafeAreaInsets) private var geometrySafeAreaInsets
    
    let info: String?
    let color: Color
    
    @State private var showPopover: Bool = false
    
    init(info: String? = nil, color: Color? = nil) {
        self.info = info
        self.color = color ?? Color(red: Double.random(in: 0...255) / 255, green: Double.random(in: 0...255) / 255, blue: Double.random(in: 0...255) / 255)
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    Rectangle()
                        .fill(color)
                        .opacity(0.2)
                        .border(color, width: 1)
                        .popover(isPresented: $showPopover) {
                            viewInfo
                                .presentationCompactAdaptation(.popover)
                        }
                        .onTapGesture {
                            showPopover.toggle()
                        }
                    ViewThatFits {
                        viewInfo
                        Image(systemName: "i.circle")
                            .foregroundStyle(color)
                    }
                }
            }
            .clipped()
    }
    
    var viewInfo: some View {
        StyleVStack(isStretching: false) {
            Text("Content: \(geometrySizeContent)")
            Text("Screen:   \(geometrySizeScreen)")
            Text("top: \(geometrySafeAreaInsets.top.formatted()), l: \(geometrySafeAreaInsets.leading.formatted()), b: \(geometrySafeAreaInsets.bottom.formatted()), t: \(geometrySafeAreaInsets.trailing.formatted())")
            if let info {
                Text("\(info)")
            }
        }
        .padding(10)
        .foregroundStyle(.black)
        .background(.white.opacity(0.8))
        .cornerRadius(10)
    }
}
#endif


// MARK: - Preview

#Preview {
    StyleScreen {
        StyleVStack(spacing: \.spacingSections) {
            Text("Some Content")
                .padding()
                .debugOverlay()
            Text("Some Other Content")
                .padding()
                .debugOverlay(color: .red)
            Text("Some Other Content")
                .padding(100)
                .debugOverlay()
        }
    }
}
