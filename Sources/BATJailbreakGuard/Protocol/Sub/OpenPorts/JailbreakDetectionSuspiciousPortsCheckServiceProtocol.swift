//
//  JailbreakDetectionOpenPortsCheckServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//



// MARK: - Protocol

/// Protocol for jailbreak detection by checking suspicious open ports.
///
/// Services conforming to this protocol detect jailbreak by monitoring TCP ports
/// on localhost (127.0.0.1) that are commonly opened by jailbreak tools, SSH backdoors, or debugging frameworks.
public protocol JailbreakDetectionSuspiciousPortsCheckServiceProtocol: JailbreakDetectionServiceProtocol {
    
    /// Adds custom ports to monitor in addition to the default suspicious ports.
    ///
    /// - Parameter ports: Array of port numbers to monitor.
    func addSuspiciousPorts(_ ports: [Int]) -> Void
    
    /// Clears all default suspicious ports, leaving only user-added ports if any.
    func clearSuspiciousPorts() -> Void
}
