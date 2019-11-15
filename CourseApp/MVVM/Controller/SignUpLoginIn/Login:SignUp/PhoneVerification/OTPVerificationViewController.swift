//
//  OTPVerificationViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import UITextField_Max

class OTPVerificationViewController: UIViewController {
    
    
    //MARK::- OUTLETS
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelResend: UILabel!
    @IBOutlet weak var textFieldOTP: UITextField!
    
    //MARK::- PROPERTIES
    var phoneVM = PhoneVerificationVM()
    var countdownTimer: Timer!
    var totalTime = 60
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        textFieldOTP?.maxLength = 4
        labelResend.addTapGesture { [weak self] (tap) in
            self?.resendOtp()
        }
    }
    
    //MARK::- FUNCTIONS
    
    func resendOtp(){
        phoneVM.resendOtp { [weak self] (status) in
            if /status{
                self?.startTimer()
                self?.labelResend.isHidden = false
            }
        }
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        labelTimer.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        labelTimer.text = ""
        labelResend?.isHidden = false
        countdownTimer?.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    //MARK::- ACTIONS
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.popVC()
    }
    
    @IBAction func btnActionNext(_ sender: UIButton) {
        phoneVM.user?.otp = /textFieldOTP?.text
        phoneVM.verifyOtp()
    }
    
    
}
