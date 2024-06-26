import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "FeaturedCell"
    private let tagline = UILabel()
    private let name = UILabel()
    private let subtitle = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [separator, tagline, name, subtitle, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: subtitle)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
        
    func configure(with app: App) {
        tagline.text = app.tagline.uppercased()
        name.text = app.name
        subtitle.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
