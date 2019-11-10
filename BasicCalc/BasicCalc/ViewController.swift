//
//  ViewController.swift
//  BasicCalc
//
//  Created by Vitaliy Grinevetsky on 6/11/19.
//  Copyright © 2019 Vitaliy Grinevetsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var historyLAbel: UILabel!
    @IBOutlet weak var resultLAbel: UILabel!
    @IBOutlet weak var mainOperationsContainer: UIView!
    @IBOutlet weak var clearButton: UIButton!
    
    let core = CalcCore()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        core.delegate = self
        setupLayers()
        // Do any additional setup after loading the view.
    }

    /**
     Method to create grid via layers
     
     */
    private func setupLayers(){
        for view in mainOperationsContainer.subviews{
            guard let button = view as? UIButton else {
                continue
            }
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 0.5
        }
    }
    
    
    // MARK: Button Handler
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else {
            return
        }
        core.push(title)
    }
}

extension ViewController: CalcCoreDelegate {
    func calculatedResult(result:String, history:String?){
        historyLAbel.text = history
        resultLAbel.text = result
    }
}

