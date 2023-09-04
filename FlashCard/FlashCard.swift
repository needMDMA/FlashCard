//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

let animals = ["Aardvark", "Albatross", "Alligator", "Alpaca", "Ant", "Anteater", "Antelope", "Ape", "Armadillo", "Donkey", "Baboon", "Badger", "Barracuda", "Bat", "Bear", "Beaver", "Bee", "Bison", "Boar", "Buffalo", "Butterfly", "Camel", "Capybara", "Caribou", "Cassowary", "Cat", "Caterpillar", "Cattle", "Chamois", "Cheetah", "Chicken", "Chimpanzee", "Chinchilla", "Chough", "Clam", "Cobra", "Cockroach", "Cod", "Cormorant", "Coyote", "Crab", "Crane", "Crocodile", "Crow", "Curlew", "Deer", "Dinosaur", "Dog", "Dogfish", "Dolphin", "Dotterel", "Dove", "Dragonfly", "Duck", "Dugong", "Dunlin", "Eagle", "Echidna", "Eel", "Eland", "Elephant", "Elk", "Emu", "Falcon", "Ferret", "Finch", "Fish", "Flamingo", "Fly", "Fox", "Frog", "Gaur", "Gazelle", "Gerbil", "Giraffe", "Gnat", "Gnu", "Goat", "Goldfinch", "Goldfish", "Goose", "Gorilla", "Goshawk", "Grasshopper", "Grouse", "Guanaco", "Gull", "Hamster", "Hare", "Hawk", "Hedgehog", "Heron", "Herring", "Hippopotamus", "Hornet", "Horse", "Human", "Hummingbird", "Hyena", "Ibex", "Ibis", "Jackal", "Jaguar", "Jay", "Jellyfish", "Kangaroo", "Kingfisher", "Koala", "Kookabura", "Kouprey", "Kudu", "Lapwing", "Lark", "Lemur", "Leopard", "Lion", "Llama", "Lobster", "Locust", "Loris", "Louse", "Lyrebird", "Magpie", "Mallard", "Manatee", "Mandrill", "Mantis", "Marten", "Meerkat", "Mink", "Mole", "Mongoose", "Monkey", "Moose", "Mosquito", "Mouse", "Mule", "Narwhal", "Newt", "Nightingale", "Octopus", "Okapi", "Opossum", "Oryx", "Ostrich", "Otter", "Owl", "Oyster", "Panther", "Parrot", "Partridge", "Peafowl", "Pelican", "Penguin", "Pheasant", "Pig", "Pigeon", "Pony", "Porcupine", "Porpoise", "Quail", "Quelea", "Quetzal", "Rabbit", "Raccoon", "Rail", "Ram", "Rat", "Raven"]

class FlashCard: ObservableObject {
    @Published private(set) var model: DeckContent<Constant.level> {
        didSet {
            autosave()
        }
    }

    init() {
        model = DeckContent<Constant.level>()
        for word in animals {
            addWord(word: word, traduction: word)
        }
        
    }
    
    private struct Autosave {
        static let filename = "deck.data"
        static var url: URL? {
            let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return fileDirectory?.appendingPathComponent(filename)
        }
    }
    
    func autosave() {
        if let url = Autosave.url {
            save(to: url)
        }
    }
    
    private func save(to url: URL) {
        do {
            let data = try model.json()
            try data.write(to: url)
            print("success")
        } catch {
            print("Failed to save")
        }
    }
    
    
    
    func addWord(word: String, traduction: String) {
        model.addWord(level: Constant.level.beginner, word: word, traduction: traduction)
    }
    
    func promoteWord(card: DeckContent<Constant.level>.Card) {
        model.promoteWord(card: card, promotingTo: Constant.level(rawValue: card.currentLevel.rawValue + 1))
    }
    
    func downgradeWord(card: DeckContent<Constant.level>.Card) {
        model.downgradeWord(card: card, downgradeTo: Constant.level(rawValue: card.currentLevel.rawValue - 1))
    }
}
