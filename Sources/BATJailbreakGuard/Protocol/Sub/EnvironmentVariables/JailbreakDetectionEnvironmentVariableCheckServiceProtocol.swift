//
//  JailbreakDetectionEnvironmentVariableCheckServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Protocol

/// Protocol for detecting jailbreak via environment variables.
///
/// Services conforming to this protocol check the process environment
/// for known keys that are typically set by jailbreak tools, tweaks,
/// or injected daemons. Presence of any of these keys indicates
/// that the device is likely jailbroken.
///
/// All default keys used by conforming services should only exist on
/// jailbroken devices.
public protocol JailbreakDetectionEnvironmentVariableCheckServiceProtocol: JailbreakDetectionServiceProtocol {
    
    /// Adds custom environment variable keys to the detection list.
    ///
    /// These keys will be checked in addition to the default known
    /// suspicious keys.
    ///
    /// - Parameter keys: An array of environment variable keys to add.
    func addSuspiciousEnvironmentVariables(_ keys: [String])
    
    /// Clears all default suspicious environment variable keys.
    ///
    /// After calling this method, only user-added keys will be checked.
    ///
    /// **Important:** Use this if you want to fully override the built-in
    /// detection keys and rely solely on custom keys provided at runtime.
    func clearEnvironmentVariables() -> Void
}
