//
//  EventViewController.swift
//  EventExplorer
//
//  Created by Sjoerd Beentjes on 11-11-15.
//  Copyright © 2015 Sjoerd Beentjes. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var photoImageViewer: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "Opmerkingen"
        textView.textColor = UIColor.lightGrayColor()
        
        // Do any additional setup after loading the view, typically from a nib.
        // Handle user input through delegate callback
        eventTextField.delegate = self
        
        if let event = event {
            navigationItem.title = event.name
            eventTextField.text = event.name
            photoImageViewer.image = event.photo
            textView.text = event.detail
            textView.textColor = UIColor.blackColor()
        }
                
        checkValidEventName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: placeholder for text view
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // disable save btn when editing
        saveButton.enabled = false
    }
    
    func checkValidEventName() {
        // disable save btn when field is empty 
        let text = eventTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidEventName()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
         // dismiss picker if user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        photoImageViewer.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Segue naar detail
    
    
    // MARK: Navigation
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = eventTextField.text ?? ""
            let photo = photoImageViewer.image
            let detail = textView.text
        
            event = Event(name: name, photo: photo, detail: detail)
        }
        
    }
    
    // MARK: Actions
    @IBAction func cancelSubmission(sender: UIBarButtonItem) {
        let isPresentingInAddEventMode = presentingViewController is UINavigationController
        
        if isPresentingInAddEventMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        // hide the keyboard
        eventTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        // photo only picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        // ViewController is notified when user picks an image
        imagePickerController.delegate = self
        // ViewController is notified when image is picked
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

}

