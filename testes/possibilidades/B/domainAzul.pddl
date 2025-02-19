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
    (pacman-morto)
)


    (:action checagem-morto-pre
    :parameters (?px ?py - posicao)
    :precondition (and (checar-morto-pre) (pacman-em ?px ?py))
    :effect (and
        (when
            (or
                (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
            )
            (pacman-morto)
        )
        (not(checar-morto-pre))
        (fantasmaB-liberado)

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
                (checar-morto-pre)
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
                (checar-morto-pre)
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
                (checar-morto-pre)
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
                (checar-morto-pre)
            )
        )
    )
)



    (:action move-fantasmaB-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (not(fantasmaB-morto)) (fantasmaB-up) (dec ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede-em ?x ?yn))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?x ?yn)

                (not(fantasmaB-liberado))
                (not(fantasmaB-up))
                (pacman-liberado)
                
            )
        )
        (when (and (parede-em ?xn ?y)) 
            (and (not(fantasmaG-liberado)) (not(fantasmaG-up)) (checar-morto-pos))
        )
    )
)


    (:action move-fantasmaB-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (not(fantasmaB-morto)) (fantasmaB-down) (inc ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede-em ?x ?yn))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?x ?yn)
                (not(fantasmaB-liberado))
                (not(fantasmaB-down))
                (pacman-liberado)
                
            )
        )
        (when (and (parede-em ?xn ?y)) 
            (and (not(fantasmaG-liberado)) (not(fantasmaG-down)) (checar-morto-pos))
        )
    )
)


    (:action move-fantasmaB-left
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (not(fantasmaB-morto)) (fantasmaB-left) (dec ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede-em ?xn ?y))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?xn ?y)
                (not(fantasmaB-liberado))
                (not(fantasmaB-left))
                (pacman-liberado)
                
            )
        )
        (when (and (parede-em ?xn ?y)) 
            (and (not(fantasmaG-liberado)) (not(fantasmaG-left)) (checar-morto-pos))
        )
    )
)


    (:action move-fantasmaB-right
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (not(fantasmaB-morto)) (fantasmaB-right) (inc ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede-em ?xn ?y))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?xn ?y)
                (not(fantasmaB-liberado))
                (not(fantasmaB-right))
                (pacman-liberado)
                
            )
        )
        (when (and (parede-em ?xn ?y)) 
            (and (not(fantasmaG-liberado)) (not(fantasmaG-right)) (checar-morto-pos))
        )
    )
)



    (:action comer-fruta-Blue
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (frutaB-em ?px ?py) (not(frutaR-ativa)) (not(frutaG-ativa)))
    :effect (and
    (not(frutaB-em ?px ?py))
    (frutaB-ativa))
    )


    (:action comer-fantasma-Blue
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py) (frutaB-ativa))
    :effect (and (fantasmaB-morto) (not(frutaB-ativa)))
    )

)
