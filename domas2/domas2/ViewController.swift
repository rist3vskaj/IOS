import UIKit

final class WishMakerViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let addWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBrown
        configureUI()
        configureAddWishButton()
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
        titleLabel.textColor = UIColor.customColor
        
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
        descriptionLabel.textColor = .white
        
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle("Add Wish", for: .normal)
        addWishButton.backgroundColor = .systemBlue
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.layer.cornerRadius = 10
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(addWishButton)
        
        NSLayoutConstraint.activate([
            addWishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addWishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addWishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addWishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func addWishButtonPressed() {
        let wishStoringVC = WishStoringViewController()
        present(wishStoringVC, animated: true, completion: nil)
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true

        view.addSubview(stack)

        // Create sliders for Red, Green, and Blue
        let sliderRed = CustomSlider(title: "Red", min: 0, max: 1)
        let sliderGreen = CustomSlider(title: "Green", min: 0, max: 1)
        let sliderBlue = CustomSlider(title: "Blue", min: 0, max: 1)

        // Add sliders to the stack view
        stack.addArrangedSubview(sliderRed)
        stack.addArrangedSubview(sliderGreen)
        stack.addArrangedSubview(sliderBlue)

        // Set up constraints for the stack view
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: -20)
        ])

        // Update the background color with slider values
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
    
    // Make sure this method is included and accessible
    private func updateBackgroundColor(red: Float, green: Float, blue: Float) {
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}

