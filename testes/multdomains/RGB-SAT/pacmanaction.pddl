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
                (increase(total-cost)2)
                (pacman-em ?x ?yn)
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
            )
        )
        (when
            (and(pastilha-em ?x ?yn)
                (not(custo-fruta)))
            (and(not(pastilha-em ?x ?yn)))
            (decrease(total-cost)1)
        )
        (when
            (and(parede-em ?x ?yn))
            (and
                (not(pacman-liberado))
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
                (increase(total-cost)4)
            )
        )
        (when
            (and(parede-em ?x ?yn)(custo-fruta))
            (and (increase(total-cost)4))
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
                (increase(total-cost)2)
                (pacman-em ?x ?yn)
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
            )
        )
        (when
            (and(pastilha-em ?x ?yn)
                (not(custo-fruta)))
            (and(not(pastilha-em ?x ?yn)))
            (decrease(total-cost)1)
        )
        (when
            (and(parede-em ?x ?yn))
            (and
                (not(pacman-liberado))
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
                (increase(total-cost)4)
            )
        )
        (when
            (and(parede-em ?x ?yn)(custo-fruta))
            (and (increase(total-cost)4))
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
                (not (pacman-em ?x ?y))
                (not(pacman-liberado))
                (increase(total-cost)2)
                (pacman-em ?xn ?y)
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
            )
        )
        (when
            (and(pastilha-em ?xn ?y)
                (not(custo-fruta)))
            (and(not(pastilha-em ?xn ?y)))
            (decrease(total-cost)1)
        )
        (when
            (and(parede-em ?xn ?y))
            (and
                (not(pacman-liberado))
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
                (increase(total-cost)4)
            )
        )
        (when
            (and(parede-em ?xn ?y)(custo-fruta))
            (and (increase(total-cost)4))
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
                (not (pacman-em ?x ?y))
                (not(pacman-liberado))
                (increase(total-cost)2)
                (pacman-em ?xn ?y)
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
            )
        )
        (when
            (and(pastilha-em ?xn ?y)
                (not(custo-fruta)))
            (and(not(pastilha-em ?xn ?y)))
            (decrease(total-cost)1)
        )
        (when
            (and(parede-em ?xn ?y))
            (and
                (not(pacman-liberado))
                (fantasmaB-down)
                (fantasmaG-up)
                (checar-morto-pre)
                (increase(total-cost)4)
            )
        )
        (when
            (and(parede-em ?xn ?y)(custo-fruta))
            (and (increase(total-cost)4))
        )
    )
)