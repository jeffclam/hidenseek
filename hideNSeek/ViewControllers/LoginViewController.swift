//
//  ViewController.swift
//  hideNSeek
//
//  Created by CheckoutUser on 11/6/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let roomService = RoomService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print ("*** Loaded")
        roomService.retrieveRoom(roomname: "room_test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! RoomViewController
        dvc.roomService = roomService
    }
    
    @IBAction func startGame(_ sender: Any) {
        
    }
}

