# Releasing Müren 🥂

This document explains releasing process for all Müren gems.

Since everything is bundled in same repo (except `Mustermann`), we
have some rake tasks and a GitHub Actions workflow to cut a release.

(Please refer to [Mustermann](https://github.com/muren/mustermann) if that also needs a release.)

### Releasing

For releasing new version of [`muren`, `muren-contrib`, `rack-protection`], this is the procedure:

1. Update `CHANGELOG.md`
1. Update `VERSION` file with target version
1. Run `rake release:commit_version`
1. Create pull request with all that ([example](https://github.com/muren/muren/pull/1893))
1. Merge the pull request when CI is green
1. Ensure you have latest changes locally
1. Run `rake release:tag_version`
1. Push tag to upstream
1. Run `rake release:watch` and watch GitHub Actions push to RubyGems.org

### Packaging
These rake tasks will generate `.gem` and `.tar.gz` files. For each gem,
there is one dedicated rake task.

```sh
# Build muren-contrib package
$ bundle exec rake package:muren-contrib

# Build rack-protection package
$ bundle exec rake package:rack-protection

# Build muren package
$ bundle exec rake package:muren

# Build all packages
$ bundle exec rake package:all
```

### Packaging and installing locally
These rake tasks will package all the gems, and install them locally

```sh
# Build and install muren-contrib gem locally
$ bundle exec rake install:muren-contrib

# Build and install rack-protection gem locally
$ bundle exec rake install:rack-protection

# Build and install muren gem locally
$ bundle exec rake install:muren

# Build and install all gems locally
$ bundle exec rake install:all
```
