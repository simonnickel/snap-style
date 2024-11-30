//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ContentView: View {
    
    @Environment(\.style) private var style
    
    var body: some View {
        ExampleScreenFont()
    }
    
}

#Preview {
    ContentView()
}
