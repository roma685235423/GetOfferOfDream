import ProjectDescription

extension Project {

    public static func feature(
        name: String,
        packages: [Package],
        dependencies: [TargetDependency]
    ) -> Self {
        Self(
            name: name,
            packages: packages,
            targets: [
                Target.target(
                    name: name,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "roman.boiko.\(name)",
                    deploymentTargets: .iOS("15.0"),
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}
