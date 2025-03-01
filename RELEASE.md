# Versión 1.0.0

[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://semver.org/)
[![Robot Framework](https://img.shields.io/badge/Robot%20Framework-4.0-blue.svg)](https://robotframework.org/)
[![SeleniumLibrary](https://img.shields.io/badge/SeleniumLibrary-4.4.0-blue.svg)](https://github.com/robotframework/SeleniumLibrary)
[![Python](https://img.shields.io/badge/Python-3.9-blue.svg)](https://www.python.org/)
[![Chrome](https://img.shields.io/badge/Chrome-90.0.4430.212-blue.svg)](https://www.google.com/chrome/)
[![WebDriver Manager](https://img.shields.io/badge/WebDriver%20Manager-3.4.2-blue.svg)](https://github.com/SergeyPirogov/webdriver_manager)

## Resumen

Esta es la primera versión estable del proyecto Avis Robot Framework Test. Se han implementado pruebas automatizadas para la navegación en la página de Avis utilizando Robot Framework y SeleniumLibrary.

## Tecnologías utilizadas

* [Robot Framework](https://robotframework.org/)
* [SeleniumLibrary](https://github.com/robotframework/SeleniumLibrary)
* [Python](https://www.python.org/)
* [Chrome](https://www.google.com/chrome/)
* [WebDriver Manager](https://github.com/SergeyPirogov/webdriver_manager)

## Nuevas características

* Pruebas automatizadas para la navegación en la página de Avis
* Utilización de Robot Framework y SeleniumLibrary para la automatización
* Configuración de un entorno de pruebas con Chrome y WebDriver Manager

## Mejoras

* Se ha implementado un sistema de logging para registrar los resultados de las pruebas
* Se ha agregado un archivo `README.md` con información sobre el proyecto y su configuración

## Correcciones de errores

* No se han reportado errores críticos en esta versión
* Se ejecitan las pruebas con el navegador Chrome en modo headless.

## Cambios importantes

* Se ha utilizado un patrón de versionado semántico para la versión del proyecto
* Se ha agregado un archivo `RELEASE.md` para documentar los cambios y mejoras en cada versión

## Notas de actualización

* Para actualizar a esta versión, simplemente clona el repositorio y ejecuta las pruebas con el comando `robot -r ./reports tests/avis_navigation.robot
