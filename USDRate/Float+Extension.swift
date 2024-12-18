import Foundation

extension Float {
    func decimals(_ nbr: Int) -> String {
        String(self.formatted(.number.precision(.fractionLength(nbr))))
    }
}

