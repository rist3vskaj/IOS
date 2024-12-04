import UIKit

protocol WishEventCreationViewDelegate: AnyObject {
    func didSaveEvent(_ event: WishEventModel)
}

class WishEventCreationView: UIViewController {
    
    weak var delegate: WishEventCreationViewDelegate?
    
    private let titleField = UITextField()
    private let descriptionField = UITextField()
    private let startDateField = UITextField()
    private let endDateField = UITextField()
    
    private let saveButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .green
        title = "Create Event"
        
        
        // Configure TextFields
        titleField.placeholder = "Event Title"
        descriptionField.placeholder = "Event Description"
        startDateField.placeholder = "Start Date (YYYY-MM-DD)"
        endDateField.placeholder = "End Date (YYYY-MM-DD)"
        
        // Add TextFields to the view
        let stackView = UIStackView(arrangedSubviews: [titleField, descriptionField, startDateField, endDateField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // Configure Save Button
        saveButton.setTitle("Save Event", for: .normal)
        saveButton.setTitleColor(.systemPink, for: .normal)
        saveButton.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func saveEvent() {
        // Validate the fields
        guard let title = titleField.text, !title.isEmpty,
              let description = descriptionField.text, !description.isEmpty,
              let startDate = startDateField.text, !startDate.isEmpty,
              let endDate = endDateField.text, !endDate.isEmpty else {
            // Show an alert if any field is empty
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Create a new event model
        let newEvent = WishEventModel(title: title, description: description, startDate: startDate, endDate: endDate)
        
        // Notify the delegate (WishCalendarViewController) that an event was saved
        delegate?.didSaveEvent(newEvent)
        
        // Dismiss the view controller after saving
        dismiss(animated: true, completion: nil)
    }
}
