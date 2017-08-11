//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Abhilash Khare on 6/15/17.
//  Copyright © 2017 Abhilash Khare. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate  {

    var audioRecorder : AVAudioRecorder!
    
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecording: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecording.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }



    @IBAction func recordAudio(_ sender: Any) {
        print("record button was pressed")
        recordingLabel.text="Recording in Progress"
        configureUI(button: stopRecording, isRecording: true)
        //stopRecording.isEnabled = true
        configureUI(button: recordButton, isRecording: false)
      //  recordButton.isEnabled = false
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordingVoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
         print(filePath as Any)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with : .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    
   
    @IBAction func stopRecording(_ sender: Any) {
    //    print("stop recording was pressed")
     //   recordButton.isEnabled = true
        configureUI(button: recordButton, isRecording: true)
       // stopRecording.isEnabled = false
        configureUI(button: stopRecording, isRecording: false)
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
             performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else
        {
            print("recording was not successful")
            let alertController = UIAlertController(title: "Recording Not Successful", message: "Record again", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Close",style: UIAlertActionStyle.default, handler : nil))
            self.present(alertController,animated:  true,completion: nil)
            }
       }
    
    func configureUI(button: UIButton, isRecording: Bool)
    {
        button.isEnabled = isRecording
     
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
        if segue.identifier == "stopRecording"
        {
         let playSoundsVC = segue.destination as! PlaySoundViewController
          let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
        }
    }
    
}

