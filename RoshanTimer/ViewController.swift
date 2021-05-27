//
//  ViewController.swift
//  RoshanTimer
//
//  Created by Jay Batalla on 5/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Enums
    enum Roshan {
        static let minRespawnTime  = 14 //480
        static let maxRespawnTime  = 24
        static let dead            = "Roshan is Dead"
        static let alive           = "Roshan is Alive"
        static let possible        = "Roshan could be Alive"
    }
    
    enum Aegis {
        static let respawnTime  = 8 //300
        static let up           = "The Aegis of the Immortal is Up"
        static let down         = "The Aegis of the Immortal is Down"
        static let notInPlay    = "The Aegis of the Immortal has not been dropped"
        static let expired      = "The Aegis of the Immortal has expired"
    }
    
    
    // MARK: Variables
    var deaths: Int        = 0
    var isDead: Bool       = false
    var roshanMinTimer     = Timer()
    var roshanMaxTimer     = Timer()
    var aegisTimer         = Timer()
    var currentRoshanTime  = 0
    var currentRespawnTime = 0
    var currentAegisTime   = 0

    
    // MARK: Outlets
    @IBOutlet weak var roshanLabel: UILabel!
    @IBOutlet weak var roshanCountdown: UILabel!
    @IBOutlet weak var roshanProgress: UIProgressView!
    @IBOutlet weak var aegisLabel: UILabel!
    @IBOutlet weak var aegisCountdown: UILabel!
    @IBOutlet weak var aegisProgress: UIProgressView!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var killedAegis: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up UI
        setLabels()
        configureButtons()
        roshanCountdown.isHidden = true
        roshanProgress.isHidden  = true
        aegisCountdown.isHidden  = true
        aegisProgress.isHidden   = true
    }
    
    
    // MARK: Functions
    @IBAction func roshanDied(_ sender: Any) {
        //Check if Roshan is definitely alive
        guard !roshanMaxTimer.isValid else {
            return
        }
        
        roshanMinTimer.invalidate()
        roshanMaxTimer.invalidate()
        aegisTimer.invalidate()
        
        roshanLabel.text = Roshan.dead
        aegisLabel.text  = Aegis.up
        killedAegis.backgroundColor = .red
        deadButton.backgroundColor  = .darkGray
        
        currentRoshanTime = 0
        currentAegisTime  = 0
        roshanMinTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRosh), userInfo: nil, repeats: true)
        roshanMaxTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(maxRoshanTimer), userInfo: nil, repeats: true)
        aegisTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAegis), userInfo: nil, repeats: true)
        
        toggleRoshTimer()
        toggleAegisTimer()
        toggleRoshCountdown()
        toggleAegisCountdown()
    }
    
    @IBAction func killedAegis(_ sender: Any) {
        // Can't kill Aegis if Aegis isn't active
        guard aegisTimer.isValid else {
            return
        }
        aegisTimer.invalidate()
        aegisLabel.text = Aegis.down
        killedAegis.backgroundColor = .darkGray
        toggleAegisTimer()
        toggleAegisCountdown()
    }
    
    // MARK: Timer Updates
    @objc func updateRosh() {
        if currentRoshanTime < Roshan.minRespawnTime {
            currentRoshanTime += 1
            roshanCountdown.text    = "Roshan respawns in ~\(Roshan.minRespawnTime - currentRoshanTime) seconds"
            roshanProgress.progress = Float(currentRoshanTime) / Float(Roshan.minRespawnTime)
        } else {
            roshanLabel.text = Roshan.possible
            roshanMinTimer.invalidate()
            toggleRoshTimer()
            toggleRoshCountdown()
            deadButton.backgroundColor = .red
        }
    }
    
    @objc func maxRoshanTimer() {
        if currentRespawnTime < Roshan.maxRespawnTime {
            currentRespawnTime += 1
        } else {
            roshanMaxTimer.invalidate()
            roshanLabel.text = Roshan.alive
        }
    }
    
    @objc func updateAegis() {
        if currentAegisTime < Aegis.respawnTime {
            currentAegisTime += 1
            aegisCountdown.text    = "The Aegis expires in ~\(Aegis.respawnTime - currentAegisTime) seconds"
            aegisProgress.progress = Float(currentAegisTime) / Float(Aegis.respawnTime)
        } else {
            aegisLabel.text = Aegis.expired
            aegisTimer.invalidate()
            toggleAegisTimer()
            toggleAegisCountdown()
            killedAegis.backgroundColor = .darkGray
        }
    }
    
    // MARK: UI Setup
    func setLabels() {
        roshanLabel.text     = Roshan.alive
        aegisLabel.text      = Aegis.notInPlay
        roshanCountdown.text = ""
        aegisCountdown.text  = ""
    }
    
    func configureButtons() {
        deadButton.layer.cornerRadius = 10
        deadButton.layer.borderWidth  = 2
        deadButton.backgroundColor    = .red
        deadButton.setTitle("Killed Roshan", for: .normal)
        
        killedAegis.layer.cornerRadius = 10
        killedAegis.layer.borderWidth  = 2
        killedAegis.backgroundColor    = .darkGray
        killedAegis.setTitle("Killed Aegis", for: .normal)
    }
    
    func toggleRoshTimer() {
        if roshanProgress.isHidden {
            roshanProgress.isHidden = false
        } else {
            roshanProgress.isHidden = true
        }
    }
    
    func toggleRoshCountdown() {
        if roshanCountdown.isHidden {
            roshanCountdown.isHidden = false
        } else {
            roshanCountdown.isHidden = true
        }
    }
    
    func toggleAegisTimer() {
        if aegisProgress.isHidden {
            aegisProgress.isHidden = false
        } else {
            aegisProgress.isHidden = true
        }
    }

    func toggleAegisCountdown() {
        if aegisCountdown.isHidden {
            aegisCountdown.isHidden = false
        } else {
            aegisCountdown.isHidden = true
        }
    }

}

