//
//  RoomViewController.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit
import CoreLocation

class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var locationManager : CLLocationManager!
    var roomService : RoomService?
    var room : Room?
    var players = [Player]()
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        room!.getPlayersFromDB(closure: {
            self.players = self.room!.getPlayers()
            self.tableView.reloadData()
        })
        
        roomNameLabel.text = room!.name
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
        }
        /*
        else if let dvc = segue.destination as? LoginViewController {
            //dvc.roomService
            //remove player from room
        }
        */
    }
}
