

import UIKit

class PartViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    var part: Part?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dentSwitch: UISwitch!
    @IBOutlet weak var scratchSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        if let part = part {
            navigationItem.title = part.name
            nameTextField.text = part.name
            photoImageView.image = part.photo
            if(part.conditions == 121)
            {
               scratchSwitch.setOn(true, animated: false)
            }
            if(part.conditions == 171)
            {
                dentSwitch.setOn(true, animated: false)
            }
            if(part.conditions == 191)
            {
                scratchSwitch.setOn(true, animated: false)
                dentSwitch.setOn(true, animated: false)
            }
        }
        checkValidPartName()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        navigationItem.title = textField.text
        saveButton.enabled = false
        checkValidPartName()
        
    }
    
    func checkValidPartName()
    {
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {

            navigationController!.popViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            
            var conditions = 0
            if (dentSwitch.on && scratchSwitch.on)
            {
                conditions = 191
                print("Dent + Scratches")
                
            }
            else if(dentSwitch.on && !scratchSwitch.on)
            {
                conditions = 171
                print("Dents")
            }
            else if(!dentSwitch.on && scratchSwitch.on)
            {
                conditions = 121
                print("Scratches")
            }
            //TODO: Not this.
            let make = mainInstance.make
            let model = mainInstance.model
            let year = Int(mainInstance.year)
            let stock = mainInstance.stock
            part = Part(name: name, photo: photo!, conditions: conditions, make: make, model: model, year: year!, stock: stock)
            
        }
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .Camera
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
}

