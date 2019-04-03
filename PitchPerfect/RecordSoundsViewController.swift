//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by A.M.W on 3/24/19.
//  Copyright © 2019 AW. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    // For Segue
    
    let stopRecordingSegue = "stopRecording"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    

    func configureUI(isRecording: Bool) {

        stopRecordingButton.isEnabled = isRecording
        recordingLabel.text = isRecording ? "stop recording..." : "tap to record..."
    }

    @IBAction func recordAudio(_ sender: Any) {
        
        configureUI(isRecording:true)

      stopRecordingButton.isEnabled = true
        recordingButton.isEnabled = false
   
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(isRecording: false)

        
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap To Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // Delegate for AvAudioRecorder
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("stopped recording.")
            performSegue(withIdentifier: stopRecordingSegue, sender: audioRecorder.url)
        } else {
            print("error recording.")
        }
    }
    
    // Moving to another VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == stopRecordingSegue else { return }
        guard let playSoundsVC = segue.destination as? PlaySoundsViewController else { return }
        guard let recordedAudioURL = sender as? URL else { return }
        playSoundsVC.recordingAudioURL = recordedAudioURL
        }
    }

    


