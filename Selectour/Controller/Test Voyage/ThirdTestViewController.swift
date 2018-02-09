//
//  ThirdTestViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class ThirdTestViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var agePickerView: UIPickerView!
    var ages = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(0, forKey: "thirdChoice")
        for i in 15...99 {
            ages.append(i)
        }
        agePickerView.delegate = self
        agePickerView.dataSource = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickerTapped))
        tapGestureRecognizer.delegate = self
        self.agePickerView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pickerTapped(tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let rowHeight = self.agePickerView.rowSize(forComponent: 0).height
            let selectedRowFrame = self.agePickerView.bounds.insetBy(dx: 0, dy: (self.agePickerView.frame.height - rowHeight) / 2)
            let userTappedOnSelectedRow = selectedRowFrame.contains(tapRecognizer.location(in: self.agePickerView))
            if userTappedOnSelectedRow {
                let selectedRow = self.agePickerView.selectedRow(inComponent: 0)
                let userDefaults = UserDefaults.standard
                userDefaults.setValue(ages[selectedRow], forKey: "thirdChoice")
                self.performSegue(withIdentifier: "goToFourth", sender: self)
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.subviews.forEach({
            
            $0.isHidden = $0.frame.height < 1.0
        })
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = ages[row].description
        pickerLabel.font = UIFont(name: "AvenirNext-Bold", size: 50) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    @IBAction func ignoreBtnPressed(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: "testDone")
        let discoverVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverViewController") as? DiscoverViewController
        self.present(discoverVC!, animated: true, completion: nil)
    }
    
}
