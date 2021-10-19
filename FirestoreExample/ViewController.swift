//
//  ViewController.swift
//  FirestoreExample
//
//  Created by othman shahrouri on 10/19/21.
//

//each document have a dictionary in it which will hold the values

//to read and write anything to the database we need to have a document reference




import FirebaseFirestore
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //create a database
    let database = Firestore.firestore()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter text..."
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        return field
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(field)
        //We need to get the event when the user hit return button
        field.delegate = self
       
        //read data
        let docRef = database.document("diajo/example")
        docRef.getDocument() { (snapshot,error) in
            
            guard let data = snapshot?.data(), error == nil else { return }
            guard let text = data["text"] as? String else { return }
            
            //update ui with our data saved in firebase
            DispatchQueue.main.async { [weak self] in
                self?.label.text = text
            }
        }
        
    }
    
  
    func writeData(text: String){
        //gets a document reference at specified path in database
        //"collection/document"
        let docRef = database.document("diajo/example")
        //set data as dicitionary
        docRef.setData(["text": text])
    }
    
    //assign some frames to label and field
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        field.frame = CGRect(x: 10, y: view.safeAreaInsets.top+10
                             , width: view.frame.size.width-20,
                             height: 50)
        
        label.frame = CGRect(x: 10, y: view.safeAreaInsets.top+10+60
                             , width: view.frame.size.width-20,
                             height: 50)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //make sure text isnt empty then save data
        if let text = textField.text, !text.isEmpty {
            writeData(text: text)
            
        }
        return true
    }

    
    

}

 
