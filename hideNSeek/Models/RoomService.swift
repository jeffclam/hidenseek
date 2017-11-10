//
//  RoomService.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class RoomService {
    var dbRoot : DatabaseReference?
    var room : Room?
    var rooms = [Room]()
    var players = [Player]()
    
    init() {
    }
    
    func accessRooms() {
        Database.database().isPersistenceEnabled = true
        dbRoot = Database.database().reference(withPath: "rooms")
        
        retrieveRooms()
    }
    
    func retrievePlayers() {
        Database.database().isPersistenceEnabled = true
        dbRoot = Database.database().reference(withPath: "rooms")
        dbRoot?.child("\"room_test\"").child("players").child("\"mark\"").observe(.value, with:
            { snapshot in
                var player = Player(name: "blank", latitude: 0.00, longitude: 0.00, isHider: true)
                
                player = Player(snapshot: snapshot)
                
                print ("*** Player \(player.name) retrieved")
        })
    }
    
    func retrieveRoom(roomname: String) {
        Database.database().isPersistenceEnabled = true

        dbRoot = Database.database().reference(withPath: "rooms")
        dbRoot?.queryOrdered(byChild: "\"\(roomname)\"").observe(.value, with:
            { snapshot in
                var room = Room(name: "blank", players: [Player]())
                
                for item in snapshot.children {
                    room = Room(snapshot: item as! DataSnapshot)
                }
                
                self.room = room
                print("***room \(room.name) retrieved")
        })
    }
    
    func retrieveRooms() {
        dbRoot?.queryOrdered(byChild: "Rooms").observe(.value, with:
            { snapshot in
                var rooms = [Room]()
                
                for item in snapshot.children {
                    rooms.append(Room(snapshot: item as! DataSnapshot))
                }
                self.rooms = rooms
            }
        )
    }
}
