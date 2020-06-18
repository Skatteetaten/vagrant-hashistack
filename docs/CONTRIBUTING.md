# Contributing to vagrant-hashistack

### Bugs or inconsistencies
If you find a bug or something that does not work according to docs, please file an issue.
In case you spot a documentation error, or there is an addition you can make to help others; feel free to file a PR directly.

### Would you like to see a change or add a feature?
Please file an issue before creating a PR.
PRs are welcome if they are properly documented, including tests, and corresponds to the [main goal](../README.md) of this project.

### Where are versions for the different tools declared?
You may change the version of tools in this [file](../ansible/group_vars/all/variables.yml). Remember to update the [changelog](../CHANGELOG.md) and label the PR as a release (major/minor/patch).

### Release process
PRs labeled with minor, major, or patch will be built and tested if any of these codepaths are changed:

- `ansible/**`
- `packer/**`
- `vagrant/**`
- `test/**`

On successful merge, the build process will run again, now including a release job. 

The release job creates a suitable version based on the PR label, tags the repository and publishes the vagrant box on vagrant cloud.

#### Major, Minor or Patch?
We follow [semver](https://semver.org) when releasing a new version.
Following this logic we must consider how this vagrant box is _used_ in order to choose a release level.
