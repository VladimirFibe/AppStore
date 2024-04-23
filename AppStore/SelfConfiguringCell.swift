import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: App)
}

protocol SelfConfiguringMessage {
    static var reuseIdentifier: String { get }
    func configure(with reaction: Reaction)
}
