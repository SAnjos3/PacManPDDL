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
        (frutaR-em ?px ?py - posicao)
        (frutaG-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)

        ; Predicados de liberação
        (pacman-liberado)
        (fantasmaR-liberado)
        (fantasmaG-liberado)

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

        ; Predicados de finalização
        (fantasmaR-morto)
        (fantasmaG-morto)
        (pacman-morto)
    )
    ;-----------------------------------------Checagem-------------------------------------------------------
    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pre) (pacman-em ?px ?py))
        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                )
                (pacman-morto)
            )
            (not(checar-morto-pre))
            (fantasmaR-liberado)
            (when
                (and (pacman-em ?px ?py) (frutaR-em ?px ?py))
                (and (frutaR-ativa) (not(frutaG-ativa)) (not(frutaR-em ?px ?py))))
            (when
                (and (pacman-em ?px ?py) (frutaG-em ?px ?py))
                (and (frutaG-ativa) (not(frutaR-ativa)) (not(frutaG-em ?px ?py))))
        )
    )

    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pos)(pacman-em ?px ?py))
        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                )
                (pacman-morto)
            )
            (not(checar-morto-pos))
            (pacman-liberado)
        )
    )
    ;-------------------------------------------Pacman------------------------------------------------------
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
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?x ?yn))
                (and
                    (not(pacman-liberado))

                    (pacman-em ?x ?y)
                    (fantasmaG-up)
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
                    (fantasmaG-down)
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?x ?yn))
                (and
                    (not(pacman-liberado))

                    (pacman-em ?x ?y)
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
                    (fantasmaG-left)
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?xn ?y))
                (and
                    (not(pacman-liberado))

                    (pacman-em ?x ?y)
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
                    (fantasmaG-right)
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?xn ?y))
                (and
                    (not(pacman-liberado))

                    (pacman-em ?x ?y)
                    (fantasmaG-right)
                    (checar-morto-pre)
                )
            )
        )
    )

    ;-------------------------------------------------FantasmaRed----------------------------------------------

    (:action move-fantasmaR-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (not(fantasmaR-morto)) (fantasmaR-liberado) (fantasmaR-up) (dec ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)
                    (not(fantasmaR-liberado))
                    (fantasmaG-liberado)
                )
            )
            (when
                (parede-em ?x ?yn)
                (and
                    (not(fantasmaR-up))
                    (fantasmaR-right)
                )
            )
            (when
                (and(fantasmaG-morto)
                    (not(parede-em ?x ?yn)))
                (and(checar-morto-pos))
            )
        )
    )

    (:action move-fantasmaR-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-down) (inc ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)
                    (not(fantasmaR-liberado))
                    (fantasmaG-liberado)
                )
            )
            (when
                (parede-em ?x ?yn)
                (and
                    (not(fantasmaR-down))
                    (fantasmaR-left)
                )
            )
            (when
                (and(fantasmaG-morto)
                    (not(parede-em ?x ?yn)))
                (and(checar-morto-pos))
            )
        )
    )

    (:action move-fantasmaR-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-left) (dec ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?xn ?y))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?xn ?y)
                    (not(fantasmaR-liberado))
                    (fantasmaG-liberado)
                )
            )
            (when
                (parede-em ?xn ?y)
                (and
                    (not(fantasmaR-left))
                    (fantasmaR-up)
                )
            )
            (when
                (and(fantasmaG-morto)
                    (not(parede-em ?xn ?y)))
                (and(checar-morto-pos))
            )
        )
    )

    (:action move-fantasmaR-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-right) (inc ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?xn ?y))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?xn ?y)
                    (not(fantasmaR-liberado))
                    (fantasmaG-liberado)
                )
            )
            (when
                (parede-em ?xn ?y)
                (and
                    (not(fantasmaR-right))
                    (fantasmaR-down)
                )
            )
            (when
                (and(fantasmaG-morto)
                    (not(parede-em ?xn ?y)))
                (and(checar-morto-pos))
            )
        )
    )
    ;-------------------------------------------------FantasmaGreen---------------------------------------------
    (:action move-fantasmaG-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaG-em ?x ?y) (or (fantasmaG-liberado) (fantasmaR-morto)) (not(fantasmaG-morto)) (fantasmaG-up) (dec ?y ?yn))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-up)) (checar-morto-pos))
            )
        )
    )

    (:action move-fantasmaG-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaG-em ?x ?y) (or (fantasmaG-liberado) (fantasmaR-morto)) (not(fantasmaG-morto)) (fantasmaG-down) (inc ?y ?yn))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-down)) (checar-morto-pos))
            )
        )
    )

    (:action move-fantasmaG-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaG-em ?x ?y) (or (fantasmaG-liberado) (fantasmaR-morto)) (not(fantasmaG-morto)) (fantasmaG-left) (dec ?x ?xn))
        :effect (and
            (when
                (and
                    (not(parede-em ?xn ?y))
                )
                (and
                    (not(fantasmaG-em ?x ?y))
                    (fantasmaG-em ?xn ?y)
                    (not(fantasmaG-left))
                    (not(fantasmaG-liberado))
                    (checar-morto-pos)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-left)) (checar-morto-pos))
            )
        )
    )

    (:action move-fantasmaG-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaG-em ?x ?y) (or (fantasmaG-liberado) (fantasmaR-morto)) (not(fantasmaG-morto)) (fantasmaG-right) (inc ?x ?xn))
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
                    (checar-morto-pos)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-right)) (checar-morto-pos))
            )
        )
    )

    (:action comer-fantasma-Green
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py) (frutaG-ativa))
        :effect (and (fantasmaG-morto) (not(frutaG-ativa)) (not(fantasmaG-em ?px ?py)))
    )

    (:action comer-fantasma-red
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (not(fantasmaR-morto)) (fantasmaR-em ?px ?py) (frutaR-ativa))
        :effect (and (fantasmaR-morto) (not(frutaR-ativa)) (not(fantasmaR-em ?px ?py)))
    )

)