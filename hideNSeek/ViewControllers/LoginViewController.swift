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
    
    @IBOutlet weak var roomCodeField: UITextField!
    @IBOutlet weak var nickNameField: UITextField!
    
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
        if nickNameField.text!.count > 2 {
            if roomCodeField.text!.count == 0 {
                // Auto-generated roomname
                performSegue(withIdentifier: "enterRoom", sender: sender)
            }
            else if roomCodeField.text!.count >= 4 {
                // If roomname doesn't exist add it, if exists join room
                performSegue(withIdentifier: "enterRoom", sender: sender)
            } else {
                // Room name must be either 0 or greater than 4
                print ("*** Room name must be either 0 or greater than 4")
            }
        } else {
            // Nickname must be at least 2 characters long
            print ("*** Nickname must be at least 2 characters long")
        }
    }
    
    @IBAction func returnToLogin(segue: UIStoryboardSegue) {
        
    }
}

