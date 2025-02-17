
predicates = """
(:predicates
    ; Predicados de Localização
    (pacman-em ?px ?py - posicao)
    (fantasmaR-em ?px ?py - posicao)
    (fantasmaG-em ?px ?py - posicao)
    (fantasmaB-em ?px ?py - posicao)
    (parede-em ?px ?py)

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
"""

move_up_P = """
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
"""

move_right_P = """
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
"""

move_down_P  = """
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
"""

move_left_P = """   
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
"""

check_morto_Pre = """
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
        (fantasmaR-liberado)
        (fantasmaR-right)
    )
)
"""

move_up_Red = """
    (:action move-fantasmaR-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (not(fantasmaR-morto)) (fantasmaR-liberado) (fantasmaR-up) (dec ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)
                    (not(fantasmaR-up))
                    (not(fantasmaR-liberado))
                    (pacman-liberado)
                    (checar-morto-pos)
                )
            )
            (when
                (parede-em ?x ?yn)
                (and
                    (not(fantasmaR-up))
                    (fantasmaR-right)
                )
            )
        )
    )
"""

move_right_Red = """
    (:action move-fantasmaR-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-right) (inc ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?xn ?y))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?xn ?y)
                    (not(fantasmaR-right))
                    (not(fantasmaR-liberado))
                    (pacman-liberado)
                    (checar-morto-pos)
                )
            )
            (when
                (parede-em ?xn ?y)
                (and
                    (not(fantasmaR-right))
                    (fantasmaR-down)
                )
            )
        )
    )
"""

move_down_Red = """
    (:action move-fantasmaR-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-down) (inc ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)
                    (not(fantasmaR-down))
                    (not(fantasmaR-liberado))
                    (pacman-liberado)
                    (checar-morto-pos)
                )
            )
            (when
                (parede-em ?x ?yn)
                (and
                    (not(fantasmaR-down))
                    (fantasmaR-left)
                )
            )
        )
    )
"""

move_left_Red = """
    (:action move-fantasmaR-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (fantasmaR-liberado) (not(fantasmaR-morto)) (fantasmaR-left) (dec ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?x ?xn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?xn)
                    (not(fantasmaR-left))
                    (not(fantasmaR-liberado))
                    (pacman-liberado)
                    (checar-morto-pos)
                )
            )
            (when
                (parede-em ?xn ?y)
                (and
                    (not(fantasmaR-left))
                    (fantasmaR-up)
                )
            )
        )
    )
"""

move_up_Green = """
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
"""

move_right_Green = """
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
"""

move_down_Green = """
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
"""

move_left_Green = """
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
"""

move_up_Blue = """
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
"""

move_right_Blue = """
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
"""

move_down_Blue  = """
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
"""

move_left_Blue = """
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
"""

check_morto_Pos = """
    (:action checagem-morto-pos
    :parameters (?px ?py - posicao)
    :precondition (and (checar-morto-pos) (pacman-em ?px ?py))
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
"""

comer_fruta_Red = """
    (:action comer-fruta-Red
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (frutaR-em ?px ?py) (not(frutaG-ativa)) (not(frutaB-ativa)))
    :effect (and
    (not(frutaR-em ?px ?py))
    (frutaR-ativa))
    )
"""

comer_fruta_Green = """
    (:action comer-fruta-Green
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (frutaG-em ?px ?py) (not(frutaR-ativa)) (not(frutaB-ativa)))
    :effect (and
    (not(frutaG-em ?px ?py))
    (frutaG-ativa))
    )
"""

comer_fruta_Blue = """
    (:action comer-fruta-Blue
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (frutaB-em ?px ?py) (not(frutaR-ativa)) (not(frutaG-ativa)))
    :effect (and
    (not(frutaB-em ?px ?py))
    (frutaB-ativa))
    )
"""

comer_fantasma_Red = """
    (:action comer-fantasma-Red
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py) (frutaR-ativa))
    :effect (and (fantasmaR-morto) (not(frutaR-ativa)))
"""

comer_fantasma_Green = """
    (:action comer-fantasma-Green
    :parameters (?px ?py - posicao)(not(frutaG-em ?px ?py))
    :precondition (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py) (frutaG-ativa))
    :effect (and (fantasmaG-morto) (not(frutaG-ativa)))
"""

comer_fantasma_Blue = """
    (:action comer-fantasma-Blue
    :parameters (?px ?py - posicao)
    :precondition (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py) (frutaB-ativa))
    :effect (and (fantasmaB-morto) (not(frutaB-ativa)))
"""


with open('domain.pddl', 'w') as file:
    file.write(f"""(define (domain pacman)

(:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

(:types 
    posicao
)
{predicates}
{check_morto_Pre}
{check_morto_Pos}
{move_up_P}
{move_down_P}
{move_left_P}
{move_right_P}

{move_up_Red}
{move_down_Red}
{move_left_Red}
{move_right_Red}

{move_up_Green}
{move_down_Green}
{move_left_Green}
{move_right_Green}

{move_up_Blue}
{move_down_Blue}
{move_left_Blue}
{move_right_Blue}

{comer_fantasma_Red}
{comer_fantasma_Green}
{comer_fantasma_Blue}
)
""")