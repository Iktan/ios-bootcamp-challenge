//
//  CardView.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 28/09/21.
//

import UIKit

final class CardView: UIView {

    private let margin: CGFloat = 30
    var card: Card?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var typesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var abilitiesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(card: Card) {
        self.card = card
        super.init(frame: .zero)
        setup()
        setupUI()
    }

    required init?(coder: NSCoder) { 
        super.init(coder: coder)
        setup()
        setupUI()
    }

    private func setup() {
        guard let card = card else { return }

        var types = ""
        var abilities = ""
        
        card.items.forEach { item in
            
            if item.title == "Types" {
                types = "🌎 " + item.title + "\n" + item.description.capitalized
            } else if item.title == "Abilities" {
                abilities = "👌 " + item.title + "\n" + item.description.capitalized
            }
        }

        titleLabel.text = card.title
        typesLabel.text = types
        abilitiesLabel.text = abilities
        backgroundColor = .white
        layer.cornerRadius = 20
    }

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(typesLabel)
        addSubview(abilitiesLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: margin * 2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.70).isActive = true

        typesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin).isActive = true
        typesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        typesLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.70).isActive = true
        
        abilitiesLabel.topAnchor.constraint(equalTo: typesLabel.bottomAnchor, constant: margin).isActive = true
        abilitiesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        abilitiesLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.70).isActive = true
        
    }

}
