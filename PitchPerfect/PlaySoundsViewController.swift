//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Roni Beberoni on 1/31/16.
//  Copyright © 2016 Roni Beberoni. All rights reserved.
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
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var fileUrl = NSURL(string: filePath);
//            try! audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl!);
//        } else {
//            print("Sorry the file was not found");
//        }
        
         try! audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl!);
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundSlowly(sender: AnyObject) {
        audioPlayer.enableRate = true;
        audioPlayer.rate = 0.5;
        audioPlayer.play();
    }
    
    
    @IBAction func playSoundFaster(sender: UIButton) {
        print("Click")
                audioPlayer.enableRate = true;
                audioPlayer.rate = 1.5;
                audioPlayer.play();

    }
    
    
    @IBAction func stop(sender: UIButton) {
        audioPlayer.stop();
    }
    
    @IBAction func chipmunkAudioPlay(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderPlayAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
