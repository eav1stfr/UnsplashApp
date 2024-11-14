import UIKit

protocol MainViewDelegate: AnyObject {
    func changeImageButtonPressed()
}

final class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    
    private lazy var changeImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(changeButtonPressed), for: .touchUpInside)
        button.backgroundColor = .blue
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        button.layer.cornerRadius = 50
        return button
    }()
    
    var image: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFit
        imageV.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageV.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainView {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(changeImageButton)
        addSubview(image)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            changeImageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            changeImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70)
        ])
    }
    
    @objc private func changeButtonPressed() {
        delegate?.changeImageButtonPressed()
    }
}
