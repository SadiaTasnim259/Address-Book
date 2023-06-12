//
//  DatabaseManager.swift
//  UserCoreDataProject2
//
//  Created by Sadia on 11/6/23.
//

import Foundation
import CoreData
import UIKit


class DatabaseManager{
    
    private var context: NSManagedObjectContext{
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addUser(_ user:UserModel ){
        
        let userEntity = UserEntity(context: context) // User create
        userEntity.firstName    = user.firstName
        userEntity.lastName     = user.lastName
        userEntity.phoneNumber  = user.phoneNumber
        userEntity.password     = user.password
        userEntity.imageName    = user.imageName
        
        do{
            try context.save()
        }catch{
            print("User saving error:", error)
        }
    }
    
    func fetchUserAllUser()-> [UserEntity]{
        var users: [UserEntity] = []
        
        do{
            users = try context.fetch(UserEntity.fetchRequest())
        }catch{
            print("Fetch user error", error)
        }
         return users
    }
    
    func fetchSearchedUser(keyword: String) -> [UserEntity] {
        var users: [UserEntity] = []
        
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        let predicate = NSPredicate(format: "firstName CONTAINS[c] %@ OR lastName CONTAINS[c] %@", keyword, keyword)
        fetchRequest.predicate = predicate
        
        do {
            users = try context.fetch(fetchRequest)
        } catch {
            print("Fetch user error: \(error.localizedDescription)")
        }
        
        return users
    }

    func updateUser(user: UserModel, userEntity: UserEntity){
        userEntity.firstName    = user.firstName
        userEntity.lastName     = user.lastName
        userEntity.phoneNumber  = user.phoneNumber
        userEntity.password     = user.password
        userEntity.imageName    = user.imageName
        
        do{
            try context.save()
        }catch{
            print("User saving error:", error)
        }
    }
}
