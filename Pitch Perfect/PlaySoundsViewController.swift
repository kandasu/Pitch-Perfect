//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Kan Matsuura on 9/27/15.
//  Copyright (c) 2015 Kan Matsuura. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to:changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect, to:audioEngine.outputNode, format:nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
}
