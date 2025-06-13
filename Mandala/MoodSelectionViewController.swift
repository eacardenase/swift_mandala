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
            currentMood = moods.first

            moodSelector.images = moods.map { $0.image }
        }
    }

    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton.setTitle(nil, for: .normal)
                addMoodButton.backgroundColor = nil

                return
            }

            addMoodButton.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton.backgroundColor = currentMood.color
        }
    }
    let moodsConfigurable: MoodsConfigurable = MoodListViewController()

    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)

        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false

        return visualEffect
    }()

    let moodSelector: ImageSelector = {
        let imageSelector = ImageSelector()

        imageSelector.translatesAutoresizingMaskIntoConstraints = false
        imageSelector.addTarget(
            self,
            action: #selector(moodSelectionChanged),
            for: .valueChanged
        )

        return imageSelector
    }()

    let addMoodButton: UIButton = {
        let button = UIButton(type: .custom)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(
            self,
            action: #selector(addMoodEntry),
            for: .touchUpInside
        )

        return button
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

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.addMoodButton.layer.cornerRadius =
                self.addMoodButton.bounds.height / 2
        }
    }
}

// MARK: - Helpers

extension MoodSelectionViewController {
    func setupViews() {
        moodsConfigurable.view.bounds = view.bounds

        addChild(moodsConfigurable)
        view.addSubview(moodsConfigurable.view)

        moodsConfigurable.didMove(toParent: self)

        visualEffectView.contentView.addSubview(moodSelector)

        view.addSubview(visualEffectView)
        view.addSubview(addMoodButton)

        // visualEffectView
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            visualEffectView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            visualEffectView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])

        // moodSelector
        NSLayoutConstraint.activate([
            moodSelector.topAnchor.constraint(
                equalTo: visualEffectView.topAnchor,
                constant: 8
            ),
            moodSelector.leadingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.leadingAnchor
            ),
            moodSelector.trailingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.trailingAnchor
            ),
            moodSelector.bottomAnchor.constraint(
                equalTo: view.layoutMarginsGuide.bottomAnchor
            ),
            moodSelector.heightAnchor.constraint(equalToConstant: 50),
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

// MARK: - Actions

extension MoodSelectionViewController {
    @objc func moodSelectionChanged(_ sender: ImageSelector) {
        print(#function)

        let selectedIndex = sender.selectedIndex

        currentMood = moods[selectedIndex]
    }

    @objc func addMoodEntry(_ sender: UIButton) {
        guard let currentMood = currentMood else { return }

        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())

        moodsConfigurable.add(newMoodEntry)
    }
}
