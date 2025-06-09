//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct DemoValueCard: View {
    
    static var exampleRectangle: Self { DemoValueCard(icon: "rectangle", value: "\(Int.random(in: 1..<999))", title: "Rectangle") }
    static var exampleTriangle: Self { DemoValueCard(icon: "triangle", value: "\(Int.random(in: 1..<999))", title: "Triangle") }
    static var exampleCircle: Self { DemoValueCard(icon: "circle", value: "\(Int.random(in: 1..<999))", title: "Circle") }
    
    let icon: String
    let value: String
    let title: String
    
    var body: some View {
            CornerContainer {
                Image(systemName: icon)
                    .style(element: .icon)
            } topTrailing: {
                Text(value)
                    .style(element: .value)
            } bottomLeading: {
                Text(title)
                    .style(element: .title, hierarchy: .primary)
            } bottomTrailing: {
                
            }
            .style(component: .valueCard)
    }
}


// MARK: - Preview

#Preview {
    StyleScreen {
        DemoValueCard.exampleRectangle
        DemoValueCard.exampleTriangle
        DemoValueCard.exampleCircle
    }
}
