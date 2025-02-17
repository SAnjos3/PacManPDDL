;Header and description

(define (domain domainVerde)

(:requirements :strips :typing :conditional-effects :negative-preconditions )

(:types 
    posicao
)


(:predicates
    ; Predicados de Direção do Fantasma Azul:
    (fantasmaB-up)
    (fantasmaB-right)
    (fantasmaB-down)
    (fantasmaB-left)

    ; Predicados de Direção do Fantasma Verde:
    (fantasmaG-up)
    (fantasmaG-right)
    (fantasmaG-down)
    (fantasmaG-left)

    ; Predicados de Direção do Fantasma Vermelho:
    (fantasmaR-up)
    (fantasmaR-right)
    (fantasmaR-down)
    (fantasmaR-left)

    ; Predicados de Checagem de Morte:
    (checar-morto-pre)
    (checar-morto-pos)

    ; Predicados de Incremento/Decremento:
    (inc ?x ?xn)
    (dec ?x ?xn)

    ; Predicados frutas:
    (frutaR-ativa)
    (frutaG-ativa)
    (frutaB-ativa)

    ; Predicados de finalização
    (fantasmaR-morto)
    (fantasmaG-morto)
    (fantasmaB-morto)


)


)