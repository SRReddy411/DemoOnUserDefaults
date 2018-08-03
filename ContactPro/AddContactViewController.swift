//
//  AddContactViewController.swift
//  ContactPro
//
//  Created by Appkoder on 30/09/2016.
//  Copyright © 2016 Appkoder. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var contactImgView: UIImageView!
    
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var phoneTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextfield.delegate = self
        phoneTextfield.delegate = self
        
        nameTextfield.becomeFirstResponder()
        
        rounded(view: nameTextfield, radius: 5)
        rounded(view: phoneTextfield, radius: 5)
        rounded(view: contactImgView, radius: 50)
    }
    
    func rounded(view: UIView, radius: CGFloat)
    {
        view.layer.cornerRadius = radius
        view.layer.borderColor = UIColor(red:0.27, green:0.69, blue:0.60, alpha:1.00).cgColor
        view.layer.borderWidth = 3
        view.clipsToBounds = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextfield.resignFirstResponder()
        phoneTextfield.resignFirstResponder()
        
        return true
    }

    @IBAction func selectPhoto(_ sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage]
        contactImgView.image = image as? UIImage
        
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        
        if (nameTextfield.text?.isEmpty)! || (phoneTextfield.text?.isEmpty)! || contactImgView.image == nil
        {
            let alert = UIAlertController(title: "All Required", message: "Please provide a name, phone number and a photo in order to continue", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true)
            
            return
        }
        
        let name = nameTextfield.text!
        let phone = phoneTextfield.text!
        let imageName = name.removeSpaces()
        let randomInt = arc4random_uniform(1000)
        let finalImageName = "\(imageName)\(randomInt)"
        print("final image name :\(finalImageName)")
        let newContact = Contact(name: name, phone: phone, imageName: finalImageName)
        contactsArray.insert(newContact, at: 0)
        
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: contactsArray)
        UserDefaults.standard.set(archivedData, forKey: "contacts")
        
        let image = contactImgView.image!
        
        if let jpgImage = UIImageJPEGRepresentation(image, 0.8)
        {
            let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let directory = urlPath[0]
            let imagePath = directory.appendingPathComponent(finalImageName)
            print("image path :\(imagePath)")
            try? jpgImage.write(to: imagePath)
        }
        
    }
    

}
