//
//  ChatViewController.swift
//  hideNSeek
//
//  Created by Jeffrey Lam on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//  Based on https://github.com/aslanyanhaik/Quick-Chat

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var barHeight: CGFloat = 50
    var chattingWith: String!
    var room: Room!
    var messages = [Message]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputBar: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    
    override var inputAccessoryView: UIView? {
        self.inputBar.frame.size.height = self.barHeight
        self.inputBar.clipsToBounds = true
        return self.inputBar
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
 
    func customization() {
        self.tableView.estimatedRowHeight = self.barHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset.bottom = self.barHeight
        self.tableView.scrollIndicatorInsets.bottom = self.barHeight
        self.navigationItem.title = chattingWith
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        customization()
        room.downloadMessagesFromDB(from: room.currentPlayer!.name, to: chattingWith, closure: {
            (conversation: [Message]) -> Void in
            self.messages = conversation
            self.messages.sort(by: {$0.timeStamp < $1.timeStamp})
            for message in self.messages {
            print ("*** From \(message.sender): \(message.content)")
            }
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickSend(_ sender: UIButton) {
        if (inputTextField.text!.count > 0) {
            room.sendMessage(message: Message(content: inputTextField.text!, sender: (room.currentPlayer?.name)!, receiver: chattingWith))
            inputTextField.resignFirstResponder()
            inputTextField.text = ""
            print("*** send clicked ***")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputTextField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.messages[indexPath.row].sender {
        case room.currentPlayer!.name:
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! SenderCell
            cell.sentMessage.text = self.messages[indexPath.row].content
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiverCell", for: indexPath) as! ReceiverCell
            cell.receivedMessage.text = self.messages[indexPath.row].content
            return cell
        }
    }
    
}

class ReceiverCell: UITableViewCell {
    @IBOutlet weak var receivedMessage: UITextView!
    
}

class SenderCell: UITableViewCell {
    @IBOutlet weak var sentMessage: UITextView!
    
}
