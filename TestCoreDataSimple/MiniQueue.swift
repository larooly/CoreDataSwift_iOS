//
//  MiniQueue.swift
//  TestCoreDataSimple
//
//  Created by active on 2021/10/20.
//

import Foundation

class MiniQueue{
    var memberMemory = [String]()
    func setMembers(members : [String]){
        memberMemory = members
        
    }
    func getMembers()-> String{
        if(memberMemory.isEmpty){
            return ""
        }else{
            let word = memberMemory[0]
            memberMemory.removeFirst()
            
            return word
        }
    }
    
}
