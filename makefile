OS = Linux
SCRIPT_VERSION = 0.1

NAME = main
CHAPTER_DIR = chapters
OUTPUT_DIR = output

CHAPTERS = $(wildcard $(CHAPTER_DIR)/*.tex)
SOURCES=$(NAME).tex Makefile $(CHAPTERS) 

LATEX = pdflatex 
LATEX_OPT = -file-line-error -output-directory=./$(OUTPUT_DIR)
BIB = bibtex
PDF_VIEWER = evince

LATEXMK = latexmk
LATEXMK_OPT = -pdf


.PHONY: clean all view

all : $(OUTPUT_DIR)/$(NAME).pdf

view:
	$(PDF_VIEWER) $(NAME).pdf

$(OUTPUT_DIR)/$(NAME).pdf: $(NAME).tex 
	$(LATEXMK) $(LATEXMK_OPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(NAME)

clean:
	$(LATEXMK) -C $(NAME)
	rm -f $(MAIN).pdfsync
	rm -f $(OUTPUT_DIR)/*
