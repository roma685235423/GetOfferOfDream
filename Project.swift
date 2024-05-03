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

let target = Target.target(
    name: "GetOfferOfDream",
    destinations: .iOS,
    product: .app,
    bundleId: "roman.boiko.GetOfferOfDream",
    deploymentTargets: .iOS("15.0"),
    infoPlist: "GetOfferOfDream/Info.plist",
    sources: ["GetOfferOfDream/Sources/**"],
    resources: ["GetOfferOfDream/Resources/**"],
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
    name: "GetOfferOfDream",
    packages: [
        .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.11.0"))
    ],
    settings: Settings.settings(
        base: SettingsDictionary().setProjectVersions(),
        defaultSettings: .recommended
    ),
    targets: [target]
)
