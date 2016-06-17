OS = Linux
SCRIPT_VERSION = 0.1

NAME = main
ARTICLE = g3_article
ARTICLE_SRC_DIR = g3_article
OUTPUT_DIR = output
ARTICLE_FIGURE_DIR = $(ARTICLE_SRC_DIR)/figures
ARTICLE_FIGURES = $(wildcard $(ARTICLE_FIGURE_DIR)/*.tex)
ARTICLE_TABLE_DIR = $(ARTICLE_SRC_DIR)/tables
ARTICLE_TABLES = $(wildcard $(ARTICLE_TABLE_DIR)/*.tex)

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

articleview: $(OUTPUT_DIR)/$(ARTICLE).pdf
	$(PDF_VIEWER) $(OUTPUT_DIR)/$(ARTICLE).pdf

# Thesis Paper #

$(NAME).pdf: $(OUTPUT_DIR)/$(NAME).pdf
	cp $(OUTPUT_DIR)/$(NAME).pdf .

$(OUTPUT_DIR)/$(NAME).pdf: $(OUTPUT_DIR)/$(NAME).aux $(OUTPUT_DIR)/$(NAME).bbl $(OUTPUT_DIR)/$(ARTICLE).pdf
	# %O are the options passed to latexmk 
	# %S is the source .tex file
	$(LATEXMK) -pdf $(LATEXMK_OPT) -pdflatex="$(LATEX) $(LATEX_OPT) %O %S" $(NAME)

$(OUTPUT_DIR)/$(NAME).aux: $(NAME).tex 
	$(LATEXMK) $(LATEXMK_OPT) $(NAME)

# Article #

$(OUTPUT_DIR)/$(ARTICLE).pdf: $(ARTICLE_SRC_DIR)/$(ARTICLE).tex $(OUTPUT_DIR)/$(ARTICLE).bbl $(ARTICLE_FIGURES) $(ARTICLE_TABLES)
	# %O are the options passed to latexmk
	# %S is the source .tex file
	$(LATEXMK) -pdf $(LATEXMK_OPT) -pdflatex="$(LATEX) $(LATEX_OPT) %O %S" $(ARTICLE_SRC_DIR)/$(ARTICLE)

# Utility #

$(OUTPUT_DIR)/$(ARTICLE).bbl: $(OUTPUT_DIR)/$(NAME).bbl
	cp $(OUTPUT_DIR)/$(NAME).bbl $(OUTPUT_DIR)/$(ARTICLE).bbl

$(OUTPUT_DIR)/$(NAME).bbl: $(OUTPUT_DIR)/$(NAME).aux
	$(BIB) $(OUTPUT_DIR)/$(NAME).aux


clean:
	$(LATEXMK) -C $(NAME)
	rm -f $(OUTPUT_DIR)/*
	rm -f ./$(NAME).pdf


