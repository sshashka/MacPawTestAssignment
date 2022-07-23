import UIKit

final class MainScreen: UIViewController {
    
    private var collectionView: UICollectionView?
    var presenter: MainScreenPresenterProtocol!
    
    private let images = ["1", "2", "3", "4", "5", "6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose a day"
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getData()
    }
    
    override func didReceiveMemoryWarning() {
        print("\(type(of: self)), just received a memory warning")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.width/2) - 3, height: (view.frame.height/5) - 7)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: MainScreenCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        guard let collectionView = collectionView else {return}
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.identifier, for: indexPath) as? MainScreenCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell()}
        configureImageForCell(cell: cell)
        if let data = presenter.data {
            cell.dayLabel.text = "Day \(String(describing: data[indexPath.row].day))"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.tapOnDay(selectedDay: indexPath.row)
    }
    
    private func configureImageForCell (cell: MainScreenCollectionViewCell) {
        let randomNubmer = Int.random(in: 0..<6)
        cell.imageView.image = UIImage(named: images[randomNubmer])
    }
    
}

extension MainScreen: MainScreenViewPresenterProtocol {
    func show() {
        collectionView?.reloadData()
    }
}
