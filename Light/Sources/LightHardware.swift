//
//  LightHardware.swift
//  House
//
//  Created by Shaun Merchant on 20/02/2017.
//  Copyright © 2017 Shaun Merchant. All rights reserved.
//

import Foundation

public struct LightHardware {
    
    public static func turnOn() {
        #if os(Linux)
            Shell.execute("echo 0 | sudo tee /sys/class/leds/led0/brightness")
        #else
            print("Unsupported light hardware to turn on.")
        #endif
    }
    
    public static func turnOff() {
        #if os(Linux)
            Shell.execute("echo 1 | sudo tee /sys/class/leds/led0/brightness")
        #else
            print("Unsupported light hardware to turn off.")
        #endif
    }
    
}
