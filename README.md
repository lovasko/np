# np
A command-line utility that converts simple integers between various bases.

## Usage
The first argument to the utility defines the schema of the conversion. The
two-letter description is composed of input and output bases. To denote a base,
one of the following characters has to be used:
 * `b` for the binary base
 * `o` for the octal base
 * `d` for the decimal base
 * `x` for the hexadecimal base

Following the conversion schema, the actual number is expected. The integer has
to fit into the `intmax_t` type.

## Example
Convert decimal number `123` to the hexadecimal base:
```sh
$ np dx 123
0x7b
```

Convert hexadecimal number `0x555` to the binary base:
```sh
$ np xb 555
0b10101010101
```

## Build & install
```
$ make
$ sudo mv ./np /usr/bin
```

## Dependencies
 * [libits](https://github.com/lovasko/libits)

## License
2-clause BSD license. For more information please consult the
[LICENSE](LICENSE.md) file. In the case that you need a different license, feel
free to contact me.

## Author
Daniel Lovasko (daniel.lovasko@gmail.com)

