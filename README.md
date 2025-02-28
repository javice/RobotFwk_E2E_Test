# Avis Robot Framework Test

![Robot Framework](https://img.shields.io/badge/robot--framework-6.1.1-green)

Este proyecto utiliza Robot Framework para pruebas automatizadas con SeleniumLibrary y WebDriver Manager.

## Requisitos

- Python 3.x
- Robot Framework
- SeleniumLibrary
- WebDriver Manager

## Instalación

```sh
pip install -r requirements.txt
```

## Ejecución de pruebas

```sh
 robot -r ./reports tests/avis_navigation.robot
```

### Estructura del proyecto

```
Avis_RobotFwk_Test
├── .idea: Configuración del proyecto para el IDE.
├── resources/ : Contiene recursos reutilizables para las pruebas. Siguiendo POM (Page Object Model)
|   └── AvisPage.robot: Archivo de recursos para la página de Avis.
├── requirements.txt : Dependencias del proyecto.
├── reports/ : Contiene los reportes generados por las pruebas.
|   └── log.html
└── tests/ : Contiene los archivos de prueba.
    └── avis_navigation.robot: Pruebas de navegación de Avis.
```

### Contribuir

1.- Haz un fork del repositorio.
2.- Crea una nueva rama (git checkout -b feature/nueva-funcionalidad).
3.- Realiza tus cambios y haz commit (git commit -am 'Añadir nueva funcionalidad').
4.- Haz push a la rama (git push origin feature/nueva-funcionalidad).
5.- Abre un Pull Request.

### Licencia

Este proyecto está bajo la Licencia MIT. Para obtener más información, consulta el archivo LICENSE.
