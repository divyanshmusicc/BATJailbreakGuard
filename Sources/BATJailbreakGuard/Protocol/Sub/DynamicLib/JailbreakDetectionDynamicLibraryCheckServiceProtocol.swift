//
//  JailbreakDetectionDynamicLibraryCheckServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Protocol

/// Protocol for jailbreak detection by inspecting loaded dynamic libraries.
///
/// Services conforming to this protocol detect jailbreak by checking
/// if known suspicious dynamic libraries are loaded in the current process.
/// Injected libraries are commonly used by jailbreak tools or tweaks to
/// modify system behavior, bypass security, or hook system APIs.
public protocol JailbreakDetectionDynamicLibraryCheckServiceProtocol: JailbreakDetectionServiceProtocol {
    
    /// Adds custom suspicious dynamic library names to check.
    ///
    /// - Parameter libraries: Array of library name substrings to detect.
    func addSuspiciousLibraries(_ libraries: [String])
    
    /// Clears all default suspicious dynamic library names from the detection list.
    ///
    /// **Important:**
    /// After calling this method, `isJailbreakDetected()` will only check
    /// the user-defined libraries for jailbreak indicators.
    func clearSuspiciousLibraries() -> Void
}
