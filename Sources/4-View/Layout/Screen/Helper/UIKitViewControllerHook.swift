//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
#if canImport(UIKit)
import UIKit

package extension View {
    
    /// A Modifier to hook into UIKit to access the ViewControllers `viewWillAppear()` call.
    /// It places a UIViewController in the background to trigger the lifecycle callbacks.
    func onViewWillAppear(perform onViewWillAppear: @escaping ((UIViewController) -> Void)) -> some View {
        modifier(UIKitViewControllerHookModifier(onViewWillAppear: onViewWillAppear))
    }
    
}

private struct UIKitViewControllerHookModifier: ViewModifier {
    
    let onViewWillAppear: ((UIViewController) -> Void)
    
    func body(content: Content) -> some View {
        content
            .background {
                UIKitHookViewControllerRepresentable(onViewWillAppear: onViewWillAppear)
            }
    }
    
}

private struct UIKitHookViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIKitHookViewController
    
    let onViewWillAppear: ((UIViewController) -> Void)
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = UIViewControllerType()
        vc.onViewWillAppear = onViewWillAppear
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}

private class UIKitHookViewController: UIViewController {
    
    var onViewWillAppear: ((UIViewController) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear?(self)
    }
    
}

#endif
