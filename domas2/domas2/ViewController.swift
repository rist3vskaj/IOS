import UIKit
extension UIView {
    func pinHorizontal(to view: UIView) {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func pinTop(to anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: anchor, constant: constant)
        ])
    }
    
    func pinBottom(to anchor: NSLayoutYAxisAnchor) {
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: anchor)
        ])
    }
}



final class WishMakerViewController: UIViewController {
    enum Constants {
        static let spacing: CGFloat = 20.0
        static let stackBottom: CGFloat = 20  // Adjust this value as needed
        static let stackLeading: CGFloat = 16
        static let HeightAnchor: CGFloat = 50
        static let LeadingAnchorSchedule: CGFloat = 20
        static let BottomAnchorSchedule: CGFloat = -35
        static let HeightAnchorSchedule: CGFloat = 50
        
    }
    
    private let scheduleWishesButton = UIButton()
    private let addWishButton = UIButton(type: .system)
    private let actionStack = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private var currentColor: UIColor = .systemYellow {
        didSet {
            view.backgroundColor = currentColor
            addWishButton.setTitleColor(currentColor, for: .normal)
            scheduleWishesButton.setTitleColor(currentColor, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = currentColor
        configureUI()
        configureAddWishButton()
        configureScheduleMissions()
        configureActionStack()
        configureSliders()
        
    }
    
    private func configureUI() {
        configureTitle()
        configureDescription()
    }
    
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "WishMaker"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = currentColor
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "This app helps you make and track your wishes."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackLeading),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle("Add Wish", for: .normal)
        addWishButton.backgroundColor = .systemPink
        addWishButton.setTitleColor(currentColor, for: .normal)
        addWishButton.layer.cornerRadius = 10
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        view.addSubview(addWishButton)
    }
    
    private func configureScheduleMissions() {
        scheduleWishesButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleWishesButton.setTitle("Schedule wish granting", for: .normal)
        scheduleWishesButton.backgroundColor = .green
        scheduleWishesButton.setTitleColor(currentColor, for: .normal)
        scheduleWishesButton.layer.cornerRadius = 10
        scheduleWishesButton.addTarget(self, action: #selector(scheduleWishesButtonPressed), for: .touchUpInside)
        view.addSubview(scheduleWishesButton)
    }
    
    private func configureActionStack() {
        actionStack.axis = .vertical
        actionStack.spacing = Constants.spacing
        actionStack.alignment = .fill
        actionStack.addArrangedSubview(addWishButton)
        actionStack.addArrangedSubview(scheduleWishesButton)
        view.addSubview(actionStack)
        
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            actionStack.heightAnchor.constraint(equalToConstant: Constants.HeightAnchor * 2 + Constants.spacing),
            actionStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.stackBottom)
        ])
    }
    
    
    
    @objc private func addWishButtonPressed() {
        let wishStoringVC = WishStoringViewController()
        present(wishStoringVC, animated: true, completion: nil)
    }
    
    @objc private func scheduleWishesButtonPressed() {
        //print("Schedule Wishes button pressed!")
        guard let navController = navigationController else {
            print("Navigation controller is nil")
            return
        }
        let wishCalendarVC = WishCalendarViewController()
        navController.pushViewController(wishCalendarVC, animated: true)
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true
        view.addSubview(stack)
        
        let sliderRed = CustomSlider(title: "Red", min: 0, max: 1)
        let sliderGreen = CustomSlider(title: "Green", min: 0, max: 1)
        let sliderBlue = CustomSlider(title: "Blue", min: 0, max: 1)
        
        stack.addArrangedSubview(sliderRed)
        stack.addArrangedSubview(sliderGreen)
        stack.addArrangedSubview(sliderBlue)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: actionStack.topAnchor, constant: -20)
        ])
        
        sliderRed.valueChanged = { [weak self] redValue in
            self?.updateBackgroundColor(red: redValue, green: sliderGreen.slider.value, blue: sliderBlue.slider.value)
        }
        sliderGreen.valueChanged = { [weak self] greenValue in
            self?.updateBackgroundColor(red: sliderRed.slider.value, green: greenValue, blue: sliderBlue.slider.value)
        }
        sliderBlue.valueChanged = { [weak self] blueValue in
            self?.updateBackgroundColor(red: sliderRed.slider.value, green: sliderGreen.slider.value, blue: blueValue)
        }
    }
    
    private func updateBackgroundColor(red: Float, green: Float, blue: Float) {
        let newColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        currentColor = newColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

