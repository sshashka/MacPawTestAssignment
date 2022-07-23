import UIKit

final class DetailsView: UIViewController {
    var presenter: DetailsScreenPresenterProtocol!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let losses = ["Personnel", "Equipment"]
        let segmentedControl = UISegmentedControl(items: losses)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.titleView = segmentedControl
        segmentedControl.addTarget(self, action: #selector(didTapOnSegmentedControl), for: .valueChanged)
        setupConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getData(with: segmentedControl.selectedSegmentIndex)
    }
    
    override func didReceiveMemoryWarning() {
        print("\(type(of: self)), just received a memory warning")
    }
    
    deinit {
        print("view deinited")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didTapOnSegmentedControl(sender: UISegmentedControl) {
        presenter.getData(with: sender.selectedSegmentIndex)
    }
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configureCell(cell: cell)
        if let data = presenter.data {
            cell.textLabel?.text = data[indexPath.row]
        }
        else {
            cell.textLabel?.text = "No data"
        }
        
        return cell
    }
    
    private func configureCell(cell: UITableViewCell) {
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
    }
}

extension DetailsView: DetailsScreenViewProtocol {
    func show() {
        tableView.reloadData()
    }
}
