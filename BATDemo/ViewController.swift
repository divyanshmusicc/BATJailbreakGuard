import UIKit
import BATJailbreakGuard

final class ViewController: UIViewController {

    private let textView = UITextView()
    private let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        textView.isEditable = false
        textView.alwaysBounceVertical = true
        textView.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("RUN ALL CHECKS", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(runChecks), for: .touchUpInside)

        view.addSubview(textView)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])

        runChecks()
    }

    @objc private func runChecks() {
        var detected = 0
        var lines: [String] = []

        func add(_ name: String, _ isDetected: Bool, _ detail: String) {
            if isDetected { detected += 1 }
            let padded = name.padding(toLength: 20, withPad: " ", startingAt: 0)
            lines.append((isDetected ? "[DETECTED] " : "[clean]    ") + padded + " " + detail)
        }

        // 1 - FilePath (54 default paths)
        let filePath = JailbreakDetectionFilePathCheckService()
        add("1 FilePath", filePath.isJailbreakDetected(), "54 default paths")

        // 2 - SymbolicLinks (22 default paths)
        let symlinks = JailbreakDetectionSymbolicLinksCheckService()
        add("2 SymbolicLinks", symlinks.isJailbreakDetected(), "22 default paths")

        // 3 - EnvironmentVariables (18 default keys)
        let env = JailbreakDetectionEnvironmentVariableCheckService()
        add("3 EnvVariables", env.isJailbreakDetected(), "18 default keys")

        // 4 - DynamicLib (9 default names)
        let dynlib = JailbreakDetectionDynamicLibraryCheckService()
        add("4 DynamicLib", dynlib.isJailbreakDetected(), "9 default names")

        // 5 - SandboxedEnvironment (writes /private/jailbreak_test.txt)
        let sandbox = JailbreakDetectionSandboxedEnvironmentViolationService()
        add("5 SandboxWrite", sandbox.isJailbreakDetected(), "write /private/jailbreak_test.txt")

        // 6 - RootUser (getuid() == 0)
        let root = JailbreakDetectionRootUserCheckService()
        add("6 RootUser", root.isJailbreakDetected(), "getuid() == 0")

        // 7 - OpenPorts (default 27042 + 22)
        let ports = JailbreakDetectionSuspiciousPortsCheckService()
        add("7 OpenPorts", ports.isJailbreakDetected(), "default 27042, 22")

        // 8 - PreventedAPIs (dlsym RTLD_DEFAULT lookups)
        let apis = JailbreakDetectionPreventedAPICheckService()
        let systemOK = apis.isSystemPossible() ? "YES" : "no"
        let spawnOK = apis.isPosixSpawnPossible() ? "YES" : "no"
        let dyldOK = apis.isDyldInjectable() ? "YES" : "no"
        add("8 PreventedAPIs", apis.isJailbreakDetected(),
            "system:\(systemOK) posix_spawn:\(spawnOK) dlopen/dlsym:\(dyldOK)")

        // 9 - Checksum (empty by default -> no-op)
        let checksum = JailbreakDetectionChecksumCheckService()
        add("9 Checksum", checksum.isJailbreakDetected(), "no files configured (no-op)")

        lines.append("")
        lines.append("--- EXTRA PROBES (custom config, not part of defaults) ---")

        // X1 - custom ports (tooling ports)
        let ports2 = JailbreakDetectionSuspiciousPortsCheckService()
        ports2.clearSuspiciousPorts()
        ports2.addSuspiciousPorts([2222, 47123, 46952, 44, 14099])
        add("X1 Ports(custom)", ports2.isJailbreakDetected(), "2222, 47123, 46952, 44, 14099")

        // X2 - our own artifacts through their file API
        let fp2 = JailbreakDetectionFilePathCheckService()
        fp2.clearPaths()
        fp2.addSuspiciousPaths([
            "/var/jb",
            "/var/jb/usr/sbin/frida-server",
            "/var/jb/usr/lib/TweakInject/Phantom.dylib"
        ])
        add("X2 Paths(custom)", fp2.isJailbreakDetected(), "/var/jb, frida-server, Phantom.dylib")

        // X3 - symlink type on /var/jb (defaults still included)
        let sym2 = JailbreakDetectionSymbolicLinksCheckService()
        sym2.clearPaths()
        sym2.addSuspiciousPaths(["/var/jb"])
        add("X3 Symlink(custom)", sym2.isJailbreakDetected(), "lstat /var/jb")

        let header: String
        if detected == 0 {
            header = "RESULT: ALL CLEAN (0/12 detected)"
        } else {
            header = "RESULT: \(detected)/12 DETECTED JAILBREAK"
        }
        let stamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        let bundleID = Bundle.main.bundleIdentifier ?? "?"
        textView.text = "BATJailbreakGuard demo (\(stamp))\nbundle: \(bundleID)\n\n"
            + header + "\n\n" + lines.joined(separator: "\n")
    }
}
