//
//  ChatViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    var messagesArray: [Message] = [Message]()
    var selectedRow: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(deleteAlert))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.messagesTableView.addGestureRecognizer(longPressGesture)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.messageTextField.frame.height))
        messageTextField.leftView = paddingView
        messageTextField.leftViewMode = .always
        
        messageTextField.delegate = self
        messageTextField.layer.borderColor = UIColor.lightGray.cgColor
        messageTextField.layer.borderWidth = 1.0
        messageTextField.layer.cornerRadius = 17.5
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        
        messagesTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        configureTableView()
        loadMessages()
        
        messagesTableView.separatorStyle = .none
        
        arrowBtn.layer.cornerRadius = 17.5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func deleteAlert(longPressGesture: UILongPressGestureRecognizer) {
        let pos = longPressGesture.location(in: self.messagesTableView)
        let indexPath = self.messagesTableView.indexPathForRow(at: pos)
        
        if indexPath == nil {
            print("No IndexPath")
        } else {
            self.selectedRow = indexPath!.row
            
            let alert = UIAlertController(title: "Supprimer un message", message: "Voulez-vous vraiment supprimer ce message ?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: { (action) in
                self.selectedRow = -1
            })
            let deleteAction = UIAlertAction(title: "Supprimer", style: .destructive, handler: { (action) in
                self.messagesArray.remove(at: self.selectedRow)
                
                let data = NSKeyedArchiver.archivedData(withRootObject: self.messagesArray)
                UserDefaults.standard.set(data, forKey: "messages")
                self.selectedRow = -1
                
                self.configureTableView()
                self.messagesTableView.reloadData()
            })
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        menuVC?.currentIndex = 3
        self.present(menuVC!, animated: true, completion: nil)
    }
    
    func loadMessages() {
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.value(forKey: "messages") as? NSData {
            messagesArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Message]
        } else {
            let message1 = Message(sender: .advisor, message: "Bonjour, pouvez-vous m'en dire un peu plus à propos de votre projet ?")
            messagesArray.append(message1)
            let message2 = Message(sender: .customer, message: "Bonjour, j'aimerais organiser ma lune de miel aux Maldives.")
            messagesArray.append(message2)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: messagesArray)
            userDefaults.set(data, forKey: "messages")
        }
        
        
        
        self.configureTableView()
        self.messagesTableView.reloadData()
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        messageTextField.isSelected = false
        
        let newMessage = Message(sender: .customer, message: messageTextField.text!)
        messagesArray.append(newMessage)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: messagesArray)
        UserDefaults.standard.set(data, forKey: "messages")
        
        messageTextField.isEnabled = false
        sendBtn.isEnabled = false
        messageTextField.text = ""
        
        self.configureTableView()
        self.messagesTableView.reloadData()
        
        messageTextField.isEnabled = true
        sendBtn.isEnabled = true
    }
    
    //MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        cell.messageLabel.text = messagesArray[indexPath.row].message
        
        if messagesArray[indexPath.row].sender == .advisor {
            cell.messageBackground.backgroundColor = UIColor(red: 1, green: 106/255, blue: 0, alpha: 1)
            cell.messageLabel.textColor = UIColor.white
            cell.leftConstraint.priority = UILayoutPriority(100)
            cell.rightConstraint.priority = UILayoutPriority(99)
        } else {
            cell.messageBackground.backgroundColor = UIColor.lightGray
            cell.messageLabel.textColor = UIColor.black
            cell.leftConstraint.priority = UILayoutPriority(99)
            cell.rightConstraint.priority = UILayoutPriority(100)
        }
        
        return cell
    }
    
    func configureTableView() {
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        messagesTableView.estimatedRowHeight = 145.0
    }
    
    //MARK: UITextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 318
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 60
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        messageTextField.isSelected = false
        
        let newMessage = Message(sender: .customer, message: messageTextField.text!)
        messagesArray.append(newMessage)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: messagesArray)
        UserDefaults.standard.set(data, forKey: "messages")
        
        messageTextField.isEnabled = false
        sendBtn.isEnabled = false
        messageTextField.text = ""
        
        self.configureTableView()
        self.messagesTableView.reloadData()
        
        messageTextField.isEnabled = true
        sendBtn.isEnabled = true
        return false
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        messageTextField.resignFirstResponder()
    }
    

}
