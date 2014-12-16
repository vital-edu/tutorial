TARGET = TutorialNoosfero.pdf

BIBTEX = bibtex
LATEX = latex -shell-escape
DVIPS = dvips
PS2PDF = ps2pdf -dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode
-dPDFsettings=/prepress

VERSION = 0.1.0

FIXOS_DIR = fixos
FIXOS_SOURCES = informacoes.tex novosComandos.tex \
		pacotes.tex comandos.tex setup.tex	\
		indiceAutomatico.tex

FIXOS_FILES = $(addprefix $(FIXOS_DIR)/, $(FIXOS_SOURCES))

EDITAVEIS_DIR = editaveis
EDITAVEIS_SOURCES = informacoes.tex

EDITAVEIS_FILES = $(addprefix $(EDITAVEIS_DIR)/, $(EDITAVEIS_SOURCES))

MAIN_FILE = tutorialNoosfero.tex
DVI_FILE  = $(addsuffix .dvi, $(basename $(MAIN_FILE)))
AUX_FILE  = $(addsuffix .aux, $(basename $(MAIN_FILE)))
PS_FILE   = $(addsuffix .ps, $(basename $(MAIN_FILE)))
PDF_FILE  = $(addsuffix .pdf, $(basename $(MAIN_FILE)))

SOURCES = $(FIXOS_FILES) $(EDITAVEIS_FILES)

.PHONY: all clean dist-clean

all:
	@make clean $(TARGET) 
     
$(TARGET): $(MAIN_FILE) $(SOURCES) bibliografia.bib
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	$(BIBTEX) $(AUX_FILE)
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	$(DVIPS) $(DVI_FILE)
	$(PS2PDF) $(PS_FILE)
	@cp $(PDF_FILE) $(TARGET)

clean:
	rm -f *~ *.dvi *.ps *.backup *.aux *.log
	rm -f *.lof *.lot *.bbl *.blg *.brf *.toc *.idx
	rm -f *.pdf
	
dist: clean
	tar vczf tcc-fga-latex-$(VERSION).tar.gz *

dist-clean: clean
	rm -f $(PDF_FILE) $(TARGET)

configure:
	sudo apt-get install python
	sudo easy_install Pygments
