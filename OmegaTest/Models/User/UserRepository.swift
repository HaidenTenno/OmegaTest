//
//  UserRepository.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 19.06.2021.
//

import Foundation
import RealmSwift

protocol UserRepository: Repository {
    func getAll(completion: @escaping (Result<[User], RepositoryError>) -> Void)
    func getSingle(email: String, completion: @escaping (Result<User, RepositoryError>) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Result<User, RepositoryError>) -> Void)
    func signUp(firstName: String, lastName: String, age: Int, phoneNumber: String, email: String, password: String, completion: @escaping (Result<User, RepositoryError>) -> Void)
}

final class RealmUserRepository: UserRepository {
    
    var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getAll(completion: @escaping (Result<[User], RepositoryError>) -> Void) {
        let users = Array(realm.objects(User.self))
        completion(.success(users))
        return
    }
    
    func getSingle(email: String, completion: @escaping (Result<User, RepositoryError>) -> Void) {
        let person = realm.object(ofType: User.self, forPrimaryKey: email) // ???
        guard let user = person else {
            #if DEBUG
            print("GET SINGLE USER FAIL")
            #endif
            completion(.failure(.notFound))
            return
        }
        completion(.success(user))
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, RepositoryError>) -> Void) {
        getSingle(email: email) { result in
            switch result {
            case .failure(let error):
                #if DEBUG
                print("SIGN IN FAIL")
                #endif
                completion(.failure(error))
            case .success(let user):
                if user.password == password {
                    completion(.success(user))
                } else {
                    completion(.failure(.unauthorized))
                }
            }
        }
    }
    
    func signUp(firstName: String, lastName: String, age: Int, phoneNumber: String, email: String, password: String, completion: @escaping (Result<User, RepositoryError>) -> Void) {
        do {
            try realm.write {
                let user = User(firstName: firstName, lastName: lastName, age: age, phoneNumber: phoneNumber, email: email, password: password)
                realm.add(user)
                completion(.success(user))
            }
        } catch (let error) {
            #if DEBUG
            print("SIGN UP FAIL")
            #endif
            completion(.failure(RepositoryError.internalError(error)))
        }
    }
}
