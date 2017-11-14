//
//  Room.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Room {
    var name: String
    //var roomLeader: String
    var players = [Player]()
    let ref: DatabaseReference?
    
    init (name: String, players: [Player]) {
        self.name = name
        self.players = players
        ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        name = snapshot.key
        let snapvalues = snapshot.value as! [String : AnyObject]
        print ("snapvalues in Room: \(snapvalues)")
        ref = snapshot.ref
        ref?.child("players").observe(.value, with:
            { snapshot in
                var players = [Player]()
                
                for item in snapshot.children {
                    players.append(Player(snapshot: item as! DataSnapshot))
                }
                self.players = players
            }
        )
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : name,
            "players" : players
        ]
    }
}
