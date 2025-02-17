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
        (fantasmaR-liberado
        (fantasmaR-right)
    )
)


    (:action move-pacman-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (pacman-liberado) (pacman-em ?x ?y) (dec ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede ?x ?yn))
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
                (not(parede ?x ?yn))
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
                (not(parede ?xn ?y))
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
                (not(parede ?xn ?y))
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



    (:action move-fantasmaR-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaR-em ?x ?y) (not(fantasmaR-morto)) (fantasmaR-liberado) (fantasmaR-up) (dec ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede ?x ?yn))
            )
            (and
                (not(fantasmaR-em ?x ?y))
                (fantasmaR-em ?x ?yn)
                (not(fantasmaR-up))
                (not(fantasmaR-liberado))
                (pacman-liberado)
                (checar-morto-pos)
            )
            (fantasmaR-right)
        )
    )
)


    (:action move-fantasmaR-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-down) (inc ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede ?x ?yn))
            )
            (and
                (not(fantasmaR-em ?x ?y))
                (fantasmaR-em ?x ?yn)
                (not(fantasmaR-down))
                (not(fantasmaR-liberado))
                (pacman-liberado)
                (checar-morto-pos)
            )
            (fantasmaR-left)
        )
    )
)


    (:action move-fantasmaR-left
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-left) (dec ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede ?x ?xn))
            )
            (and
                (not(fantasmaR-em ?x ?y))
                (fantasmaR-em ?x ?xn)
                (not(fantasmaR-left))
                (not(fantasmaR-liberado))
                (pacman-liberado)
                (checar-morto-pos)
            )
            (fantasmaR-up)
        )
    )
)


    (:action move-fantasmaR-right
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-right) (inc ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede ?xn ?y))
            )
            (and
                (not(fantasmaR-em ?x ?y))
                (fantasmaR-em ?xn ?y)
                (not(fantasmaR-right))
                (not(fantasmaR-liberado))
                (pacman-liberado)
                (checar-morto-pos)
            )
            (fantasmaR-down) 
        )
    )
)



    (:action move-fantasmaG-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (not(fantasmaG-morto)) (fantasmaG-up) (dec ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede ?x ?yn))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?x ?yn)
                (not(fantasmaG-up))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                (checar-morto-pos)
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
                (not(parede ?x ?yn))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?x ?yn)
                (not(fantasmaG-down))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                (checar-morto-pos)
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
                (not(parede ?xn ?y))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?x ?xn)
                (not(fantasmaG-left))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                (checar-morto-pos)
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
                (not(parede ?xn ?y))
            )
            (and
                (not(fantasmaG-em ?x ?y))
                (fantasmaG-em ?xn ?y)
                (not(fantasmaG-right))
                (not(fantasmaG-liberado))
                (pacman-liberado)
                (checar-morto-pos)
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
                (not(parede ?x ?yn))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?x ?yn)

                (not(fantasmaB-liberado))
                (not(fantasmaB-up))
                (pacman-liberado)
                (checar-morto-pos)
            )
        )
    )
)


    (:action move-fantasmaB-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (not(fantasmaB-morto)) (fantasmaB-down) (inc ?y ?yn))
    :effect (and
        (when
            (and
                (not(parede ?x ?yn))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?x ?yn)
                (not(fantasmaB-liberado))
                (not(fantasmaB-down))
                (pacman-liberado)
                (checar-morto-pos)
            )
        )
    )
)


    (:action move-fantasmaB-left
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (not(fantasmaB-morto)) (fantasmaB-left) (dec ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede ?xn ?y))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?xn ?y)
                (not(fantasmaB-liberado))
                (not(fantasmaB-left))
                (pacman-liberado)
                (checar-morto-pos)
            )
        )
    )
)


    (:action move-fantasmaB-right
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (not(fantasmaB-morto)) (fantasmaB-right) (inc ?x ?xn))
    :effect (and
        (when
            (and
                (not(parede ?xn ?y))
            )

            (and
                (not(fantasmaB-em ?x ?y))
                (fantasmaB-em ?xn ?y)
                (not(fantasmaB-liberado))
                (not(fantasmaB-right))
                (pacman-liberado)
                (checar-morto-pos)
            )
        )
    )
)


)
