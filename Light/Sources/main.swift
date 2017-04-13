import Foundation 
import HouseCore
import HouseExtension

public final class HouseDelegate: UpdateableProcess, LightControllerDelegate {
    
    public var updateFrequency: TimeInterval = UpdateFrequency.every10Seconds.rawValue
    
    public func updatesWillStart() {
        HouseDevice.current().categoryDelegate.lightControllerDelegate = self
        HouseNetwork.current().open()
    }
    
    public var lightStatus: LightStatus = .on
    
    public func turnOnLight() {
        LightHardware.turnOn()
        print("Turning on...")
        self.lightStatus = .on
    }
    
    public func turnOffLight() {
        LightHardware.turnOff()
        print("Turning off...")
        self.lightStatus = .off
    }
    
    
    public func didRequestLightStatus() {
        self.didDetermineLightStatus(was: self.lightStatus)
    }
    
}

HouseRuntime.run(HouseDelegate(), as: .houseExtension)

