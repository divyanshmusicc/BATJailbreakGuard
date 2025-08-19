//
//  JailbreakDetectionRootUserCheckServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Protocol

/// Protocol for detecting jailbreak by checking root user privileges.
///
/// Services conforming to this protocol detect jailbreak by verifying whether
/// the application process is running with root privileges. Running as root
/// is a strong indicator of a compromised device.
public protocol JailbreakDetectionRootUserCheckServiceProtocol: JailbreakDetectionServiceProtocol {
    // No additional methods required; detection is performed via isJailbreakDetected()
}
