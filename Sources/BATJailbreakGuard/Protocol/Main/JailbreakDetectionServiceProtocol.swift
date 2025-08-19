//
//  JailbreakDetectionServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


/// Protocol defining the interface for jailbreak detection services.
///
/// Implementing types provide a method to detect if the device is jailbroken.
public protocol JailbreakDetectionServiceProtocol {
    
    /// Checks whether the device is jailbroken.
    ///
    /// - Returns: `true` if jailbreak is detected; otherwise, `false`.
    func isJailbreakDetected() -> Bool
    
}
