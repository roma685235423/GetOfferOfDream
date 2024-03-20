import ProjectDescription

let swiftLintScript = """
if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which swiftlint >/dev/null; then
  swiftlint --fix --format
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
"""

let target = Target(
    name: "getOfferOfDream",
    platform: .iOS,
    product: .app,
    bundleId: "roman.boiko.getOfferOfDream",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
    infoPlist: "getOfferOfDream/Info.plist",
    sources: ["getOfferOfDream/Sources/**"],
    resources: ["getOfferOfDream/Resources/**"],
    scripts: [TargetScript.post(script: swiftLintScript, name: "swiftLintScript")],
    dependencies: [
        .project(target: "GetOfferCore", path: "GetOfferCore"),
        .project(target: "GetOfferDI", path: "GetOfferDI"),
        .project(target: "GetOfferNetwork", path: "GetOfferNetwork"),
        .project(target: "GetOfferUI", path: "GetOfferUI")
    ]
)

extension SettingsDictionary {
    func setProjectVersions() -> SettingsDictionary {
        let currentProjectVersion = "1"
        let markettingVersion = "1.0"
        return appleGenericVersioningSystem().merging([
            "CURRENT_PROJECT_VERSION": SettingValue(stringLiteral: currentProjectVersion),
            "MARKETING_VERSION": SettingValue(stringLiteral: markettingVersion)
        ])
    }
}

let project = Project(
    name: "getOfferOfDream",
    settings: Settings.settings(
        base: SettingsDictionary().setProjectVersions(),
        defaultSettings: .recommended
    ),
    targets: [target]
)
