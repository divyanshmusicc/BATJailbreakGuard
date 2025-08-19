//
//  JailbreakDetectionPreventedAPICheckServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//

// MARK: - Protocol

//// Protocol for detecting jailbreaks by checking if restricted APIs are unexpectedly available.
///
/// Services conforming to this protocol detect jailbreak by monitoring APIs that should be
/// blocked in a non-jailbroken environment. These include process creation, shell execution,
/// and dynamic code injection APIs.
///
/// This provides an additional layer of jailbreak detection without executing dangerous functions.
///
/// ## Security Notes
/// - Prefer indirect symbol lookup to avoid crashes
/// - Combine with other detection methods (file, symlink, environment variable checks)
/// - Avoid private APIs that may cause App Store rejection
public protocol JailbreakDetectionPreventedAPICheckServiceProtocol: JailbreakDetectionServiceProtocol {
    
}
