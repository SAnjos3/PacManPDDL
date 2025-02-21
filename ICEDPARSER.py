import sys
import os
import re

domainRGB = """
        (:predicates
        ; Localização
        (pacman-em ?px ?py - posicao)
        (fantasmaR-em ?px ?py - posicao)
        (fantasmaG-em ?px ?py - posicao)
        (fantasmaB-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)
        (portal-link ?x ?y ?px ?py - posicao)
        (portal-em ?x ?y - posicao)
        (ice-link-up ?x ?y ?fx ?fy)
        (ice-link-down ?x ?y ?fx ?fy)
        (ice-link-right ?x ?y ?fx ?fy)
        (ice-link-left ?x ?y ?fx ?fy)
        (gelo-em ?x ?y)

        ; Frutas
        (frutaR-em ?px ?py - posicao)
        (frutaG-em ?px ?py - posicao)
        (frutaB-em ?px ?py - posicao)
        (frutaR-ativa)
        (frutaG-ativa)
        (frutaB-ativa)

        ; Controle de turnos 
        (turno-pacman)
        (turno-pre)
        (turno-red)
        (turno-green)
        (turno-blue)
        (turno-pos)
        (check-turno)

        ;Direções dos fantasmas
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

    (:action comer-fantasma-green
        :parameters (?px ?py - posicao)
        :precondition(and (pacman-em ?px ?py)(fantasmaG-em ?px ?py) (frutaG-ativa)
            (not(frutaB-ativa))
            (not(frutaR-ativa)))
        :effect(and (check-turno)(fantasmaG-morto)
            (not(frutaG-ativa))
            (not(fantasmaG-em ?px ?py)))
    )
    (:action comer-fantasma-red
        :parameters (?px ?py - posicao)
        :precondition(and (pacman-em ?px ?py)(fantasmaR-em ?px ?py) (frutaR-ativa)
            (not(frutaB-ativa))
            (not(frutaG-ativa)))
        :effect(and (check-turno)(fantasmaR-morto)
            (not(frutaR-ativa))
            (not(fantasmaR-em ?px ?py)))
    )

    (:action comer-fantasma-blue
        :parameters (?px ?py - posicao)
        :precondition(and (pacman-em ?px ?py) (fantasmaB-em ?px ?py) (frutaB-ativa)
            (not(frutaR-ativa))
            (not(frutaG-ativa)))
        :effect(and (check-turno)(fantasmaB-morto)
            (not(frutaB-ativa))
            (not(fantasmaB-em ?px ?py)))
    )
    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and
            (turno-pre)
            (pacman-em ?px ?py)
            (not(check-turno))
        )
        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py)
                        (not(frutaR-ativa)))
                    (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py)
                        (not(frutaG-ativa)))
                    (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py)
                        (not(frutaB-ativa)))
                )
                (pacman-morto)
            )

            ; Comer fruta R se presente
            (when
                (and (pacman-em ?px ?py) (frutaR-em ?px ?py))
                (and (frutaR-ativa) (not(frutaR-em ?px ?py))
                    (not(frutaB-ativa)) (not(frutaG-ativa)))
            )
            ; Comer fruta G se presente
            (when
                (and (pacman-em ?px ?py) (frutaG-em ?px ?py))
                (and (frutaG-ativa) (not(frutaG-em ?px ?py))
                    (not(frutaB-ativa)) (not(frutaR-ativa)))
            )
            ; Comer fruta B se presente
            (when
                (and (pacman-em ?px ?py) (frutaB-em ?px ?py))
                (and (frutaB-ativa) (not(frutaB-em ?px ?py))
                    (not(frutaR-ativa)) (not(frutaG-ativa)))
            )

            (check-turno)

        )
    )

    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and
            (pacman-em ?px ?py)
            (turno-pos)
            (not(check-turno))
        )

        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py)
                        (not(frutaR-ativa)))
                    (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py)
                        (not(frutaG-ativa)))
                    (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py)
                        (not(frutaB-ativa)))
                )
                (pacman-morto)
            )
            (check-turno)
        )
    )

    ;=================================================================================================
    ; AÇÕES DO PACMAN
    ;=================================================================================================
    ;---------------------------------------Gelo--------------------------------------
    (:action move-ice-up
        :parameters (?x ?y ?yn ?fx ?fy - posicao)
        :precondition (and
            (turno-pacman)
            (not(check-turno))
            (pacman-em ?x ?y)
            (dec ?y ?yn)
            (gelo-em ?x ?yn)
            (ice-link-up ?x ?y ?fx ?fy))
        :effect (and
            (when
                (not(parede-em ?fx ?fy))
                (and
                    (not (pacman-em ?x ?y))
                    (pacman-em ?fx ?fy)
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (check-turno)
                )
            )
            (when(and(or(fantasmaB-em ?x ?yn) (fantasmaG-em ?x ?yn) (fantasmaR-em ?x ?yn)))
                (and(pacman-morto)))
            (when
                (parede-em ?fx ?fy)
                (and
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (check-turno)

                )
            )
        )
    )

    (:action move-ice-down
        :parameters (?x ?y ?yn ?fx ?fy - posicao)
        :precondition (and
            (turno-pacman)
            (not(check-turno))
            (pacman-em ?x ?y)
            (inc ?y ?yn)
            (gelo-em ?x ?yn)
            (ice-link-down ?x ?y ?fx ?fy))
        :effect (and
            (when
                (not(parede-em ?fx ?fy))
                (and
                    (not (pacman-em ?x ?y))
                    (pacman-em ?fx ?fy)
                    (fantasmaB-up)
                    (fantasmaG-down)
                    (check-turno)

                )
            )
            (when(and(or(fantasmaB-em ?x ?yn) (fantasmaG-em ?x ?yn) (fantasmaR-em ?x ?yn)))
                (and(pacman-morto)))
            (when
                (parede-em ?fx ?fy)
                (and
                    (fantasmaB-up)
                    (fantasmaG-down)
                    (check-turno)
                )
            )
        )
    )

    (:action move-ice-left
        :parameters (?x ?y ?xn ?fx ?fy - posicao)
        :precondition (and
            (turno-pacman)
            (not(check-turno))
            (pacman-em ?x ?y)
            (dec ?x ?xn)
            (gelo-em ?xn ?y)
            (ice-link-left ?x ?y ?fx ?fy))
        :effect (and
            (when
                (not(parede-em ?fx ?fy))
                (and
                    (not (pacman-em ?x ?y))
                    (pacman-em ?fx ?fy)
                    (fantasmaB-right)
                    (fantasmaG-left)
                    (check-turno)

                )
            )
            (when(and(or(fantasmaB-em ?xn ?y) (fantasmaG-em ?xn ?y) (fantasmaR-em ?xn ?y)))
                (and(pacman-morto)))
            (when
                (parede-em ?fx ?fy)
                (and
                    (fantasmaB-right)
                    (fantasmaG-left)
                    (check-turno)
                )
            )
        )
    )

    (:action move-ice-right
        :parameters (?x ?y ?xn ?fx ?fy - posicao)
        :precondition (and
            (turno-pacman)
            (not(check-turno))
            (pacman-em ?x ?y)
            (inc ?x ?xn)
            (gelo-em ?xn ?y)
            (ice-link-right ?x ?y ?fx ?fy))
        :effect (and
            (when
                (not(parede-em ?fx ?fy))
                (and
                    (not (pacman-em ?x ?y))
                    (pacman-em ?fx ?fy)
                    (fantasmaB-left)
                    (fantasmaG-right)
                    (check-turno)
                )
            )
            (when(and(or(fantasmaB-em ?xn ?y) (fantasmaG-em ?xn ?y) (fantasmaR-em ?xn ?y)))
                (and(pacman-morto)))
            (when
                (parede-em ?fx ?fy)
                (and
                    (fantasmaB-left)
                    (fantasmaG-right)
                    (check-turno)
                )
            )
        )
    )
    ;------------------------------------------Portal-----------------------------------------
    (:action usar-portal-up
        :parameters (?x ?y ?yn ?px ?py)
        :precondition (and (dec ?y ?yn) (portal-em ?x ?yn) (portal-link ?x ?yn ?px ?py) (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (pacman-em ?px ?py)
            (fantasmaB-down)
            (fantasmaG-up)
            (check-turno)
            (when(and(or(fantasmaB-em ?x ?yn) (fantasmaG-em ?x ?yn) (fantasmaR-em ?x ?yn)))
                (and(pacman-morto)))
        )
    )
    (:action usar-portal-down
        :parameters (?x ?y ?yn ?px ?py)
        :precondition (and (inc ?y ?yn) (portal-em ?x ?yn)(portal-link ?x ?yn ?px ?py) (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (pacman-em ?px ?py)
            (fantasmaB-up)
            (fantasmaG-down)
            (check-turno)
            (when(and(or(fantasmaB-em ?x ?yn) (fantasmaG-em ?x ?yn) (fantasmaR-em ?x ?yn)))
                (and(pacman-morto)))
        )
    )
    (:action usar-portal-right
        :parameters (?x ?y ?xn ?px ?py)
        :precondition (and (inc ?x ?xn)(portal-em ?xn ?y) (portal-link ?xn ?y ?px ?py) (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (pacman-em ?px ?py)
            (fantasmaB-left)
            (fantasmaG-right)
            (check-turno)
            (when(and(or(fantasmaB-em ?xn ?y) (fantasmaG-em ?xn ?y) (fantasmaR-em ?xn ?y)))
                (and(pacman-morto)))
        )
    )
    (:action usar-portal-left
        :parameters (?x ?y ?xn ?px ?py)
        :precondition (and (dec ?x ?xn)(portal-em ?xn ?y) (portal-link ?xn ?y ?px ?py) (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y))
        :effect (and
            (not (pacman-em ?x ?y))
            (pacman-em ?px ?py)
            (fantasmaB-right)
            (fantasmaG-left)
            (check-turno)
            (when(and(or(fantasmaB-em ?xn ?y) (fantasmaG-em ?xn ?y) (fantasmaR-em ?xn ?y)))
                (and(pacman-morto)))
        )
    )
    ;---------------------------------Normal----------------------------------------
    (:action move-pacman-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y) (dec ?y ?yn))
        :effect (and
            (when
                (and
                    (not(parede-em ?x ?yn))
                    (not(portal-em ?x ?yn))
                    (not(gelo-em ?x ?yn))
                )

                (and
                    (not (pacman-em ?x ?y))
                    (check-turno)
                    (pacman-em ?x ?yn)
                    (fantasmaB-down)
                    (fantasmaG-up)
                )
            )
            (when
                (and(parede-em ?x ?yn))
                (and
                    (fantasmaB-down)
                    (fantasmaG-up)
                    (check-turno)
                )
            )
        )
    )

    (:action move-pacman-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y) (inc ?y ?yn))
        :effect (and
            (when
                (and
                    (not(parede-em ?x ?yn))
                    (not(portal-em ?x ?yn))
                    (not(gelo-em ?x ?yn))
                )

                (and
                    (not (pacman-em ?x ?y))
                    (pacman-em ?x ?yn)
                    (fantasmaB-up)
                    (fantasmaG-down)

                    (check-turno)
                )
            )
            (when
                (and(parede-em ?x ?yn))
                (and
                    (fantasmaB-up)
                    (fantasmaG-down)
                    (check-turno)
                )
            )
        )
    )

    (:action move-pacman-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y) (dec ?x ?xn))
        :effect (and
            (when
                (and
                    (not(parede-em ?xn ?y))
                    (not(portal-em ?xn ?y))
                    (not(gelo-em ?xn ?y))
                )

                (and
                    (not(pacman-em ?x ?y))

                    (pacman-em ?xn ?y)
                    (fantasmaB-right)
                    (fantasmaG-left)
                    (check-turno)
                )
            )
            (when
                (and(parede-em ?xn ?y))
                (and
                    (fantasmaB-right)
                    (fantasmaG-left)
                    (check-turno)
                )
            )
        )
    )

    (:action move-pacman-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (turno-pacman)
            (not(check-turno)) (pacman-em ?x ?y) (inc ?x ?xn))
        :effect (and
            (when
                (and
                    (not(parede-em ?xn ?y))
                    (not(portal-em ?xn ?y))
                    (not(gelo-em ?xn ?y))
                )

                (and
                    (not(pacman-em ?x ?y))

                    (pacman-em ?xn ?y)
                    (fantasmaB-left)
                    (fantasmaG-right)
                    (check-turno)
                )
            )
            (when
                (and(parede-em ?xn ?y))
                (and

                    (fantasmaB-left)
                    (fantasmaG-right)
                    (check-turno)
                )
            )
        )
    )
    ;-------------------------------------------------FantasmaRed----------------------------------------------

    (:action fantasmaR-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y)
            (not(check-turno)) (not(fantasmaR-morto)) (turno-red) (fantasmaR-up) (dec ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)
                    (check-turno)
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

    (:action fantasmaR-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y)
            (not(check-turno)) (turno-red) (not(fantasmaR-morto)) (fantasmaR-down) (inc ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)

                    (check-turno)
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

    (:action fantasmaR-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y)
            (not(check-turno)) (turno-red) (not(fantasmaR-morto)) (fantasmaR-left) (dec ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?xn ?y))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?xn ?y)

                    (check-turno)
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

    (:action fantasmaR-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (not(check-turno))(turno-red) (not(fantasmaR-morto)) (fantasmaR-right) (inc ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?xn ?y))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?xn ?y)

                    (check-turno)
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
    ;-------------------------------------------------FantasmaGreen---------------------------------------------
    (:action fantasmaG-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaG-em ?x ?y)
            (not(check-turno)) (turno-green) (not(fantasmaG-morto)) (fantasmaG-up) (dec ?y ?yn))
        :effect (and
            (when
                (and
                    (not(parede-em ?x ?yn))
                )
                (and
                    (not(fantasmaG-em ?x ?y))
                    (fantasmaG-em ?x ?yn)
                    (not(fantasmaG-up))
                    (check-turno)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaG-up)) (check-turno))
            )
        )
    )

    (:action fantasmaG-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaG-em ?x ?y)
            (not(check-turno)) (turno-green) (not(fantasmaG-morto)) (fantasmaG-down) (inc ?y ?yn))
        :effect (and
            (when
                (and
                    (not(parede-em ?x ?yn))
                )
                (and
                    (not(fantasmaG-em ?x ?y))
                    (fantasmaG-em ?x ?yn)
                    (not(fantasmaG-down))
                    (check-turno)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaG-down)) (check-turno))
            )
        )
    )

    (:action fantasmaG-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaG-em ?x ?y)
            (not(check-turno)) (turno-green) (not(fantasmaG-morto)) (fantasmaG-left) (dec ?x ?xn))
        :effect (and
            (when
                (and
                    (not(parede-em ?xn ?y))
                )
                (and
                    (not(fantasmaG-em ?x ?y))
                    (fantasmaG-em ?xn ?y)
                    (not(fantasmaG-left))
                    (check-turno)

                )
            )
            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-left)) (check-turno))
            )
        )
    )

    (:action fantasmaG-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaG-em ?x ?y)
            (not(check-turno)) (turno-green) (not(fantasmaG-morto)) (fantasmaG-right) (inc ?x ?xn))
        :effect (and
            (when
                (and
                    (not(parede-em ?xn ?y))
                )
                (and
                    (not(fantasmaG-em ?x ?y))
                    (fantasmaG-em ?xn ?y)
                    (not(fantasmaG-right))
                    (check-turno)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-right)) (check-turno))
            )
            (when
                (and(fantasmaB-morto))
                (and(check-turno)))
        )
    )
    ;---------------------------------------------FantasmaBlue-------------------------------------------------------------
    (:action fantasmaB-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaB-em ?x ?y)
            (not(check-turno)) (turno-blue) (not(fantasmaB-morto)) (fantasmaB-up) (dec ?y ?yn))
        :effect (and
            (when
                (and
                    (not(parede-em ?x ?yn))
                )

                (and
                    (not(fantasmaB-em ?x ?y))
                    (fantasmaB-em ?x ?yn)

                    (not(fantasmaB-up))
                    (check-turno)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaB-up)) (check-turno))
            )
        )
    )

    (:action fantasmaB-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaB-em ?x ?y)
            (not(check-turno))(turno-blue) (not(fantasmaB-morto)) (fantasmaB-down) (inc ?y ?yn))
        :effect (and
            (when
                (and
                    (not(parede-em ?x ?yn))
                )

                (and
                    (not(fantasmaB-em ?x ?y))
                    (fantasmaB-em ?x ?yn)
                    (not(fantasmaB-down))
                    (check-turno)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaB-down)) (check-turno))
            )
        )
    )

    (:action fantasmaB-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaB-em ?x ?y)
            (not(check-turno)) (turno-blue) (not(fantasmaB-morto)) (fantasmaB-left) (dec ?x ?xn))
        :effect (and
            (when
                (and
                    (not(parede-em ?xn ?y))
                )

                (and
                    (not(fantasmaB-em ?x ?y))
                    (fantasmaB-em ?xn ?y)
                    (not(fantasmaB-left))
                    (check-turno)

                )
            )
            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaB-left)) (check-turno))
            )
        )
    )

    (:action fantasmaB-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaB-em ?x ?y)
            (not(check-turno)) (turno-blue) (not(fantasmaB-morto)) (fantasmaB-right) (inc ?x ?xn))
        :effect (and
            (when
                (and
                    (not(parede-em ?xn ?y))
                )

                (and
                    (not(fantasmaB-em ?x ?y))
                    (fantasmaB-em ?xn ?y)
                    (not(fantasmaB-right))
                    (check-turno)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaB-right)) (check-turno))
            )
        )
    )
    ;-----------------------------------------ComerFruta-------------------------------------------------

    ;--------------------------------------------PassagemTurno-----------------------------
    (:action pass-red
        :parameters ()
        :precondition (and (fantasmaR-morto)(turno-red))
        :effect (and (check-turno))
    )
    (:action pass-green
        :parameters ()
        :precondition (and (fantasmaG-morto)(turno-green))
        :effect (and (check-turno))
    )
    (:action pass-blue
        :parameters ()
        :precondition (and (fantasmaB-morto)(turno-blue))
        :effect (and (check-turno))
    )

    ;--------------------------------------------ControleTurnos---------------------------------
    (:action controle-turnos
        :parameters ()
        :precondition (and(check-turno)
            (not(pacman-morto)))
        :effect (and
            ; ->Turno-pacman
            (when
                (and (turno-pos))
                (and
                    (turno-pacman)
                    (not(turno-pos))
                ))
            ; ->Turno-pre
            (when
                (and (turno-pacman))
                (and
                    (not(turno-pacman))
                    (turno-pre)
                ))
            ; ->Turno-red
            (when
                (and (turno-pre))
                (and
                    (not(turno-pre))
                    (turno-red)
                ))
            ; ->Turno-green
            (when
                (and (turno-red))
                (and
                    (not(turno-red))
                    (turno-green)
                ))
            ; ->Turno-blue
            (when
                (and (turno-green))
                (and
                    (not(turno-green))
                    (turno-blue)
                ))
            ; ->Turno-pos 
            (when
                (and (turno-blue))
                (and
                    (not(turno-blue))
                    (turno-pos)
                )
            )
            (not(check-turno))
        )
    )"""

