//
//  ViewController.swift
//  FirestoreExample
//
//  Created by othman shahrouri on 10/19/21.
//

//each document have a dictionary in it which will hold the values
import FirebaseFirestore
import UIKit

class ViewController: UIViewController {
    //create a database
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//to read and write anything to the database we need to have a document reference
        
    }
    
  
    func writeData(text: String){
        //gets a document reference at specified path in database
        //"collection/document"
        let docRef = database.document("diajo/example")
        //set data as dicitionary
        docRef.setData(["text": text])
    }

    
    

}

 
