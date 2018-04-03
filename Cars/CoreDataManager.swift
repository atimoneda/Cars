//
//  CoreDataManager.swift
//  Cars
//
//  Created by Arnau Timoneda Heredia on 6/3/18.
//  Copyright © 2018 Arnau Timoneda Heredia. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager : NSObject{
    static let sharedInstance = CoreDataManager()
    
    var managedContext: NSManagedObjectContext? = nil
    
    override init(){
        super.init()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedContext = appDelegate!.persistentContainer.viewContext
    }
    
    func getScores() -> [Score] {
        var scores:[Score] = []
        
        let fetchRequest : NSFetchRequest<Score> = NSFetchRequest(entityName: "Score")
        
        do{
            scores = (try self.managedContext?.fetch(fetchRequest) as [Score]?)!
            scores.sort{$0.score > $1.score}
        } catch {
            print("Core Data Error(ath).")
        }
        
        return scores
    }
    
    func addScrore(playerName: String, score: NSNumber) -> Score{
        
        let newScore:Score = NSEntityDescription.insertNewObject(forEntityName: "Score", into: self.managedContext!) as! Score
        newScore.playerName = playerName
        newScore.score = score as! Int16
        
        let allScores = self.getScores()
        if(allScores.count > 10){
            self.delete(score: allScores.last!)
        } else {
            self.save()
        }
        return newScore
    }
    
    func delete(score: Score){
        self.managedContext?.delete(score)
        self.save()
    }
    
    func save(){
        do{
            try self.managedContext?.save()
        } catch {
            print("Error saving managed context")
        }
    }
}
