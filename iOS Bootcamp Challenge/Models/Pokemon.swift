//
//  Pokemon.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation

// MARK: - Pokemon

struct PokemonType: Decodable, Equatable {
    let name: String
    let url: String
}

struct Types: Decodable, Equatable {
    let type: PokemonType
}

struct Ability: Decodable, Equatable {
    let name: String
    let url: String
}

struct PokemonAbility: Decodable, Equatable {
    let ability: Ability
}

struct Pokemon: Decodable, Equatable {

    let id: Int
    let name: String
    let image: String?
    let types: [Types]?
    let weight: Float
    let baseExperience: Int
    let abilities: [PokemonAbility]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case type
        case types
        case sprites
        case other
        case officialArtwork = "official-artwork"
        case frontDefault = "front_default"
        case abilities
        case ability
        case weight
        case baseExperience = "base_experience"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let sprites = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        let other = try sprites.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        let officialArtWork = try other.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        self.image = try? officialArtWork.decode(String.self, forKey: .frontDefault)

        self.abilities = try container.decodeIfPresent([PokemonAbility].self, forKey: .abilities)
        self.types = try container.decodeIfPresent([Types].self, forKey: .types)

        self.weight = try container.decode(Float.self, forKey: .weight)
        self.baseExperience = try container.decode(Int.self, forKey: .baseExperience)
    }

}

extension Pokemon {

    func formattedNumber() -> String {
        String(format: "#%03d", arguments: [id])
    }

    func primaryType() -> String? {
        guard let primary = types?.first else { return nil }
        return primary.type.name.capitalized
    }

    func secondaryType() -> String? {
        guard let secondary = types?.last else { return nil }
        return secondary.type.name.capitalized
    }

}
