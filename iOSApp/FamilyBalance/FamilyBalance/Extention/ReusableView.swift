
import Foundation

protocol ReusableView: class {}

extension ReusableView {
    static var reuseIdD: String {
        return String(describing: self)
    }
}
