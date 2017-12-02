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
    
    init() {
    }
    
    func accessRoom(roomname: String, closure: @escaping () -> Void) {
        Database.database().isPersistenceEnabled = true
        dbRoot = Database.database().reference(withPath: "rooms")
        dbRoot!.child(roomname).observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.exists()) {
                self.room = Room(name: roomname, ref: self.dbRoot!)
                closure()
            } else {
                print ("*** Room doesn't exist" )
            }
        })
    }
    
    func retrieveRoom(roomname: String, closure: @escaping () -> Void) {
        dbRoot?.queryOrdered(byChild: "\"\(roomname)\"").observe(.value, with:
            { snapshot in
                var room = Room(name: "blank", ref: self.dbRoot!)
                
                for item in snapshot.children {
                    room = Room(snapshot: item as! DataSnapshot)
                }
                
                self.room = room
                print("***room \(room.name) retrieved")
                closure()
        })
    }
}
