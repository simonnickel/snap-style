//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.Context: CustomStringConvertible {
    
    public var description: String {
        let entries = content.map { (key, value) in
            "\(key): \(value)"
        }
        
        return entries.sorted().joined(separator: ", ") + " (\(self.hashValue))"
    }
    
}
