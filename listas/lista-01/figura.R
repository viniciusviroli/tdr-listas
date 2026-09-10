#!/usr/bin/env Rscript

# Exercício 3 — Lista 01
# Gera figura.pdf com a variável Temp ao longo dos meses

library(ggplot2)

# Lê o arquivo CSV
dados <- read.csv("airquality.csv")

# Gráfico da variável Temp ao longo dos meses
p <- ggplot(dados, aes(x = factor(Month), y = Temp)) +
  geom_boxplot(fill = "steelblue", alpha = 0.7) +
  labs(
    x = "Mês",
    y = "Temperatura",
    title = "Temperatura ao longo dos meses"
  )

# Salva o gráfico
ggsave("figura.pdf", plot = p, width = 7, height = 5)
