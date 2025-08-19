//
//  JailbreakDetectionFilePathServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//

// MARK: - Protocol

/// Protocol defining a jailbreak detection service that checks for the presence of suspicious file paths on the device.
///
/// Services conforming to this protocol can detect potential jailbreaks by inspecting the file system for known
/// suspicious paths commonly created by jailbreak tools. The protocol supports dynamic management of these paths,
/// allowing additional custom paths to be added or the default paths to be cleared for specialized checks.
public protocol JailbreakDetectionFilePathCheckServiceProtocol: JailbreakDetectionServiceProtocol {
    
    /// Adds additional suspicious file paths to the detection list.
    ///
    /// This method allows users to provide custom file paths that should be
    /// checked during the jailbreak detection process. These paths will be
    /// combined with the default known suspicious paths.
    ///
    /// - Parameter paths: An array of string paths representing suspicious files or directories.
    func addSuspiciousPaths(_ paths: [String]) -> Void
    
    
    /// Removes all default suspicious file paths from the detection list.
    ///
    /// This method clears the predefined jailbreak detection paths, leaving only
    /// any paths that have been manually added via `addSuspiciousPaths(_:)`.
    ///
    /// **Important:**
    /// After calling this method, `isJailbreakDetected()` will only check
    /// the user-defined paths for jailbreak indicators.
    ///
    /// - Note: Use this method when you want to fully override the built-in
    ///   detection list and rely solely on custom paths provided at runtime.
    func clearPaths() -> Void
}
