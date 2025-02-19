(define (domain pacman)

(:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

(:types 
    posicao
)

(:predicates
    ; Predicados de Localização
    (pacman-em ?px ?py - posicao)
    (fantasmaR-em ?px ?py - posicao)
    (fantasmaG-em ?px ?py - posicao)
    (fantasmaB-em ?px ?py - posicao)
    (frutaR-em ?px ?py - posicao)
    (frutaG-em ?px ?py - posicao)
    (frutaB-em ?px ?py - posicao)
    (parede-em ?px ?py - posicao)

    ; Predicados de liberação
    (pacman-liberado)
    (fantasmaR-liberado)
    (fantasmaG-liberado)
    (fantasmaB-liberado)

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
    (checar-morto)
    

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
    (pacman-morto)
)


    (:action checagem-morto-pre
    :parameters (?px ?py - posicao)
    :precondition (and (checar-morto) (pacman-em ?px ?py))
    :effect (and
        (when
            (or
                (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
            )
            (pacman-morto)
        )
        (not(checar-morto))
        (fantasmaR-liberado)

    )
)


    (:action move-pacman-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (pacman-liberado) (pacman-em ?x ?y) (dec ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede-em ?x ?yn))
            )
            (and
                (not (pacman-em ?x ?y))
                (not(pacman-liberado))
                (pacman-em ?x ?yn)
                (fantasmaG-up)
                (fantasmaB-down)
                (checar-morto)
            )
        )
    )
)


    (:action move-pacman-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (pacman-liberado) (pacman-em ?x ?y) (inc ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede-em ?x ?yn))
            )

            (and
                (not (pacman-em ?x ?y))
                (not(pacman-liberado))

                (pacman-em ?x ?yn)
                (fantasmaB-up)
                (fantasmaG-down)
                (checar-morto)
            )
        )
    )
)

   
    (:action move-pacman-left
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (pacman-liberado) (pacman-em ?x ?y) (dec ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede-em ?xn ?y))
            )

            (and
                (not(pacman-em ?x ?y))
                (not(pacman-liberado))

                (pacman-em ?xn ?y)
                (fantasmaB-right)
                (fantasmaG-left)
                (checar-morto)
            )
        )
    )
)


    (:action move-pacman-right
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (pacman-liberado) (pacman-em ?x ?y) (inc ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede-em ?xn ?y))
            )

            (and
                (not(pacman-em ?x ?y))
                (not(pacman-liberado))

                (pacman-em ?xn ?y)
                (fantasmaB-left)
                (fantasmaG-right)
                (checar-morto)
            )
        )
    )
)





    (:action move-fantasmaG-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (not(fantasmaG-morto)) (fantasmaG-up) (dec ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede-em ?x ?yn))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?x ?yn)
                (not(fantasmaG-up))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                
            )
        )
    )
)


    (:action move-fantasmaG-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (not(fantasmaG-morto)) (fantasmaG-down) (inc ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede-em ?x ?yn))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?x ?yn)
                (not(fantasmaG-down))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                
            )
        )
    )
)


    (:action move-fantasmaG-left
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (not(fantasmaG-morto)) (fantasmaG-left) (dec ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede-em ?xn ?y))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?x ?xn)
                (not(fantasmaG-left))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                
            )
        )
    )
)


    (:action move-fantasmaG-right
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (not(fantasmaG-morto)) (fantasmaG-right) (inc ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede-em ?xn ?y))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?xn ?y)
                (not(fantasmaG-right))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                
            )
        )
    )
)



    (:action comer-fruta-Green
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (frutaG-em ?px ?py) (not(frutaR-ativa)) (not(frutaB-ativa)))
    :effect (and
    (not(frutaG-em ?px ?py))
    (frutaG-ativa))
    )


    (:action comer-fantasma-Green
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py) (frutaG-ativa))
    :effect (and (fantasmaG-morto) (not(frutaG-ativa)))
    )

)
