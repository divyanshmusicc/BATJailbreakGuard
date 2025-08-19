//
//  JailbreakDetectionSymbolicLinksCheckServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//



// MARK: - Protocol

/// Protocol for jailbreak detection via suspicious symbolic links.
///
/// Services conforming to this protocol detect jailbreak by checking
/// if **known suspicious file system paths** are symbolic links.
/// These symbolic links are typically **created by jailbreak tools** to redirect
/// system binaries or resources, and should not exist on a non-jailbroken device.
public protocol JailbreakDetectionSymbolicLinksCheckServiceProtocol: JailbreakDetectionServiceProtocol {
    
    /// Adds custom file paths to the symbolic link check list.
    ///
    /// - Parameter paths: An array of absolute file system paths to check.
    ///   These will be appended to the default suspicious paths.
    func addSuspiciousPaths(_ paths: [String])
    
    /// Removes all predefined suspicious symbolic link paths from the detection list.
    ///
    /// - Important: After calling this method, the service will only check
    ///   the **user-defined** paths added via `addSuspiciousPaths(_:)`.
    ///
    /// - Note: This is useful if you want to completely override the
    ///   built-in list and perform detection only on custom paths.
    func clearPaths()
}
