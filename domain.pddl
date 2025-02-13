(define (domain pacman)

(:requirements :strips :typing :conditional-effects :negative-preconditions)

(:types 
    posicao
)

(:predicates
    (inc ?a ?b - posicao)
    (dec ?a ?b - posicao)
    ; (fantasmaR-em ?x ?y - posicao)
    ; (fantasmaG-em ?x ?y - posicao)
    (fantasmaB-em ?x ?y - posicao)
    (pacman-em ?x ?y - posicao)
    (parede ?x ?y)
    ; (tem-fantasma)
    (checar-morto)
    (pacman-morto)

    (pacman-liberado)
    (fantasmaB-liberado)
    (fantasmaB-up)
    (fantasmaB-down)
    (fantasmaB-right)
    (fantasmaB-left)
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
            (fantasmaB-liberado)
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
            (not(parede ?x ?yn))
        )

        (and
            (not (pacman-em ?x ?y))
            (not(pacman-liberado))
            (pacman-em ?x ?yn)
            (fantasmaB-liberado)
            (fantasmaB-up)
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
            (not(parede ?xn ?y))
        )

        (and
            (not(pacman-em ?x ?y))
            (not(pacman-liberado))
            (pacman-em ?xn ?y)
            (fantasmaB-liberado)
            (fantasmaB-right)
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
            (not(parede ?xn ?y))
        )

        (and
            (not(pacman-em ?x ?y))
            (not(pacman-liberado))
            (pacman-em ?xn ?y)
            (fantasmaB-liberado)
            (fantasmaB-left)
            (checar-morto)
        )
    )
    )
)

(:action move-ghostB-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (fantasmaB-up) (dec ?y ?yn))
    :effect (and 
    (when 
        (and 
            (not(parede ?x ?yn))
        )

        (and
            (not(fantasmaB-em ?x ?y))
            (fantasmaB-em ?x ?yn)
            (not(fantasmaB-liberado))
            (pacman-liberado)
        )
    )
    )
)

(:action move-ghostB-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (fantasmaB-up) (inc ?y ?yn))
    :effect (and 
    (when 
        (and 
            (not(parede ?x ?yn))
        )

        (and
            (not(fantasmaB-em ?x ?y))
            (fantasmaB-em ?x ?yn)
            (not(fantasmaB-liberado))
            (pacman-liberado)
        )
    )
    )
)

(:action move-ghostB-left
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (fantasmaB-up) (dec ?x ?xn))
    :effect (and 
    (when 
        (and 
            (not(parede ?xn ?y))
        )

        (and
            (not(fantasmaB-em ?x ?y))
            (fantasmaB-em ?xn ?y)
            (not(fantasmaB-liberado))
            (pacman-liberado)
        )
    )
    )
)

(:action move-ghostB-right
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (fantasmaB-up) (inc ?x ?xn))
    :effect (and 
    (when 
        (and 
            (not(parede ?xn ?y))
        )

        (and
            (not(fantasmaB-em ?x ?y))
            (fantasmaB-em ?xn ?y)
            (not(fantasmaB-liberado))
            (pacman-liberado)
        )
    )
    )
)

(:action checagem-morto
    :parameters (?px ?py - posicao)
    :precondition (and (checar-morto) (pacman-em ?px ?py))
    :effect (and 
        (when 
            (and
                (pacman-em ?px ?py) (fantasmaB-em ?px ?py)
            )
            (pacman-morto)
        )
        (not(checar-morto))
        (fantasmaB-liberado)
    )
)


)