
# Makefile

# Variables

# Colores para la salida en consola
CYAN=\033[0;36m
RESET=\033[0m


# Comandos
.PHONY: install test clean check distcheck

all: install check distcheck test clean
	
install:
	@echo "$(CYAN)Instalando dependencias $(BINARY_NAME)$(RESET)"
	pip install -r requirements.txt

test:
	@echo "$(CYAN)Ejecutando pruebas $(BINARY_NAME)$(RESET)" 
	robot -r ./reports tests/avis_navigation.robot

clean:
	@echo "$(CYAN)Limpiando $(BINARY_NAME)$(RESET)"
	rm -rf reports/

check:
	@echo "$(CYAN)Comprobando dependencias $(BINARY_NAME)$(RESET)"
	pip check

distcheck:
	@echo "$(CYAN)Comprobando distribución $(BINARY_NAME)$(RESET)"
	python setup.py check --restructuredtext