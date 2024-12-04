import UIKit

class WishCalendarViewController: UIViewController {
    
    enum Constants {
        static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let collectionTop: CGFloat = 20.0
    }
    
    private var tableView: UITableView!
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private var dataManger: CoreDataManager = CoreDataManager.shared
    
    // Example data for events
    var events: [WishEventModel] = CoreDataManager.shared.fetchEvents().map( {
        
        if let title = $0.title, let descr =  $0.descr, let startDate = $0.startDate, let endDate = $0.endDate {
            WishEventModel(title:  title, description: descr, startDate: startDate, endDate: endDate)
        }
        
        return WishEventModel(title:  "title", description: "description", startDate: "startDate", endDate: "endDate")
       
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        setupNavigationBar()
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .green
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        // Register the custom cell after modifying layout
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout() // Forces the layout to refresh with the new spacings
        }

        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
    }
    
    private func setupNavigationBar() {
        // Create the "Add" button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        addButton.tintColor = .systemPink
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func didTapAddButton() {
        
        let eventCreationVC = WishEventCreationView()
        eventCreationVC.delegate = self  // Set the delegate to this view controller
        let navController = UINavigationController(rootViewController: eventCreationVC)
        present(navController, animated: true, completion: nil)
    }
}

extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return events.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        // Dequeue the custom cell
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WishEventCell.reuseIdentifier,
            for: indexPath
        )
        
        // Check if the dequeued cell is of the correct type
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        // Get the corresponding event from the data array
        let event = events[indexPath.item]
        
        // Configure the cell with the event data
        wishEventCell.configure(with: event)
        
        return wishEventCell
    }
}

extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - 20, height: 150)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}

// MARK: - WishEventCreationViewDelegate Implementation
extension WishCalendarViewController: WishEventCreationViewDelegate {
    func didSaveEvent(_ event: WishEventModel) {
        // Append the new event to the events array
        events.append(event)
        dataManger.saveEvent(title: event.title, description: event.description, startDate: event.startDate, endDate: event.endDate)
        
        // Reload the collection view to display the new event
        collectionView.reloadData()
    }
}
