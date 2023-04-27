# Tuist SwiftLint plugin

A plugin that extends [Tuist](https://github.com/tuist/tuist) with [SwiftLint](https://github.com/realm/SwiftLint) functionalities.

## Install

In order to tell Tuist you'd like to use SwiftLint plugin in your project follow the instructions that are described in [Tuist documentation](https://docs.tuist.io/plugins/using-plugins).

## Usage

The plugin provides a command for linting the Swift code of your projects by leveraging [SwiftLint](https://github.com/realm/SwiftLint). All you need to do is run the following command:

```
tuist lint
```
You can lint selected files by specifing their path: 
```
tuist lint file_1 file_2 
```

You can lint selected tuist target by specifing its name (Graph have to be generated -> run tuist graph):

```
tuist lint -t MyTarget
```

### Arguments

| Argument   | Short  | Description  | Default  | Required  |
|:-:|:-:|:-:|:-:|:-:|
| `--target`  | `-t`  | Tuist target name to be linted
| `--strict`  | `-s`  | Upgrades warnings to serious violations (errors). | No  | No  |

