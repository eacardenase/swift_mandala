//
//  ViewController.swift
//  Mandala
//
//  Created by Edwin Cardenas on 6/12/25.
//

import UIKit

class MoodSelectionViewController: UIViewController {

    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)

        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false

        return visualEffect
    }()
    let emojiStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    // MARK: - View Lifecycle

    override func loadView() {
        view = UIView()

        view.backgroundColor = .systemBackground

        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Helpers

extension MoodSelectionViewController {
    func setupViews() {
        let testView = UIView()
        testView.backgroundColor = .systemGreen

        emojiStackView.addArrangedSubview(testView)
        visualEffectView.contentView.addSubview(emojiStackView)

        view.addSubview(visualEffectView)

        // visualEffectView
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            visualEffectView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            visualEffectView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])

        // emojiStackView
        NSLayoutConstraint.activate([
            emojiStackView.topAnchor.constraint(
                equalTo: visualEffectView.topAnchor,
                constant: 8
            ),
            emojiStackView.leadingAnchor.constraint(
                equalTo: visualEffectView.leadingAnchor
            ),
            emojiStackView.trailingAnchor.constraint(
                equalTo: visualEffectView.trailingAnchor
            ),
            emojiStackView.bottomAnchor.constraint(
                equalTo: visualEffectView.bottomAnchor
            ),
            emojiStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
