//
//  JailbreakDetectionSandboxedEnvironmentViolationService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


import Foundation

/// Service responsible for detecting jailbreak by attempting to write a file outside the sandbox.
///
/// On a non-jailbroken device, writing outside the app sandbox is prohibited by iOS security.
/// If this write succeeds, it indicates a sandbox violation, which is a strong indicator of a jailbroken device.
///
/// Conforms to `JailbreakDetectionSandboxedEnvironmentViolationServiceProtocol`.
public final class JailbreakDetectionSandboxedEnvironmentViolationService: JailbreakDetectionSandboxedEnvironmentViolationServiceProtocol {
    
    /// File path used for the sandbox violation test.
    ///
    /// By default, a file is attempted to be written at `/private/jailbreak_test.txt`,
    /// which is outside the normal app sandbox.
    private var _testPath: String = "/private/jailbreak_test.txt"
    
    public init() {}
    
    /// Attempts to write a file to the test path. If successful, jailbreak is detected.
    ///
    /// - Returns: `true` if writing outside the sandbox succeeded; otherwise, `false`.
    public func isJailbreakDetected() -> Bool {
        let testPath = self._testPath
        do {
            try "jailbreak_sandboxed_environment_violation_test".write(toFile: testPath, atomically: true, encoding: .utf8)
            // Cleanup after test
            try FileManager.default.removeItem(atPath: testPath)
            return true
        } catch {
            return false
        }
    }
    
    /// Sets the file path to use for the sandbox violation write test.
    ///
    /// This allows users to customize where the test writes a file. The path should
    /// be outside the app sandbox to effectively detect sandbox violations.
    ///
    /// - Parameter path: A file path outside the sandbox to test write permission.
    public func changeTestPath(_ path: String) -> Void {
        self._testPath = path
    }
}
