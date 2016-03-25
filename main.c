#include <stdlib.h>
#include <inttypes.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <its.h>

static void
print_usage(void)
{
	printf("np -- number print\n");
	printf("usage: np IO number\n");
	printf("   I is the input base, one of the [b, o, d, x]\n");
	printf("   O is the output base, one of the [b, o, d, x]\n");
	printf("   base is one of the following:\n");
	printf("     b = binary\n");
	printf("     o = octal\n");
	printf("     d = decimal\n");
	printf("     x = hexadecimal\n");
	printf("e.g. \"np db 123\"\n");
}

static void
error(const char* message)
{
	fprintf(stderr, "ERROR: %s.\n", message);
	printf("Try -h for help.\n");
	exit(EXIT_FAILURE);
}

static int
parse_base(char b)
{
	if (b == 'b') return ITS_BASE_BIN;
	if (b == 'o') return ITS_BASE_OCT;
	if (b == 'd') return ITS_BASE_DEC;
	if (b == 'x') return ITS_BASE_HEX;

	return -1;
}

static int
base_head(int base)
{
	if (base == ITS_BASE_BIN) return 2;
	if (base == ITS_BASE_OCT) return 8;
	if (base == ITS_BASE_DEC) return 10;
	if (base == ITS_BASE_HEX) return 16;

	return 0;
}

int
main(int argc, char* argv[])
{
	intmax_t number;
	int in_base;
	int out_base;
	char* str;

	if (argc >= 2 && (strcmp(argv[1], "-h") == 0)) {
		print_usage();
		return EXIT_SUCCESS;
	}

	if (argc != 3)
		error("expected two arguments");

	if (strlen(argv[1]) != 2)
		error("wrong conversion scheme");

	in_base = parse_base(argv[1][0]);
	out_base = parse_base(argv[1][1]);

	if (in_base == -1)
		error("unsupported input base");

	if (out_base == -1)
		error("unsupported output base");

	errno = 0;
	number = strtoimax(argv[2], NULL, base_head(in_base));
	if (number == 0 && errno != 0) {
		perror("strtoimax");
		return EXIT_FAILURE;
	}

	str = its(&number,
	          ITS_SIZE_INTMAX,
	          ITS_SIGNED,
	          (uint32_t)out_base | ITS_PREFIX);
	printf("%s\n", str);
	free(str);
		
	return EXIT_SUCCESS;
}

