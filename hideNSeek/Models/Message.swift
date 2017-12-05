//
//  Message.swift
//  hideNSeek
//
//  Created by CheckoutUser on 12/4/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import Foundation
import Firebase

class Message {
    var timeStamp : Int
    var content : String
    var sender : String
    var receiver : String
    
    init (content: String, sender: String, receiver: String) {
        self.timeStamp = Int(Date().timeIntervalSince1970)
        self.content = content
        self.sender = sender
        self.receiver = receiver
    }
    
    init(snapshot: DataSnapshot) {
        let snapvalues = snapshot.value as! [String : AnyObject]
        print ("snapvalues in message \(snapshot.key): \(snapvalues)")
        timeStamp = snapvalues["timeStamp"] as! Int
        content = snapvalues["content"] as! String
        sender = snapvalues["sender"] as! String
        receiver = snapvalues["receiver"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "timeStamp" : timeStamp,
            "content" : content,
            "sender" : sender,
            "receiver" : receiver
        ]
    }
}
