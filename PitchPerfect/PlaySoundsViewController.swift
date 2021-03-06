//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by A.M.W on 3/25/19.
//  Copyright © 2019 AW. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordingAudioURL : URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Actions
    // Play Button Action
    @IBAction func playSoundForButton(_ sender: UIButton) {
      
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // Stop Button Action
    @IBAction func stopButtonPressed(_ sender: AnyObject) {

        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snailButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        vaderButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        stopButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        setupAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
   super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
