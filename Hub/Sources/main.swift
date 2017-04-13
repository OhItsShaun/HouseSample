import Foundation
import HouseCore
import HouseHub
import Time

class TestAutomation: TimeAutomation {
    
    let label: String = "Test Time"
    
    var nextDue: TimeInterval
    
    init() {
        self.nextDue = Time.current.timeIntervalIntoCurrentDay
    }
    
    func perform() {
        print("Did trigger automation...")
        self.nextDue += 60
    }
}

class HubDelegate: UpdateableProcess {
    
    var updateFrequency: TimeInterval = 5
    var turningOff = true
    
    func updatesWillStart() {
        print("Updates will start..")
        House.automation.addAutomation(TestAutomation())
        HouseNetwork.current().open()
        
//        let bridge = HueBridge(atAddress: "http://192.168.0.2", usingUsername: Config.philipsHueUsername)
//        for light in bridge.getLights() {
//            House.extensions.addExtension(light)
//        }
        
    }
    
    func update(at time: Date) {
        print("Updating..")
        
        let lights = House.extensions.lightControllers()
        for light in lights {
            if turningOff {
                print("Turning off...")
                light.turnOffLight()
            }
            else {
                print("Turning on...")
                light.turnOnLight()
            }
        }
        self.turningOff = !self.turningOff
    }
    
}

HouseRuntime.run(HubDelegate(), as: .houseHub)
