//
//  ViewController.swift
//  Mandala
//
//  Created by Edwin Cardenas on 6/12/25.
//

import UIKit

class MoodSelectionViewController: UIViewController {

    var moods = [Mood]() {
        didSet {
            moodButtons = moods.map { mood in
                let moodButton = UIButton()

                moodButton.setImage(mood.image, for: .normal)
                moodButton.imageView?.contentMode = .scaleAspectFit
                moodButton.adjustsImageWhenHighlighted = false

                return moodButton
            }
        }
    }
    var moodButtons = [UIButton]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            moodButtons.forEach { emojiStackView.addArrangedSubview($0) }
        }
    }

    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)

        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false

        return visualEffect
    }()
    let emojiStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12

        return stackView
    }()
    let addMoodButton: UIButton = {
        let buttton = UIButton(type: .system)

        buttton.translatesAutoresizingMaskIntoConstraints = false
        buttton.setTitle("Add Mood", for: .normal)
        buttton.tintColor = .white
        buttton.backgroundColor = .systemBlue
        buttton.layer.cornerRadius = buttton.bounds.height / 2

        return buttton
    }()

    // MARK: - View Lifecycle

    override func loadView() {
        view = UIView()

        view.backgroundColor = .systemBackground

        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        moods = [
            .happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh,
        ]
    }
}

// MARK: - Helpers

extension MoodSelectionViewController {
    func setupViews() {
        //        emojiStackView.addArrangedSubview(testView)
        visualEffectView.contentView.addSubview(emojiStackView)

        view.addSubview(visualEffectView)
        view.addSubview(addMoodButton)

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

        // addMoodButton
        NSLayoutConstraint.activate([
            addMoodButton.bottomAnchor.constraint(
                equalTo: visualEffectView.topAnchor,
                constant: -20
            ),
            addMoodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addMoodButton.heightAnchor.constraint(equalToConstant: 48),
            addMoodButton.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor,
                multiplier: 0.5
            ),
        ])
    }
}
