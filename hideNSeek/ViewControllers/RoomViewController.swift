//
//  RoomViewController.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var roomService: RoomService?
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        players = (roomService?.room?.players)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerViewCell", for: indexPath) as? PlayerViewCell
        
        let thisPlayer = players[indexPath.row]
        cell?.nickname.text = thisPlayer.name
        cell?.location.text = "(\(thisPlayer.latitude), \(thisPlayer.longitude))"
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? MasterTabVC {
            dvc.roomService = roomService
        } else if let dvc = segue.destination as? LoginViewController {
            //dvc.roomService
            //remove player from room
        }
    }
}
