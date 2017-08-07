//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Abhilash Khare on 7/4/17.
//  Copyright © 2017 Abhilash Khare. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
        @IBOutlet weak var snailButton: UIButton!
        @IBOutlet weak var chipmunkButton: UIButton!
        @IBOutlet weak var rabbitButton: UIButton!
        @IBOutlet weak var vaderButton: UIButton!
        @IBOutlet weak var echoButton: UIButton!
        @IBOutlet weak var reverbButton: UIButton!
        @IBOutlet weak var stopButton: UIButton!
    

    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton (_ sender : UIButton)
    {
        switch(ButtonType(rawValue: sender.tag)!)
        {
        case .slow: playSound(rate: 0.5)
        case .fast: playSound(rate: 1.5)
        case .chipmunk: playSound(pitch: 1000)
        case .vader: playSound(pitch: -1000)
        case .echo: playSound(echo: true)
        case .reverb: playSound(reverb: true)
        }
        configureUI(.playing)
    }
    @IBAction func stopButtonPressed (_ sender : AnyObject)
    {
        //print("stop audio button pressed")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // These codes are supposed to take care of the consistent aspect fit of the button images.
        snailButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    

}
