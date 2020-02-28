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


}

