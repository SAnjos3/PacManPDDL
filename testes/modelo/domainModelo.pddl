(define (domain pacman)

(:requirements :strips :typing :conditional-effects :negative-preconditions)

(:types 
    posicao
)

(:predicates
    (inicio-turno)
    (fim-turno)
    (inc ?a ?b - posicao)
    (dec ?a ?b - posicao)
    ; (fantasmaR-em ?x ?y - posicao)
    ; (fantasmaG-em ?x ?y - posicao)
    (fantasmaG-em ?x ?y - posicao)
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

    (fantasmaG-liberado)
    (fantasmaG-up)
    (fantasmaG-down)
    (fantasmaG-right)
    (fantasmaG-left)
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
            (fantasmaB-down)
            (fantasmaG-up)
            (checar-morto)
            (inicio-turno)
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
            (not(parede ?xn ?y))
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

; --------------------------------------------------------


(:action move-ghostG-up
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (fantasmaG-up) (dec ?y ?yn))
    :effect (and 
    (when 
        (and 
            (not(parede ?x ?yn))
        )

        (and
            (not(fantasmaG-em ?x ?y))
            (fantasmaG-em ?x ?yn)
            (not(fantasmaG-liberado))
            (not(fantasmaG-up))
            (fantasmaB-liberado)
        )
    )
    )
)

(:action move-ghostG-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (fantasmaG-down) (inc ?y ?yn))
    :effect (and 
    (when 
        (and 
            (not(parede ?x ?yn))
        )

        (and
            (not(fantasmaG-em ?x ?y))
            (fantasmaG-em ?x ?yn)
            (not(fantasmaG-liberado))
            (not(fantasmaG-down))
            (fantasmaB-liberado)
        )
    )
    )
)

(:action move-ghostG-left
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (fantasmaG-left) (dec ?x ?xn))
    :effect (and 
    (when 
        (and 
            (not(parede ?xn ?y))
        )

        (and
            (not(fantasmaG-em ?x ?y))
            (fantasmaG-em ?xn ?y)
            (not(fantasmaG-liberado))
            (not(fantasmaG-left))
            (fantasmaB-liberado)
        )
    )
    )
)

(:action move-ghostG-right
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (fantasmaG-right) (inc ?x ?xn))
    :effect (and 
    (when 
        (and 
            (not(parede ?xn ?y))
        )

        (and
            (not(fantasmaG-em ?x ?y))
            (fantasmaG-em ?xn ?y)
            (not(fantasmaG-liberado))
            (not(fantasmaG-right))
            (fantasmaB-liberado)
        )
    )
    )
)

; --------------------------------------------------------

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
            (not(fantasmaB-up))
            (pacman-liberado)
        )
    )
    )
)

(:action move-ghostB-down
    :parameters (?x ?y ?yn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (fantasmaB-down) (inc ?y ?yn))
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
        )
    )
    )
)

(:action move-ghostB-left
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (fantasmaB-left) (dec ?x ?xn))
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
        )
    )
    )
)

(:action move-ghostB-right
    :parameters (?x ?y ?xn - posicao)
    :precondition (and (fantasmaB-em ?x ?y) (fantasmaB-liberado) (fantasmaB-right) (inc ?x ?xn))
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
        )
    )
    )
)

; ----------------------------------------------------------------------------

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
        (fantasmaG-liberado)
    )
)


)