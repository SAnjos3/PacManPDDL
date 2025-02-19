
(define (problem pacman3x3)
    (:domain pacman)
    (:objects
        x1 x2 x3 x4 x5 y1 y2 y3 y4 y5 - posicao
    )
    (:init
        (pacman-liberado)
        (pacman-em x2 y2)

        (fantasmaR-em x4 y4)
        (fantasmaR-right)
        (frutaR-em x3 y3)

        (fantasmaB-em x3 y4)
        (frutaG-em x4 y2)

        (parede-em x1 y1)
        (parede-em x1 y2)
        (parede-em x1 y3)
        (parede-em x1 y4)
        (parede-em x1 y5)
        (parede-em x2 y1)
        (parede-em x2 y5)
        (parede-em x3 y1)
        (parede-em x3 y5)
        (parede-em x4 y1)
        (parede-em x4 y5)
        (parede-em x5 y1)
        (parede-em x5 y2)
        (parede-em x5 y3)
        (parede-em x5 y4)
        (parede-em x5 y5)

        (inc x1 x2)
        (inc x2 x3)
        (inc x3 x4)
        (inc x4 x5)
        (inc y1 y2)
        (inc y2 y3)
        (inc y3 y4)
        (inc y4 y5)
        (dec x5 x4)
        (dec x4 x3)
        (dec x3 x2)
        (dec x2 x1)
        (dec y5 y4)
        (dec y4 y3)
        (dec y3 y2)
        (dec y2 y1)

    )
    (:goal
        (and
            (not(pacman-morto))
            (fantasmaR-morto)
        )
    )
)