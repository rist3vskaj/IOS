import UIKit

extension UIView {
    
    // Pin the view to another view's edges (top, left, bottom, right)
    func pin(to view: UIView, _ offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: offset),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: offset),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -offset),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
        ])
    }
    
   
    func pinTop(to view: UIView, _ offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: offset)
        ])
    }
    
    
    func pinLeft(to view: UIView, _ offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: offset)
        ])
    }
    
   
    func pinBottom(to view: UIView, _ offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
        ])
    }
    
   
    func pinRight(to view: UIView, _ offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -offset)
        ])
    }
}

enum Constants {
    static var offset = 10.0
    static var cornerRadius = 20.0
    static var titleFont = UIFont.italicSystemFont(ofSize: 18)
    static var titleTop = 10.0
    static var titleLeading = 10.0
    static var labelFont = UIFont.systemFont(ofSize: 14)
    static var labelSpacing = 25.0
    static var labelPadding = 10.0
    static var smallHeightFraction: CGFloat = 0.32
    static var verticalSpacing: CGFloat = 25.0
    static var labelMaxWidth: CGFloat = 250.0 // Max width to prevent labels from overflowing
}

// MARK: - WishEventModel Definition
struct WishEventModel {
    var title: String
    var description: String
    var startDate: String
    var endDate: String
}

class WishEventCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = .systemPink
     
        self.frame.size.height *= Constants.smallHeightFraction
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = Constants.titleFont
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = Constants.labelMaxWidth
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.textColor = .black
        descriptionLabel.font = Constants.labelFont
        descriptionLabel.pinTop(to: titleLabel, Constants.labelSpacing)
        descriptionLabel.pinLeft(to: wrapView, Constants.titleLeading)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.preferredMaxLayoutWidth = Constants.labelMaxWidth // Prevent description from overflowing
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = .black
        startDateLabel.font = Constants.labelFont
        startDateLabel.numberOfLines = 0
        startDateLabel.preferredMaxLayoutWidth = Constants.labelMaxWidth
        
        
        startDateLabel.pinTop(to: descriptionLabel, 0)
        startDateLabel.pinRight(to: wrapView, Constants.titleLeading)
    }

    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = .black
        endDateLabel.font = Constants.labelFont
        endDateLabel.pinTop(to: startDateLabel, Constants.verticalSpacing)
        endDateLabel.pinRight(to: wrapView, Constants.titleLeading)
        endDateLabel.numberOfLines = 0
        endDateLabel.preferredMaxLayoutWidth = Constants.labelMaxWidth
    }
}
