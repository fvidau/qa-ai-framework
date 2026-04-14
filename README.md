# QA AI Framework – Banking Systems

Framework conceptual para diseñar testing de APIs bancarias utilizando IA con enfoque en riesgo, negocio y consistencia de datos.

## Objetivo

Definir cómo un QA moderno puede utilizar IA no solo para generar test cases, sino para estructurar pensamiento de calidad en sistemas críticos.

## Problema

Los test cases generados por IA suelen ser:
- genéricos
- sin contexto de negocio
- sin priorización de riesgo

Este framework resuelve eso.

## Enfoque

- Risk-based testing (P0, P1, P2)
- Business-critical flows (money movement)
- Failure-oriented thinking
- Idempotency, concurrency y consistencia

## Estructura

- `rules/` → reglas de validación y comportamiento
- `commands/` → prompts reutilizables para generar test cases
- `agents/` → definición de cómo piensa un QA Analyst

## Ejemplo de uso

Generación de test cases para:

- transferencias bancarias
- validación de balances
- escenarios de concurrencia
- retry con idempotency key

## Valor

Este proyecto demuestra:

- pensamiento QA avanzado
- enfoque en sistemas reales (banca)
- uso estratégico de IA
- capacidad de modelar calidad, no solo ejecutarla