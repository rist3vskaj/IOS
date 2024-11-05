import UIKit

class WishStoringViewController: UIViewController {
    
    private let tableView = UITableView()
    private let textField = UITextField()
    private let addWishButton = UIButton(type: .system)
    
    // Array to hold the wishes
    private var wishes: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView()
        setupTextField()
        setupAddWishButton()
    }

    private func setupTableView() {
        view.addSubview(textField)
        view.addSubview(addWishButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self // Set data source
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WishCell") // Register cell

        // Constraints for UITableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10)
        ])
    }

    private func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your wish"

        // Constraints for UITextField
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle("Add Wish", for: .normal)
        addWishButton.backgroundColor = .systemBlue
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.layer.cornerRadius = 10
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)

        // Constraints for UIButton
        NSLayoutConstraint.activate([
            addWishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addWishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addWishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addWishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func addWishButtonPressed() {
        // Get the text from the text field
        guard let wishText = textField.text, !wishText.isEmpty else {
            // Show an alert if the text field is empty
            let alert = UIAlertController(title: "Error", message: "Please enter a wish.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Append the wish to the array
        wishes.append(wishText)
        
        // Clear the text field
        textField.text = ""

        // Reload the table view
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishCell", for: indexPath)
        cell.textLabel?.text = wishes[indexPath.row]
        return cell
    }
}

