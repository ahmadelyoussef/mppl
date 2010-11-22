#include    "MiniLexer.h"
#include<iostream>
#include<string>
#include    "MiniParser.h"
int ANTLR3_CDECL main        (int argc, char *argv[])
{ 

    pANTLR3_UINT8            fName;

    pANTLR3_INPUT_STREAM    input;

    // The lexer is of course generated by ANTLR, and so the lexer type is not upper case.
    // The lexer is supplied with a pANTLR3_INPUT_STREAM from whence it consumes its
    // input and generates a token stream as output.
    //
    pMiniLexer                    lxr;

    pANTLR3_COMMON_TOKEN_STREAM            tstream;

    pMiniParser                                psr;

    // Create the input stream based upon the argument supplied to us on the command line
    // for this example, the input will always default to ./input if there is no explicit
    // argument.
    //
    if (argc < 2 || argv[1] == NULL)
    {
                fName        =(pANTLR3_UINT8)"./input.txt"; // Note in VS2005 debug, working directory must be configured
    }
    else
    {
                fName        = (pANTLR3_UINT8)argv[1];
    }

    input        = antlr3AsciiFileStreamNew(fName);

    if ( input == NULL)
    {
            fprintf(stderr, "Failed to open file %s\n", (char *)fName);
                exit(1);
        }


    lxr            = MiniLexerNew(input);
    //
    if ( lxr == NULL )
    {

            fprintf(stderr, "Unable to create the lexer due to malloc() failure1\n");
            exit(1);

    }


        tstream = antlr3CommonTokenStreamSourceNew(ANTLR3_SIZE_HINT, TOKENSOURCE(lxr));

    if (tstream == NULL)
    {
        fprintf(stderr, "Out of memory trying to allocate token stream\n");
        exit(1);
    }

    psr            = MiniParserNew(tstream);

    if (psr == NULL)
    {
        fprintf(stderr, "Out of memory trying to allocate parser\n");
        exit(ANTLR3_ERR_NOMEM);
    }

    psr->pStructure(psr);


    psr            ->free  (psr);            psr = NULL;
    tstream ->free  (tstream);            tstream = NULL;
    lxr            ->free  (lxr);            lxr = NULL;
    input   ->close (input);            input = NULL;

    return 0;
}