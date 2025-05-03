---

# 🌿 Macetech C4 + DDD Architecture

Este repositorio contiene el modelo de arquitectura de la plataforma **Macetech**, una solución IoT para jardinería inteligente, modelada usando el enfoque **C4 Model** junto con **Domain-Driven Design (DDD)**.
El diseño está expresado en **Structurizr DSL**, con vistas para visualización en herramientas como Structurizr Lite o el CLI.

---

## 🧠 ¿Qué es Macetech?

Macetech es una plataforma de jardinería automatizada compuesta por:

* Macetas inteligentes con sensores y actuadores.
* Aplicaciones web y móviles para usuarios domésticos y expertos.
* Algoritmos de recomendación personalizados basados en IA.
* Arquitectura orientada a dominios (DDD) y despliegue en el borde (Edge Computing).

---

## 📐 ¿Qué contiene este repositorio?

* `macetech.dsl`: Modelo completo en Structurizr DSL
* Diagramas:

  * System Context
  * Container
  * Componentes de apps web, móvil, edge y embebida
  * Monolito dividido en Bounded Contexts
* Clasificación de Bounded Contexts: Core, Support y Commodity
* Relación con servicios externos como Gemini API
* Estilo visual personalizado para los diferentes tipos de elementos

---

## 🛠 Cómo visualizar los diagramas

### Opción 1: Usar Structurizr Lite (recomendado)

1. Descarga Structurizr Lite desde: [https://github.com/structurizr/lite/releases](https://github.com/structurizr/lite/releases)

2. Coloca el archivo `macetech.dsl` dentro de la carpeta `workspace`

3. Ejecuta en consola:

   java -jar structurizr-lite.jar

4. Abre tu navegador en:
   [http://localhost:8080](http://localhost:8080)

---

### Opción 2: Usar Structurizr CLI

1. Instala Java y descarga el CLI desde: [https://github.com/structurizr/cli](https://github.com/structurizr/cli)

2. Ejecuta para exportar como PlantUML:

   structurizr export -workspace macetech.dsl -format plantuml

3. Renderiza los diagramas generados usando cualquier herramienta compatible con PlantUML.

---

## 📚 Recursos usados

* C4 Model — [https://c4model.com](https://c4model.com)
* Structurizr DSL — [https://github.com/structurizr/dsl](https://github.com/structurizr/dsl)
* Domain-Driven Design — [https://dddcommunity.org/](https://dddcommunity.org/)
* PlantUML C4 Extension — [https://github.com/plantuml-stdlib/C4-PlantUML](https://github.com/plantuml-stdlib/C4-PlantUML)

---

## ✍️ Autor

Desarrollado como parte de la plataforma **Macetech – Smart Gardening Platform**.
Diseñado y modelado con enfoque estratégico en DDD y C4 para facilitar su evolución, comunicación y mantenimiento.

---