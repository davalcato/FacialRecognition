//
//  ViewController.swift
//  FacialRecognition
//
//  Created by Daval Cato on 2/24/20.
//  Copyright © 2020 Daval Cato. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var fadeView: UIView!
    
    @IBOutlet weak var findFacesButton: UIButton!
    
    var picker:UIImagePickerController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        findFacesButton.isHidden = true
        fadeView.isHidden = true
        picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        savePhotos()
    }
    
    func savePhotos() {
        for num in 1...4 {
            let fileName = "img\(num).jpeg"
            if UserDefaults.standard.bool(forKey: fileName) {
                print("\(fileName) previously saved")
                continue
        }
        if let img = UIImage(named: fileName) {
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
            UserDefaults.standard.set(true, forKey: fileName)
            
        }
        else {
            print("error getting file")
            
        }
        
    }
    
}
    @IBAction func selectPhoto(_ sender: Any) {
        picker.modalPresentationStyle = .overFullScreen
        self.modalPresentationStyle = .pageSheet
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = img
        findFacesButton.isHidden = false
        
    }
    
    @IBAction func findFaces(_ sender: Any) {
        findFacesButton.isHidden = true
        activityIndicator.startAnimating()
        fadeView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.lookForFaces()
            
        }
        
    }
     
    func lookForFaces() {
        var orientation:CGImagePropertyOrientation
        switch imageView.image!.imageOrientation {
        case .down:
            orientation = .down
        case .up:
            orientation = .up
        case .left:
                orientation = .left
        default:
            orientation = .right
        }
        
        let request = VNDetectFaceLandmarksRequest(completionHandler: self.handleLandmarkRequest)
        let handler = VNImageRequestHandler(cgImage: imageView.image!.cgImage!, orientation: orientation, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    func handleLandmarkRequest(request:VNRequest, error: Error?) {
        guard let results = request.results as? [VNFaceObservation] else {
            print("no faces detected")
            return
        }
        
    }
    
}
