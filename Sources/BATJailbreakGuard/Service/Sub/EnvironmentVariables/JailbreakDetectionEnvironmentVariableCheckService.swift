//
//  JailbreakDetectionEnvironmentVariableCheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//



// MARK: - Implementation

import Foundation

/// Service responsible for detecting jailbreak via environment variables.
///
/// On jailbroken devices, certain environment variables are often set by
/// jailbreak tools, tweaks, or injected processes. These include dynamic linker
/// overrides, Cydia markers, SSH connection variables, and others.
///
/// This service inspects the process's environment for these keys. If any of the
/// known keys are present and non-empty, it is a strong indicator that the device
/// is jailbroken.
///
/// Conforms to `JailbreakDetectionEnvironmentVariableCheckServiceProtocol`.
public final class JailbreakDetectionEnvironmentVariableCheckService: JailbreakDetectionEnvironmentVariableCheckServiceProtocol {
    
    /// Default known suspicious environment variable keys
    ///
    /// Only exists on jailbroken devices
    private var _defaultSuspiciousVariables: [String] = [
        "DYLD_INSERT_LIBRARIES",
        "LD_PRELOAD",
        "CYDIA_SUBSTRATE_VERSION",
        "SUBSTITUTE",
        "CYDIA",
        "TWEAKS",
        "HOOKS",
        "FRIDA",
        "MOBILE_SUBSTRATE",
        "SSH_CLIENT",
        "SSH_TTY",
        "XPC_SERVICE_NAME",
        "SUDO_USER",
        "BOOTSTRAPDIR",
        "INJECTED",
        "DYLD_FRAMEWORK_PATH",
        "DYLD_LIBRARY_PATH",
        "CYDIA_INJECTED"
    ]
    
    /// User-added environment variable keys
    private var _userAddedVariables: [String] = []
    
    public init() {}
    
    /// Checks if any suspicious environment variables are present.
    ///
    /// Combines default and user-added keys. Returns `true` if any key exists
    /// in the process environment with a non-empty value.
    ///
    /// - Returns: `true` if suspicious environment variables are detected.
    public func isJailbreakDetected() -> Bool {
        let allKeys = self._defaultSuspiciousVariables + self._userAddedVariables
         
         for key in allKeys {
             
             if let value = ProcessInfo.processInfo.environment[key], !value.isEmpty {
                 // Only mark as suspicious if it contains a known jailbreak marker
                 let lowerValue = value.lowercased()
                 if lowerValue.contains("substrate") ||
                    lowerValue.contains("frida") ||
                    lowerValue.contains("cydia") ||
                    lowerValue.contains("bootstrap") {
                     return true
                 }
             }
         }
        
        return false
    }
    
    /// Adds custom environment variable keys to check.
    ///
    /// - Parameter keys: Array of environment variable keys to check in addition
    ///   to the defaults.
    public func addSuspiciousEnvironmentVariables(_ keys: [String]) {
        self._userAddedVariables.append(contentsOf: keys)
    }
    
    /// Clears all default suspicious environment variables.
    ///
    /// After calling this, only user-added keys are checked.
    public func clearEnvironmentVariables() -> Void {
        self._defaultSuspiciousVariables.removeAll()
    }
}


