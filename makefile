OS = Linux
SCRIPT_VERSION = 0.1

NAME = main
OUTPUT_DIR = output

LATEX = pdflatex 
LATEX_OPT = -file-line-error
BIB = bibtex
PDF_VIEWER = evince

LATEXMK = latexmk
LATEXMK_OPT = -output-directory=./$(OUTPUT_DIR)

.PHONY: clean all view

all : $(NAME).pdf

view: $(NAME).pdf
	$(PDF_VIEWER) $(NAME).pdf

$(NAME).pdf: $(OUTPUT_DIR)/$(NAME).pdf
	cp $(OUTPUT_DIR)/$(NAME).pdf .

$(OUTPUT_DIR)/$(NAME).pdf: $(OUTPUT_DIR)/$(NAME).aux $(OUTPUT_DIR)/$(NAME).bbl
	# %O are the options passed to latexmk 
	# %S is the source .tex file
	$(LATEXMK) -pdf $(LATEXMK_OPT) -pdflatex="$(LATEX) $(LATEX_OPT) %O %S" $(NAME)

$(OUTPUT_DIR)/$(NAME).bbl: $(OUTPUT_DIR)/$(NAME).aux
	$(BIB) $(OUTPUT_DIR)/$(NAME).aux

$(OUTPUT_DIR)/$(NAME).aux: $(NAME).tex 
	$(LATEXMK) $(LATEXMK_OPT) $(NAME)

clean:
	$(LATEXMK) -C $(NAME)
	rm -f $(OUTPUT_DIR)/*
	rm -f ./$(NAME).pdf
