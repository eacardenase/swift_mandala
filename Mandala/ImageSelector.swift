//
//  ImageSelector.swift
//  Mandala
//
//  Created by Edwin Cardenas on 6/13/25.
//

import UIKit

class ImageSelector: UIControl {

    var selectedIndex = 0 {
        didSet {
            let imageButton = imageButtons[selectedIndex]

            highlightViewXConstraint = highlightView.centerXAnchor.constraint(
                equalTo: imageButton.centerXAnchor
            )
        }
    }

    private var imageButtons = [UIButton]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }

            imageButtons.forEach { selectorStackView.addArrangedSubview($0) }
        }
    }

    var images = [UIImage]() {
        didSet {
            imageButtons = images.map { image in
                let imageButton = UIButton()

                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget(
                    self,
                    action: #selector(imageButtonTapped),
                    for: .touchUpInside
                )

                return imageButton
            }

            selectedIndex = 0
        }
    }

    private let selectorStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12

        return stackView
    }()

    private let highlightView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = view.tintColor

        return view
    }()

    private var highlightViewXConstraint: NSLayoutConstraint! {
        didSet {
            oldValue?.isActive = false
            highlightViewXConstraint.isActive = true
        }
    }

    // MARK: View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureViewHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2
    }
}

// MARK: - Helpers

extension ImageSelector {
    private func configureViewHierarchy() {
        backgroundColor = .clear

        addSubview(selectorStackView)
        insertSubview(highlightView, belowSubview: selectorStackView)

        // selectorStackView
        NSLayoutConstraint.activate([
            selectorStackView.topAnchor.constraint(equalTo: topAnchor),
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        // highlightView
        NSLayoutConstraint.activate([
            highlightView.heightAnchor.constraint(
                equalTo: highlightView.widthAnchor
            ),
            highlightView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: 0.9
            ),
            highlightView.centerYAnchor.constraint(
                equalTo: selectorStackView.centerYAnchor
            ),
        ])
    }
}

// MARK: - Actions

extension ImageSelector {
    @objc func imageButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("The buttons and images are not parallel.")
        }

        selectedIndex = buttonIndex

        sendActions(for: .valueChanged)
    }
}
