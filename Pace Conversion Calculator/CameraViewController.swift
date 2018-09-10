//
//  CameraViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 9/2/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var image: UIImage?
    var frame = CGRect()
    var picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBAction func pictureButton(_ sender: UIButton) {
        if image == nil {
            picker.takePicture()
        } else if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.mediaTypes = [kUTTypeImage as String]
            present(picker, animated: true)
            image = nil
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UIImagePickerController.isSourceTypeAvailable(.camera), image == nil {            picker.sourceType = .camera
            picker.mediaTypes = [kUTTypeImage as String]
            picker.delegate = self
            picker.showsCameraControls = false
            picker.cameraOverlayView = takePictureButton
            present(picker, animated: true)
        } else {
            imageView.image = image
            takePictureButton.frame.origin = CGPoint(x: view.center.x, y: view.center.y)
            view.addSubview(takePictureButton)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.presentingViewController?.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage ?? info[UIImagePickerController.InfoKey.originalImage] as? UIImage) {
            self.image = image
        }
        picker.dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
