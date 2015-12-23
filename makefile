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
LATEXMK_OPT = -pdf -output-directory=./$(OUTPUT_DIR)


.PHONY: clean all view

all : $(NAME).pdf

view: $(NAME).pdf
	$(PDF_VIEWER) $(NAME).pdf

$(NAME).pdf: $(OUTPUT_DIR)/$(NAME).pdf
	cp $(OUTPUT_DIR)/$(NAME).pdf .

$(OUTPUT_DIR)/$(NAME).pdf: $(NAME).tex 
	$(LATEXMK) $(LATEXMK_OPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(NAME)

clean:
	$(LATEXMK) -C $(NAME)
	rm -f $(OUTPUT_DIR)/*
	rm -f ./$(NAME).pdf
