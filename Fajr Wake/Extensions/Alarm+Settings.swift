//
//  Settings.swift
//  FajrWake
//
//  Created by Ali Mir on 9/5/17.
//  Copyright © 2017 com.AliMir. All rights reserved.
//

import Foundation

// Custom Types

extension UserDefaults {
    subscript(key: DefaultsKey<AlarmStatuses?>) -> AlarmStatuses? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
    
    subscript(key: DefaultsKey<Prayer?>) -> Prayer? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
    
    subscript(key: DefaultsKey<CalculationMethod?>) -> CalculationMethod? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
}

// Static Keys
extension DefaultsKeys {
    static let status = DefaultsKey<AlarmStatuses?>("FW-STATUS")
    static let prayer = DefaultsKey<Prayer?>("FW-PRAYERTIME")
    static let ringtoneID = DefaultsKey<String?>("FW-RINGTONEID")
    static let ringtoneExtension = DefaultsKey<String?>("FW-RINGTONEEXTENSION")
    static let isSoundRepeated = DefaultsKey<Bool?>("FW-ISSOUNDREPEATED")
    static let minsToAdjust = DefaultsKey<Int?>("FW-MINSTOADJUST")
    static let userExitDate = DefaultsKey<Date?>("FW-PROGRAMEXITDATE")
    static let prayertimeDate = DefaultsKey<Date?>("FW-PRAYERTIMEDATE")
    static let calcMethod = DefaultsKey<CalculationMethod?>("FW-CALCULATIONMETHOD")
    static let latitude = DefaultsKey<Double?>("FW-PRAYERLATITUDE")
    static let longitude = DefaultsKey<Double?>("FW-PRAYERLONGITUDE")
    static let placeName = DefaultsKey<String?>("FW-LOCATIONPLACENAME")
    static let firstAppLaunch = DefaultsKey<String?>("FW-FIRSTTIMEAPPLAUNCH")
    static let fireDate = DefaultsKey<Date?>("FW-FIREDATELATEST")
}

internal var isFirstAppLaunch: Bool {
    if Defaults[.firstAppLaunch] == nil {
        Defaults[.firstAppLaunch] = "AppLaunchedBefore"
        return true
    } else {
        return false
    }
}

// MARK: - extension Alarm

extension Alarm {
    struct Settings {
        
        static var fireDate: Date? {
            get {
                return Defaults[.fireDate]
            }
            set {
                if let fireDate = newValue {
                    Defaults[.fireDate] = fireDate
                } else {
                    Defaults.remove(.fireDate)
                }
            }
        }
        
        static var placeName: String? {
            get {
                return Defaults[.placeName]
            }
            set {
                if let placeName = newValue {
                    Defaults[.placeName] = placeName
                }
            }
        }
        
        static var prayerTimeSetting: PrayTimeSetting? {
            get {
                guard let latitude = Defaults[.latitude], let longitude = Defaults[.longitude], let calcMethod = Defaults[.calcMethod] else {
                    return nil
                }
                return PrayTimeSetting(calcMethod: calcMethod, latitude: latitude, longitude: longitude)
            }
            set {
                guard let setting = newValue else {
                    return
                }
                Defaults[.latitude] = setting.latitude
                Defaults[.longitude] = setting.longitude
                Defaults[.calcMethod] = setting.calcMethod
            }
        }
        
        
        static var soundSetting: SoundSetting? {
            get {
                if let ringtoneID = Defaults[.ringtoneID], let ringExt = Defaults[.ringtoneExtension], let isRepeated = Defaults[.isSoundRepeated] {
                    return SoundSetting(ringtoneID: ringtoneID, ringtoneExtension: ringExt, isRepeated: isRepeated)
                } else {
                    return nil
                }
            }
            set {
                if let setting = newValue {
                    Defaults[.ringtoneID] = setting.ringtoneID
                    Defaults[.ringtoneExtension] = setting.ringtoneExtension
                    Defaults[.isSoundRepeated] = setting.isRepeated
                }
            }
        }
        
        static var minsToAdjust: Int? {
            get {
                return Defaults[.minsToAdjust]
            }
            set {
                if let minsToAdjust = newValue {
                    Defaults[.minsToAdjust] = minsToAdjust
                }
            }
        }
        
        static var selectedPrayer: Prayer? {
            get {
                return Defaults[.prayer]
            }
            set {
                if let prayer = newValue {
                    Defaults[.prayer] = prayer
                }
            }
        }
        
        static var status: AlarmStatuses? {
            get {
                return Defaults[.status]
            }
            set {
                if let status = newValue {
                    Defaults[.status] = status
                }
            }
        }
    }
}

