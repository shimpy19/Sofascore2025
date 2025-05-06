//
//  DatabaseManager.swift
//  Sofa
//
//  Created by Akademija on 16.04.2025..
//

import RealmSwift

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let realm: Realm

    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Realm init failed: \(error)")
        }
    }

    func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("Failed to save \(T.self): \(error)")
        }
    }

    func saveAll<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            print("Failed to save \(T.self) array: \(error)")
        }
    }

    func getAll<T: Object>(ofType type: T.Type) -> Results<T> {
        realm.objects(type)
    }

    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to delete all: \(error)")
        }
    }
}
