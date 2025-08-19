//
//  JailbreakDetectionRootUserCheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Implementation

import Foundation


/// Service to detect jailbreak by verifying if the app is running with root privileges.
///
/// On a standard iOS device, apps do not run with root (UID 0) privileges.
/// If the current process UID is 0, it indicates a likely jailbreak.
public final class JailbreakDetectionRootUserCheckService: JailbreakDetectionRootUserCheckServiceProtocol {
    
    public init() {}
    
    /// Checks if the current process is running as root user (UID 0).
    ///
    /// - Returns: `true` if running as root, indicating possible jailbreak; otherwise, `false`.
    public func isJailbreakDetected() -> Bool {
        return getuid() == 0
    }
}
