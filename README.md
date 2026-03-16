# Synnax

## Introduction

This is a `neovim` configuration striving for several things:

* Speed
* Simplicity
* Flexibility
* Personalization

it isn't meant to be used by people other than me and even
copying it with the intent of customizing it is probably the wrong
choice.

Double duty: this configuration comes in two "flavors": MINIMAL and DEV.
The MINIMAL flavor is really only meant to write simple text like markdown,
yaml, json and toml while the DEV flavor is meant for working within a
development environment (for python, nix, lua, etc. or even a mix).

## Objectives

### Speed

Specially in the MINIMAL flavor, the editor should start as fast as possible
since this flavor will be used for more ephemeral use cases (like writing
a git commit) or looking at a configuration file.

Speed is still very important for the DEV flavor, however it's measured
differently. In this flavor startup time is not as crucial as the editor
mainly remains open throughout coding sessions however response to actions
inside the editor should feel instantaneous.

### Simplicity

The goal is not to replicate all the features an IDE has, however it should
provide niceties that most modern editors have. In the DEV flavor the editor
provides more functionality that makes working with a certain dev platform or
language more straightforward.

Having a plethora of keyboard mappings, while seemingly impressive, will likely
cause most of them to be forgotten. In general most features should be discoverable
in some way.

### Flexibility

Specially in the DEV flavor, this editor configuration is meant to adapt
to different development platforms like python, lua, rust, nix, etc. or a mix
of them therefore it should be possible to include more dev tools as it
evolves over time.

The DEV flavor will mainly be run on macOS while the MINIMAL flavor may be
run on macOS and Linux.

### Personalization

This configuration is meant to satisfy my own needs and should not be taken
wholesale as a distribution for others to use or even as an example for
others to copy.