entrada = sys.stdin.read()
mapa = entrada.strip().split("\n")

ExisteR = False
ExisteG = False
ExisteB = False

portais = []
for y, linha in enumerate(mapa):
    for x, char in enumerate(linha):
        if char == "O":
            portais.append((x + 1, y + 1))
        # if(char == "I"):
        #     exit(0)
        if(char == "R"):
            ExisteR = True
        if(char == "G"):
            ExisteG = True
        if(char == "B"):
            ExisteB = True
        

with open("domainPACMAN.pddl", "w") as f:
    f.write(f"""
(define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

    (:types
        posicao
    )
    """)


    f.write(domainRGB)

    f.write(f"""
    )
    """)

with open("problemPACMAN.pddl", "w") as f:
    f.write("""
    (define (problem pacmanCOMPETICAOTOP)
        (:domain pacman)
        (:objects
        """)
    
    altura = len(mapa)
    largura = len(mapa[0])

    for x in range(1, largura+1):
        f.write(f"x{x} ")
    for y in range(1, altura+1):
        f.write(f"y{y} ")
    f.write("- posicao\n\t\t)")

    f.write("""
    (:init
    (turno-pacman)
""")
    if ExisteR == True:
        f.write("""
    (fantasmaR-right)
""")

    for y, linha in enumerate(mapa):
        for x, char in enumerate(linha):
            if(char == '#'):
                f.write(f"\t\t(parede-em x{x+1} y{y+1})\n")
            if(char == 'P'):
                f.write(f"\t\t(pacman-em x{x+1} y{y+1})\n")
            if(char == 'R'):
                f.write(f"\t\t(fantasmaR-em x{x+1} y{y+1})\n")
            if(char == 'G'):
                f.write(f"\t\t(fantasmaG-em x{x+1} y{y+1})\n")
            if(char == 'B'):
                f.write(f"\t\t(fantasmaB-em x{x+1} y{y+1})\n")
            if(char == '!'):
                f.write(f"\t\t(frutaR-em x{x+1} y{y+1})\n")
            if(char == '@'):
                f.write(f"\t\t(frutaG-em x{x+1} y{y+1})\n")
            if(char == '$'):
                f.write(f"\t\t(frutaB-em x{x+1} y{y+1})\n")
            if(char == "O"):
                f.write(f"\t\t(portal-em x{x+1} y{y+1})\n")
            if(char == "I"):
                f.write(f"\t\t(gelo-em x{x+1} y{y+1})\n")
    if(ExisteR == False):
        f.write(f"\t\t(fantasmaR-morto)\n")
    if(ExisteG == False):
        f.write(f"\t\t(fantasmaG-morto)\n")
    if(ExisteB == False):
        f.write(f"\t\t(fantasmaB-morto)\n")
            

    if len(portais) % 2 == 0:
        for i in range(0, len(portais), 2):
            xi, yi = portais[i]
            fxi, fyi = portais[i + 1]
            f.write(f"\t\t(portal-link x{xi} y{yi} x{fxi} y{fyi})\n")
            f.write(f"\t\t(portal-link x{fxi} y{fyi} x{xi} y{yi})\n")

    for y in range(altura):
        for x in range(largura):
            if mapa[y][x] in [" ", "P", "R", "G", "B", "!", "$", "@"]:
                if y > 0 and mapa[y-1][x] == "I":
                    fy = y - 1
                    while fy >= 0 and mapa[fy][x] == "I":
                        fy -= 1
                    f.write(f"\t\t(ice-link-up x{x+1} y{y+1} x{x+1} y{fy+1})\n")

                if y < altura - 1 and mapa[y+1][x] == "I":
                    fy = y + 1
                    while fy < altura and mapa[fy][x] == "I":
                        fy += 1
                    f.write(f"\t\t(ice-link-down x{x+1} y{y+1} x{x+1} y{fy+1})\n")

                if x > 0 and mapa[y][x-1] == "I":
                    fx = x - 1
                    while fx >= 0 and mapa[y][fx] == "I":
                        fx -= 1
                    f.write(f"\t\t(ice-link-left x{x+1} y{y+1} x{fx+1} y{y+1})\n")

                if x < largura - 1 and mapa[y][x+1] == "I":
                    fx = x + 1
                    while fx < largura and mapa[y][fx] == "I":
                        fx += 1
                    f.write(f"\t\t(ice-link-right x{x+1} y{y+1} x{fx+1} y{y+1})\n")


    for x in range(1, largura):
        f.write(f"\t\t(inc x{x} x{x+1})\n")
    for y in range(1, altura):
        f.write(f"\t\t(inc y{y} y{y+1})\n")

    for x in range(1, largura):
        f.write(f"\t\t(dec x{x+1} x{x})\n")
    for y in range(1, altura):
        f.write(f"\t\t(dec y{y+1} y{y})\n")

    f.write(")")

    f.write("""
    (:goal
        (and
            (not(pacman-morto))
""")
    if(ExisteR):
        f.write("\t\t\t(fantasmaR-morto)")
    if(ExisteG):
        f.write("\t\t\t(fantasmaG-morto)")
    if(ExisteB):
        f.write("\t\t\t(fantasmaB-morto)")
    f.write(")))")

os.system("/home/software/planners/downward/fast-downward.py --alias lama-first --overall-time-limit 30 --plan-file saida.txt domainPACMAN.pddl problemPACMAN.pddl > log.txt")

direcoes_mapa = {
    "up" : "N",
    "down" : "S",
    "left" : "W",
    "right" : "E"
}

mov = []

regex = re.compile(r"\((move-pacman-|usar-portal-|move-ice-)([a-zA-Z]+) ")

with open("saida.txt", "r") as saida:
    for linha in saida:
        linha = linha.strip()
        match = regex.match(linha) 
        if match:
            acao = match.group(1)    
            direcao = match.group(2)  
            if direcao in direcoes_mapa:
                mov.append(direcoes_mapa[direcao])
if mov:
    print(";".join(mov) + ";0")
else:
    print("0")
