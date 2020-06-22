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
Following this logic we must consider how this vagrant box is _used_ in order to choose a release level.

## Continuous Integration

This repository will run Github actions all on pull requests against `master`. For complete reference see [build.yml](../.github/workflows/build.yml)

### These steps will run _always_

- **linter:** Runs [super-linter](https://github.com/github/super-linter), ensuring code style checks ensuring consistency and code quality.
- **build:** Builds the vagrant box using packer
- **test:** Will run the newly built box with `make test`

### Additional steps will run when building _a release_

- **release-prerequisites:** If PR passes build- and test stages and is designated for release, this step sets up variables for `release`-stage
- **release:** Upload vagrant box to vagrant-cloud, release a version and tag release on github.
