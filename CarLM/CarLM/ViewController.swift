//
//  ViewController.swift
//  CarLM
//
//  Created by Alejandro on 5/18/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Sirve para ocultar la barra de etado: -> prefersStatusBarHidden
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var modelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var extrasSwitch: UISwitch!
    @IBOutlet weak var lblKm: UILabel!
    @IBOutlet weak var kmsSlider: UISlider!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    @IBOutlet weak var lblPrice: UILabel!
    
    let car = Cars()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if stackView != nil {
            self.stackView.setCustomSpacing(25, after: modelSegmentedControl)
            self.stackView.setCustomSpacing(25, after: self.extrasSwitch)
            self.stackView.setCustomSpacing(25, after: self.kmsSlider)
            self.stackView.setCustomSpacing(60, after: self.statusSegmentedControl)
            
            self.calculateValue()
        }
    }

    @IBAction func calculateValue() {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedKms = formatter.string(for: self.kmsSlider.value) ?? "0"
        self.lblKm.text = "Kilometraje: " + formattedKms + " kms"
        
        if let prediction  = try? car.prediction(modelo: Double(self.modelSegmentedControl.selectedSegmentIndex),
                                                 extras: self.extrasSwitch.isOn ? Double(1.0) : Double(0.0),
                                                 kilometraje: Double(self.kmsSlider.value),
                                                 estado: Double(self.statusSegmentedControl.selectedSegmentIndex)){
            
            let clampValue = max (500, prediction.price)
            
            formatter.numberStyle = .currency
            
            self.lblPrice.text = formatter.string(for: clampValue)
        }
        else{
            self.lblPrice.text = "ERROR"
        }
        
    }
}

