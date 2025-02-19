#include <iostream>
#include <string>
using namespace std;
int main()
{
    string R, G, B, RG, RB, GB, RGB;
    RG = R"((define (domain pacman)

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
            (fantasmaG-liberado)
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
        :precondition (and (or (checar-morto-pos) (fantasmaG-morto)) (pacman-em ?px ?py))
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
    (:action N
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
        )
    )

    (:action S
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
        )
    )

    (:action W
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
        )
    )

    (:action E
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

))";
    RB = R"((define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

    (:types
        posicao
    )

    (:predicates
        ; Predicados de Localização
        (pacman-em ?px ?py - posicao)
        (fantasmaR-em ?px ?py - posicao)
        (fantasmaB-em ?px ?py - posicao)
        (frutaR-em ?px ?py - posicao)
        (frutaB-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)

        ; Predicados de liberação
        (pacman-liberado)
        (fantasmaR-liberado)
        (fantasmaB-liberado)

        ; Predicados de Direção do Fantasma Azul:
        (fantasmaB-up)
        (fantasmaB-down)
        (fantasmaB-left)
        (fantasmaB-right)

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
        (frutaB-ativa)

        ; Predicados de finalização
        (fantasmaR-morto)
        (fantasmaB-morto)
        (pacman-morto)
    )

    ;-----------------------------------------------Checagem------------------------------------------------------
    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pre) (pacman-em ?px ?py))
        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
                )
                (pacman-morto)
            )
            (not(checar-morto-pre))
            (fantasmaR-liberado)
            (when
                (and (pacman-em ?px ?py) (frutaR-em ?px ?py))
                (and (frutaR-ativa) (not(frutaB-ativa)) (not(frutaR-em ?px ?py))))
            (when
                (and (pacman-em ?px ?py) (frutaB-em ?px ?py))
                (and (frutaB-ativa) (not(frutaR-ativa)) (not(frutaB-em ?px ?py))))
        )
    )

    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and (or(checar-morto-pos)(fantasmaB-morto)) (pacman-em ?px ?py))
        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
                )
                (pacman-morto)
            )
            (not(checar-morto-pos))
            (pacman-liberado)
        )
    )
    ;--------------------------------------------------Pacman---------------------------------------------
    (:action N
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
                    (checar-morto-pre)
                )
            )
        )
    )

    (:action S
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
                    (checar-morto-pre)
                )
            )
        )
    )

    (:action W
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
                    (checar-morto-pre)
                )
            )
        )
    )

    (:action E
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
                    (checar-morto-pre)
                )
            )
        )
    )
    ;------------------------------------------------------FantasmaR-----------------------------------------------------------
    (:action move-fantasmaR-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (not(fantasmaR-morto)) (or (fantasmaR-liberado) (fantasmaB-morto)) (fantasmaR-up) (dec ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)
                    (not(fantasmaR-liberado))
                    (fantasmaB-liberado)
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
    (:action move-fantasmaR-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (or (fantasmaR-liberado) (fantasmaB-morto)) (not(fantasmaR-morto)) (fantasmaR-down) (inc ?y ?yn))
        :effect (and
            (when
                (not(parede-em ?x ?yn))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?x ?yn)
                    (not(fantasmaR-liberado))
                    (fantasmaB-liberado)
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
    (:action move-fantasmaR-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (or (fantasmaR-liberado) (fantasmaB-morto)) (not(fantasmaR-morto)) (fantasmaR-left) (dec ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?xn ?y))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?xn ?y)
                    (not(fantasmaR-liberado))
                    (fantasmaB-liberado)
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
    (:action move-fantasmaR-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaR-em ?x ?y) (or (fantasmaR-liberado) (fantasmaB-morto)) (not(fantasmaR-morto)) (fantasmaR-right) (inc ?x ?xn))
        :effect (and
            (when
                (not(parede-em ?xn ?y))
                (and
                    (not(fantasmaR-em ?x ?y))
                    (fantasmaR-em ?xn ?y)
                    (not(fantasmaR-liberado))
                    (fantasmaB-liberado)
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
    ;-----------------------------------------------FantasmaB--------------------------------------------------------
    (:action move-fantasmaB-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or(fantasmaB-liberado) (fantasmaR-morto)) (not(fantasmaB-morto)) (fantasmaB-up) (dec ?y ?yn))
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
                (and (not(fantasmaB-liberado)) (not(fantasmaB-up)) (checar-morto-pos))
            )
        )
    )
    (:action move-fantasmaB-down
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or(fantasmaB-liberado) (fantasmaR-morto)) (not(fantasmaB-morto)) (fantasmaB-down) (inc ?y ?yn))
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
                (and (not(fantasmaB-liberado)) (not(fantasmaB-down)) (checar-morto-pos))
            )
        )
    )
    (:action move-fantasmaB-left
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or(fantasmaB-liberado) (fantasmaR-morto)) (not(fantasmaB-morto)) (fantasmaB-left) (dec ?x ?xn))
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
                (and (not(fantasmaB-liberado)) (not(fantasmaB-left)) (checar-morto-pos))
            )
        )
    )
    (:action move-fantasmaB-right
        :parameters (?x ?y ?xn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or(fantasmaB-liberado) (fantasmaR-morto)) (not(fantasmaB-morto)) (fantasmaB-right) (inc ?x ?xn))
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
                (and (not(fantasmaB-liberado)) (not(fantasmaB-right)) (checar-morto-pos))
            )
        )
    )
    ;----------------------------------------------------Comer-----------------------------------------------------------
    (:action comer-fantasma-Blue
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py) (frutaB-ativa))
        :effect (and (fantasmaB-morto) (not(frutaB-ativa)) (not(fantasmaB-em ?px ?py)))
    )
    (:action comer-fantasma-red
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (not(fantasmaR-morto)) (fantasmaR-em ?px ?py) (frutaR-ativa))
        :effect (and (fantasmaR-morto) (not(frutaR-ativa)) (not(fantasmaR-em ?px ?py)))
    )

))";
    GB = R"((define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

    (:types
        posicao
    )

    (:predicates
        ; Predicados de Localização
        (pacman-em ?px ?py - posicao)

        (fantasmaG-em ?px ?py - posicao)
        (fantasmaB-em ?px ?py - posicao)

        (frutaG-em ?px ?py - posicao)
        (frutaB-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)

        ; Predicados de liberação
        (pacman-liberado)

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

        ; Predicados de Checagem de Morte:
        (checar-morto-pre)
        (checar-morto-pos)

        ; Predicados de Incremento/Decremento:
        (inc ?x ?xn)
        (dec ?x ?xn)

        ; Predicados frutas:
        (frutaG-ativa)
        (frutaB-ativa)

        ; Predicados de finalização
        (fantasmaG-morto)
        (fantasmaB-morto)
        (pacman-morto)
    )
    ;-------------------------------------------Checagem---------------------------------------------------------
    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pre) (pacman-em ?px ?py))
        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
                )
                (pacman-morto)
            )
            (not(checar-morto-pre))
            (fantasmaG-liberado)
            (when
                (and (pacman-em ?px ?py) (frutaG-em ?px ?py))
                (and (frutaG-ativa) (not(frutaB-ativa)) (not(frutaG-em ?px ?py))))
            (when
                (and (pacman-em ?px ?py) (frutaB-em ?px ?py))
                (and (frutaB-ativa) (not(frutaG-ativa)) (not(frutaB-em ?px ?py))))
        )
    )
    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and (or (checar-morto-pos) (fantasmaB-morto)) (pacman-em ?px ?py))
        :effect (and
            (when
                (or
                    (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                    (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
                )
                (pacman-morto)
            )
            (not(checar-morto-pos))
            (pacman-liberado)
        )
    )
    ;---------------------------------------------------Pacman------------------------------------------------------
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

    ; ------------------------------------------------FantasmaGreen-----------------------------------------------------------

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
                    (fantasmaB-liberado)

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
                    (fantasmaB-liberado)

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
        :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (not(fantasmaG-morto)) (fantasmaG-left) (dec ?x ?xn))
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
                (and (not(fantasmaG-liberado)) (not(fantasmaG-left)) (checar-morto-pos))
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
                    (fantasmaB-liberado)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-right)) (checar-morto-pos))
            )
        )
    )
    ;---------------------------------------------FantasmaBlue-------------------------------------------------------------
    (:action move-fantasmaB-up
        :parameters (?x ?y ?yn - posicao)
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (fantasmaG-morto)) (not(fantasmaB-morto)) (fantasmaB-up) (dec ?y ?yn))
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
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (fantasmaG-morto)) (not(fantasmaB-morto)) (fantasmaB-down) (inc ?y ?yn))
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
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (fantasmaG-morto)) (not(fantasmaB-morto)) (fantasmaB-left) (dec ?x ?xn))
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
        :precondition (and (fantasmaB-em ?x ?y) (or (fantasmaB-liberado) (fantasmaG-morto)) (not(fantasmaB-morto)) (fantasmaB-right) (inc ?x ?xn))
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
        :precondition (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py) (frutaB-ativa))
        :effect (and (fantasmaB-morto) (not(frutaB-ativa)) (not(fantasmaB-em ?px ?py)))
    )

    (:action comer-fantasma-Green
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py) (frutaG-ativa))
        :effect (and (fantasmaG-morto) (not(frutaG-ativa)) (not(fantasmaG-em ?px ?py)))
    )
))";
    R = R"((define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

    (:types
        posicao
    )

    (:predicates
        ; Predicados de Localização
        (pacman-em ?px ?py - posicao)
        (fantasmaR-em ?px ?py - posicao)
        (frutaR-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)

        ; Predicados de liberação
        (pacman-liberado)
        (fantasmaR-liberado)

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

        ; Predicados de finalização
        (fantasmaR-morto)
        (pacman-morto)
    )

    ;------------------------------------------Checagem------------------------------------
    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pre) (pacman-em ?px ?py))
        :effect (and
            (when
                (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                (pacman-morto)
            )
            (not(checar-morto-pre))
            (fantasmaR-liberado)
            (when
                (and (pacman-em ?px ?py)(frutaR-em ?px ?py))
                (and(frutaR-ativa) (not(frutaR-em ?px ?py))))

        )
    )

    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pos) (pacman-em ?px ?py))
        :effect (and
            (when
                (and (pacman-em ?px ?py) (fantasmaR-em ?px ?py))
                (pacman-morto)
            )
            (not(checar-morto-pos))
            (pacman-liberado)
        )
    )

    ;---------------------------------------Pacman---------------------------------------
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
                    (checar-morto-pre)
                )
            )
        )
    )

    ; ------------------------------------------------FantasmaRed---------------------------------

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
    ;-----------------------------------ComerFantasmaRed----------------------------------

    (:action comer-fantasma-red
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (not(fantasmaR-morto)) (fantasmaR-em ?px ?py) (frutaR-ativa))
        :effect (and (fantasmaR-morto) (not(frutaR-ativa)))
    )

))";
    G = R"((define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

    (:types
        posicao
    )

    (:predicates
        ; Predicados de Localização
        (pacman-em ?px ?py - posicao)
        (fantasmaG-em ?px ?py - posicao)
        (frutaG-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)

        ; Predicados de liberação
        (pacman-liberado)
        (fantasmaG-liberado)

        ; Predicados de Direção do Fantasma Verde:
        (fantasmaG-up)
        (fantasmaG-right)
        (fantasmaG-down)
        (fantasmaG-left)

        ; Predicados de Checagem de Morte:
        (checar-morto-pre)
        (checar-morto-pos)

        ; Predicados de Incremento/Decremento:
        (inc ?x ?xn)
        (dec ?x ?xn)

        ; Predicados frutas:
        (frutaG-ativa)

        ; Predicados de finalização
        (fantasmaG-morto)
        (pacman-morto)
    )

    ;------------------------------------------Checagem------------------------------------------
    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pre) (pacman-em ?px ?py))
        :effect (and
            (when
                (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                (pacman-morto)
            )
            (not(checar-morto-pre))
            (fantasmaG-liberado)
            (when
                (and (pacman-em ?px ?py)(frutaG-em ?px ?py))
                (and(frutaG-ativa) (not(frutaG-em ?px ?py))))
        )
    )
    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pos) (pacman-em ?px ?py))
        :effect (and
            (when
                (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py))
                (pacman-morto)
            )
            (not(checar-morto-pos))
            (pacman-liberado)
        )
    )
    ;---------------------------------------Pacman----------------------------------------
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
        )
    )

    ; ---------------------------------------GREEN----------------------------------------

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
        :precondition (and (fantasmaG-em ?x ?y) (fantasmaG-liberado) (not(fantasmaG-morto)) (fantasmaG-left) (dec ?x ?xn))
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
                    (checar-morto-pos)

                )
            )

            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaG-liberado)) (not(fantasmaG-right)) (checar-morto-pos))
            )
        )
    )
    ;---------------------------------------ComerFrutaGreen-------------------------------------

    (:action comer-fantasma-Green
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (fantasmaG-em ?px ?py) (frutaG-ativa))
        :effect (and (fantasmaG-morto) (not(frutaG-ativa)))
    )

))";
    B = R"((define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

    (:types
        posicao
    )

    (:predicates
        ; Predicados de Localização
        (pacman-em ?px ?py - posicao)
        (fantasmaB-em ?px ?py - posicao)
        (frutaB-em ?px ?py - posicao)
        (parede-em ?px ?py - posicao)

        ; Predicados de liberação
        (pacman-liberado)
        (fantasmaB-liberado)

        ; Predicados de Direção do Fantasma Azul:
        (fantasmaB-up)
        (fantasmaB-right)
        (fantasmaB-down)
        (fantasmaB-left)

        ; Predicados de Checagem de Morte:
        (checar-morto-pre)
        (checar-morto-pos)

        ; Predicados de Incremento/Decremento:
        (inc ?x ?xn)
        (dec ?x ?xn)

        ; Predicados frutas:
        (frutaB-ativa)

        ; Predicados de finalização
        (fantasmaB-morto)
        (pacman-morto)
    )
    ;----------------------------------------ChecagemPre-----------------------------------------------
    (:action checagem-morto-pre
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pre) (pacman-em ?px ?py))
        :effect (and
            (when
                (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
                (pacman-morto)
            )
            (not(checar-morto-pre))
            (fantasmaB-liberado)
            (when
                (and (pacman-em ?px ?py)(frutaB-em ?px ?py))
                (and(frutaB-ativa) (not(frutaB-em ?px ?py))))

        )
    )
    (:action checagem-morto-pos
        :parameters (?px ?py - posicao)
        :precondition (and (checar-morto-pos) (pacman-em ?px ?py))
        :effect (and
            (when
                (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py))
                (pacman-morto)
            )
            (not(checar-morto-pos))
            (pacman-liberado)
        )
    )
    ;----------------------------------------------Pacman-----------------------------------------------------
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
                    (checar-morto-pre)
                )
            )
        )
    )
    ;-----------------------------------------------FantasmaBlue------------------------------------------------
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaB-liberado)) (not(fantasmaB-up)) (checar-morto-pos))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?x ?yn))
                (and (not(fantasmaB-liberado)) (not(fantasmaB-down)) (checar-morto-pos))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaB-liberado)) (not(fantasmaB-left)) (checar-morto-pos))
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
                    (checar-morto-pos)

                )
            )
            (when
                (and (parede-em ?xn ?y))
                (and (not(fantasmaB-liberado)) (not(fantasmaB-right)) (checar-morto-pos))
            )
        )
    )
    ;--------------------------------------------ComerBlue-------------------------------------------------------

    (:action comer-fantasma-Blue
        :parameters (?px ?py - posicao)
        :precondition (and (pacman-em ?px ?py) (fantasmaB-em ?px ?py) (frutaB-ativa))
        :effect (and (fantasmaB-morto) (not(frutaB-ativa)))
    )

))";
    return 0;
}