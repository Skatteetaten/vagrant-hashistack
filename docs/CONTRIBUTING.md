# Contributing to vagrant-hashistack

## Bugs or inconsistencies

If you find a bug or something that does not work according to docs, please file an issue.
In case you spot a documentation error, or there is an addition you can make to help others;
 feel free to file a PR directly.

## Would you like to see a change or add a feature?  

Please file an issue before creating a PR.
PRs are welcome if they are properly documented, including tests,
 and corresponds to the [main goal](../README.md) of this project.

## Where are versions for the different tools declared?  

You may change the version of tools in this [file](../ansible/group_vars/all/variables.yml).
 Remember to update the [changelog](../CHANGELOG.md) and label the PR as a release (major/minor/patch).

## Release process

PRs labeled with minor, major, or patch will be built and tested as a release candidate.
On successful merge, the build process will run again, now including a release job.
The release job creates a suitable version based on the PR label, tags the repository and publishes the vagrant box on
vagrant cloud. More information in subsequent CI chapter.

### Major, Minor or Patch?  

We follow [semver](https://semver.org) when releasing a new version.
Following this logic, we must consider how this vagrant box is _used_ in order to choose a release level.

### Bumping version of Hashistack

Bumping version of hashistack in [variables.yml](../ansible/group_vars/all/variables.yml) file, could introduce incompatibilities or breaking changes. We think that the best way
to control such a situation is by making a patch/minor release of _vagrant-hashistack_ after every version bump.
Whether such a release should be labeled as a patch or minor could be decided based on whether the bumped versions' indicate a patch or a minor release.

For example, bumping nomad from **0.11.3 -> 0.12.3**, should result in a **minor** release, however, bumping nomad from **0.12.3 -> 0.12.4** should be addressed via a **patch** release of _vagrant-hashistack_.


## Continuous Integration

This repository will run Github actions on all pull requests against `master`. For complete reference see [on_pr_master.yml](../.github/workflows/on_pr_master.yml)

### These steps will _always_ run

- **linter:** Runs [super-linter](https://github.com/github/super-linter), ensuring code style checks ensuring consistency and code quality.
- **build:** Builds the vagrant box using packer
- **test:** Will run the newly built box with `make test`

### Additional steps will run when building _a release_

- **release-prerequisites:** If PR passes build- and test stages and is designated for release, this step sets up variables for `release`-stage
- **release:** Upload vagrant box to vagrant-cloud, release a version and tag release on github.

### Linters
All PRs will run [super-linter](https://github.com/github/super-linter). Run `make lint` to check your code locally before creating a PR.
> :bulb: Information about rules can be found under [/.github/linters/](../.github/linters)

### Terraform formatting
You can run [`terraform fmt --recursive`](https://www.terraform.io/docs/commands/fmt.html) to rewrite your terraform config-files to a [canonical format](https://www.terraform.io/docs/configuration/style.html).
> :warning: [Terraform binary](https://www.terraform.io/downloads.html) must be available to do this.