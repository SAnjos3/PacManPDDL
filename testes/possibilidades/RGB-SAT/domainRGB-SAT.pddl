(define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :action-costs :negative-preconditions)

    (:types
        posicao
    )
    (:functions
        (total-cost)
    )

    (:predicates
        ; Localização
        (pacman-em ?px ?py - posicao)
        (fantasmaR-em ?px ?py - posicao)
        (fantasmaG-em ?px ?py - posicao)
        (fantasmaB-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)
        (pastilha-em ?px ?py)
        (portal-em ?x ?y ?px ?py)

        ; Frutas
        (frutaR-em ?px ?py - posicao)
        (frutaG-em ?px ?py - posicao)
        (frutaB-em ?px ?py - posicao)
        (frutaR-ativa)
        (frutaG-ativa)
        (frutaB-ativa)

        ; Liberação de turnos
        (pacman-liberado)
        (fantasmaR-liberado)
        (fantasmaG-liberado)
        (fantasmaB-liberado)

        ; Direções dos fantasmas
        (fantasmaR-up)
        (fantasmaR-down)
        (fantasmaR-left)
        (fantasmaR-right)
        (fantasmaG-up)
        (fantasmaG-down)
        (fantasmaG-left)
        (fantasmaG-right)
        (fantasmaB-up)
        (fantasmaB-down)
        (fantasmaB-left)
        (fantasmaB-right)

        ; Checagem de morte
        (checar-morto-pre)
        (checar-morto-pos)

        ; Incremento/Decremento
        (inc ?x ?nx)
        (dec ?x ?nx)

        ; Estados de morte
        (fantasmaR-morto)
        (fantasmaG-morto)
        (fantasmaB-morto)
        (pacman-morto)
    )

    ;-----------------------------------------AÇÕES DE CHECAGEM-----------------------------------------------

    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and
            (checar-morto-pre)
            (pacman-em ?px ?py)
        )
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
            (fantasmaR-liberado)

            ;; Comer fruta R se presente
            (when
                (and (pacman-em ?px ?py) (frutaR-em ?px ?py))
                (and (frutaR-ativa) (not(frutaR-em ?px ?py)) (not(frutaB-ativa)) (not(frutaG-ativa)))
            )
            ;; Comer fruta G se presente
            (when
                (and (pacman-em ?px ?py) (frutaG-em ?px ?py))
                (and (frutaG-ativa) (not(frutaG-em ?px ?py)) (not(frutaB-ativa)) (not(frutaR-ativa)))
            )
            ;; Comer fruta B se presente
            (when
                (and (pacman-em ?px ?py) (frutaB-em ?px ?py))
                (and (frutaB-ativa) (not(frutaB-em ?px ?py)) (not(frutaR-ativa)) (not(frutaG-ativa)))
            )
        )
    )

    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and
            (pacman-em ?px ?py)
            (checar-morto-pos)
        )

        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
                )
                (pacman-morto)
            )
            (not(checar-morto-pos))
            (pacman-liberado)
        )
    )

    ;=================================================================================================
    ; AÇÕES DO PACMAN
    ;=================================================================================================
    (:action usar-portal-up
        :parameters (?x ?y ?yn ?px ?py)
        :precondition (and (dec ?y ?yn) (portal-em ?x ?yn ?px ?py) (pacman-liberado) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (not(pacman-liberado))

            (pacman-em ?px ?py)
            (fantasmaB-down)
            (fantasmaG-up)
            (checar-morto-pre)
            (when
                (and
                    (or
                        (frutaR-ativa)
                        (frutaB-ativa)
                        (frutaG-ativa)))
                (and (increase (total-cost) 4))
            )
            (when
                (and
                    (not(frutaR-ativa))
                    (not(frutaG-ativa))
                    (not(frutaB-ativa)))
                (and (increase (total-cost) 2))
            )
        )
    )
    (:action usar-portal-down
        :parameters (?x ?y ?yn ?px ?py)
        :precondition (and (inc ?y ?yn) (portal-em ?x ?yn ?px ?py) (pacman-liberado) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (not(pacman-liberado))

            (pacman-em ?px ?py)
            (fantasmaB-up)
            (fantasmaG-down)
            (checar-morto-pre)
            (when
                (and
                    (or
                        (frutaR-ativa)
                        (frutaB-ativa)
                        (frutaG-ativa)))
                (and (increase (total-cost) 4))
            )
            (when
                (and
                    (not(frutaR-ativa))
                    (not(frutaG-ativa))
                    (not(frutaB-ativa)))
                (and (increase (total-cost) 2))
            )
        )
    )
    (:action usar-portal-right
        :parameters (?x ?y ?xn ?px ?py)
        :precondition (and (inc ?x ?xn) (portal-em ?xn ?y ?px ?py) (pacman-liberado) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (not(pacman-liberado))

            (pacman-em ?px ?py)
            (fantasmaB-up)
            (fantasmaG-down)
            (checar-morto-pre)
            (when
                (and
                    (or
                        (frutaR-ativa)
                        (frutaB-ativa)
                        (frutaG-ativa)))
                (and (increase (total-cost) 4))
            )
            (when
                (and
                    (not(frutaR-ativa))
                    (not(frutaG-ativa))
                    (not(frutaB-ativa)))
                (and (increase (total-cost) 2))
            )
        )
    )
    (:action usar-portal-left
        :parameters (?x ?y ?xn ?px ?py)
        :precondition (and (dec ?x ?xn) (portal-em ?xn ?y ?px ?py) (pacman-liberado) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (not(pacman-liberado))

            (pacman-em ?px ?py)
            (fantasmaB-up)
            (fantasmaG-down)
            (checar-morto-pre)
            (when
                (and
                    (or
                        (frutaR-ativa)
                        (frutaB-ativa)
                        (frutaG-ativa)))
                (and (increase (total-cost) 4))
            )
            (when
                (and
                    (not(frutaR-ativa))
                    (not(frutaG-ativa))
                    (not(frutaB-ativa)))
                (and (increase (total-cost) 2))
            )
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
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?x ?yn))
                (and
                    (not(pacman-liberado))
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(not(parede-em ?x ?yn))(pastilha-em ?x ?yn))
                (and(increase(total-cost)1)))
            (when
                (and(not(parede-em ?x ?yn)))
                (and(increase(total-cost)2)))
            (when
                (and(parede-em ?x ?yn))
                (and(increase(total-cost)4)))
            (when
                (and(not(parede-em ?x ?yn))
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)4)))
            (when
                (and(parede-em ?x ?yn)
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)8)))

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
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?x ?yn))
                (and
                    (not(pacman-liberado))
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(not(parede-em ?x ?yn))(pastilha-em ?x ?yn))
                (and(increase(total-cost)1)))
            (when
                (and(not(parede-em ?x ?yn)))
                (and(increase(total-cost)2)))
            (when
                (and(parede-em ?x ?yn))
                (and(increase(total-cost)4)))
            (when
                (and(not(parede-em ?x ?yn))
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)4)))
            (when
                (and(parede-em ?x ?yn)
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)8)))

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
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?xn ?y))
                (and
                    (not(pacman-liberado))

                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(not(parede-em ?xn ?y))(pastilha-em ?xn ?y))
                (and(increase(total-cost)1)))
            (when
                (and(not(parede-em ?xn ?y)))
                (and(increase(total-cost)2)))
            (when
                (and(parede-em ?xn ?y))
                (and(increase(total-cost)4)))
            (when
                (and(not(parede-em ?xn ?y))
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)4)))
            (when
                (and(parede-em ?xn ?y)
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)8)))

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
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(parede-em ?xn ?y))
                (and
                    (not(pacman-liberado))

                    (fantasmaB-down)
                    (fantasmaG-up)
                    (checar-morto-pre)
                )
            )
            (when
                (and(not(parede-em ?xn ?y))(pastilha-em ?xn ?y))
                (and(increase(total-cost)1)))
            (when
                (and(not(parede-em ?xn ?y)))
                (and(increase(total-cost)2)))
            (when
                (and(parede-em ?xn ?y))
                (and(increase(total-cost)4)))
            (when
                (and(not(parede-em ?xn ?y))
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)4)))
            (when
                (and(parede-em ?xn ?y)
                    (or(frutaB-ativa)(frutaG-ativa)(frutaR-ativa)))
                (and(increase(total-cost)8)))
        )
    )
    ;=================================================================================================
    ; AÇÕES DO FANTASMA VERMELHO (R)
    ;================================================================================================= (:action move-fantasmaR-up
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
                (and(fantasmaG-morto)(fantasmaB-morto)
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
                (and(fantasmaG-morto)(fantasmaB-morto)
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
                (and(fantasmaG-morto)(fantasmaB-morto)
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
                (and(fantasmaG-morto)(fantasmaB-morto)
                    (not(parede-em ?xn ?y)))
                (and(checar-morto-pos))
            )
        )
    )
    (:action comer-fantasma-red
        :parameters (?px ?py - posicao)
        :precondition (and
            (pacman-em ?px ?py)
            (fantasmaR-em ?px ?py)
            (frutaR-ativa)
            (not(fantasmaR-morto))
        )
        :effect (and
            (fantasmaR-morto)
            (not(frutaR-ativa))
            (not(fantasmaR-em ?px ?py))
        )
    )

    ;=================================================================================================
    ; AÇÕES DO FANTASMA VERDE (G)
    ;================================================================================================= (:action move-fantasmaG-up
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
                    (fantasmaB-liberado)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-up)) (fantasmaB-liberado))
            )
            (when
                (and (fantasmaB-morto))
                (and(checar-morto-pos)))
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
                    (fantasmaB-liberado)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-down)) (fantasmaB-liberado))
            )
            (when
                (and (fantasmaB-morto))
                (and(checar-morto-pos)))
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
                    (fantasmaB-liberado)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-left)) (fantasmaB-liberado))
            )
            (when
                (and (fantasmaB-morto))
                (and(checar-morto-pos)))
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
                    (fantasmaB-liberado)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-right)) (fantasmaB-liberado))
            )
            (when
                (and (fantasmaB-morto))
                (and(checar-morto-pos)))
        )
    )
    (:action comer-fantasma-Green
        :parameters (?px ?py - posicao)
        :precondition (and
            (pacman-em ?px ?py)
            (fantasmaG-em ?px ?py)
            (frutaG-ativa)
            (not(fantasmaG-morto))
        )
        :effect (and
            (fantasmaG-morto)
            (not(frutaG-ativa))
            (not(fantasmaG-em ?px ?py))
        )
    )

    ;=================================================================================================
    ; AÇÕES DO FANTASMA AZUL (B)
    ;================================================================================================= (:action move-fantasmaB-up
    (:action move-fantasmaB-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (or (fantasmaG-morto) (and (fantasmaG-morto)(fantasmaR-morto)))) (not(fantasmaB-morto)) (fantasmaB-up) (dec ?y ?yn))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaB-liberado)) (not(fantasmaG-up)) (checar-morto-pos))
            )
        )
    )

    (:action move-fantasmaB-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (or (fantasmaG-morto) (and (fantasmaG-morto)(fantasmaR-morto)))) (not(fantasmaB-morto)) (fantasmaB-down) (inc ?y ?yn))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaB-liberado)) (not(fantasmaG-down)) (checar-morto-pos))
            )
        )
    )
    (:action move-fantasmaB-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (or (fantasmaG-morto) (and (fantasmaG-morto)(fantasmaR-morto)))) (not(fantasmaB-morto)) (fantasmaB-left) (dec ?x ?xn))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaB-liberado)) (not(fantasmaG-left)) (checar-morto-pos))
            )
        )
    )
    (:action move-fantasmaB-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (or (fantasmaG-morto) (and (fantasmaG-morto)(fantasmaR-morto)))) (not(fantasmaB-morto)) (fantasmaB-right) (inc ?x ?xn))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaB-liberado)) (not(fantasmaG-right)) (checar-morto-pos))
            )
        )
    )
    (:action comer-fantasma-Blue
        :parameters (?px ?py - posicao)
        :precondition (and
            (pacman-em ?px ?py)
            (fantasmaB-em ?px ?py)
            (frutaB-ativa)
            (not(fantasmaB-morto))
        )
        :effect (and
            (fantasmaB-morto)
            (not(frutaB-ativa))
            (not(fantasmaB-em ?px ?py))
        )
    )
)