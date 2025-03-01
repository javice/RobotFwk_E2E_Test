
# Makefile

# Variables
BINARY_NAME=Robot-Framework_E2E_Tests
# Colores para la salida en consola
CYAN=\033[0;36m
RESET=\033[0m


# Comandos
.PHONY: install test test_actions clean check 

all: install check test clean
	
install:
	@echo "$(CYAN)Instalando dependencias $(BINARY_NAME)$(RESET)"
	pip install -r requirements.txt

test:
	@echo "$(CYAN)Ejecutando pruebas $(BINARY_NAME)$(RESET)" 
	robot -r ./reports tests/avis_navigation.robot

test_actions:
	@echo "$(CYAN)Ejecutando pruebas MODO HEADLESS $(BINARY_NAME)$(RESET)" 
	HEADLESS=True robot -r ./reports tests/avis_navigation.robot

clean:
	@echo "$(CYAN)Limpiando $(BINARY_NAME)$(RESET)"
	rm -rf reports/

check:
	@echo "$(CYAN)Comprobando dependencias $(BINARY_NAME)$(RESET)"
	pip check
