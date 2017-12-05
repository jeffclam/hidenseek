//
//  ChatRoomVC.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit

class ChatRoomVC: UITableViewController {
    var room : Room!
    var players = [Player]()
    var selectedRow : Int?
    var messages = [Message] ()
    var conversations : [String : [Message]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print ("*** ChatRoomVC: roomname = \(room.name)")
        players = room.getPlayers()
        /*
        room.downloadMessagesFromDB(closure: {
            self.messages = self.room.messages
            
            for player in self.players {
                self.conversations[player.name] = self.messages.filter({
                    $0.sender == player.name || $0.receiver == player.name
                })
            }
        })
        */
        for i in 0 ..< players.count {
            if players[i].name == room!.currentPlayer!.name {
                players.remove(at: i)
                break;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversationCell", for: indexPath) as? ConversationCell
        
        
        let thisPlayer = players[indexPath.row]
        cell?.name.text = thisPlayer.name
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "enterChat", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterChat" {
            if let dvc = segue.destination as? ChatViewController {
                dvc.chattingWith = players[selectedRow!].name
                dvc.room = room
                //dvc.messages = conversations[dvc.chattingWith] ?? [Message]()
            }
        }
    }
}

class ConversationCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
