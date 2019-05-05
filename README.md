# TLA+ CLI Template

This is a template project for writing specifications in TLA+ and PlusCal, and
doing model checking on the command line. If you prefer using a text editor
rather than the TLA+ Toolbox, this might be a useful starting point!

The project translates PlusCal and runs TLC using Make. Feel free to modify
the Makefile to suit your needs. I've tried making it flexible enough, though.

## Prerequitites

To use this example project you need the following installed:

* [tla-bin](https://github.com/pmer/tla-bin)

## File Structure

* _Specifications_ are stored in the `spec` directory. They can be named
whatever you like, but as usual with TLA+, the module name must match the file
name. In this template the example specification is
[spec/simple.tla](spec/simple.tla).
* _Models_ are stored in the `model` directory. The model names must begin with
the names of the specification _base names_, e.g. `simple` in this example
project. The optional middle segment is the model-specific name, e.g. `test1`
or `test2`. Finally there's the file extension `.cfg`.

The general naming scheme can be described in EBNF of as:

```ebnf
specification file name = module name, ".tla"
model file name = module name, [".", model name], ".cfg"
```

This naming scheme thus supports writing and checking multiple models for each
specification.

## Linting with SANY

To check for syntax and semantic errors using SANY, run:

To check all models, run:

```sh
make lint
```

## Model Checking

To check all models, run:

```sh
make check
```

If you want to model check a specification named `foo`, with a model named
`bar`, run:


```sh
make check-foo.bar

# for example with this project template you can run
make check-simple.test1
```

## License

Mozilla Public License Version 2.0

Copyright 2019 Oskar Wickström
