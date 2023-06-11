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
        
        let userEntity = UserEntity(context: context)
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.phoneNumber = user.phoneNumber
        userEntity.password = user.password
        
        do{
            try context.save()
        }catch{
            print("User saving error:", error)
        }
    }
    
    func fetchUser()-> [UserEntity]{
        var users: [UserEntity] = []
        
        do{
            users = try context.fetch(UserEntity.fetchRequest())
        }catch{
            print("Fetch user error", error)
        }
         return users
    }
    
      
}
