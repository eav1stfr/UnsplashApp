//
//  ViewController.swift
//  UnsplashApp
//
//  Created by Александр Эм on 13.11.2024.
//

import UIKit

class ViewController: UIViewController {
    private var mainView = MainView()
    
    private var imageManager = ImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ViewController: MainViewDelegate {
    func changeImageButtonPressed() {
        print("button pressed")
        imageManager.performRequest()
    }
}

extension ViewController: ImageManagerDelegate {
    func updateImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.mainView.image.image = image
            }
        }
        task.resume()
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController {
    private func setupView() {
        mainView.delegate = self
        imageManager.delegate = self
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(mainView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
