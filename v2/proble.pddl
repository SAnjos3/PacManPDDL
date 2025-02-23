 (define (problem pacmanCOMPETICAOTOP)
(:domain pacman)
    (:objects
        x1y1 x2y1 x3y1 x1y2 x2y2 x3y2 x1y3 x2y3 x3y3 - posicao
    )

    (:init
    (pacman-liberado)
    (pacman-em x1y1)
    )    

    (:goal
    (pacman-em x3y3)
    )
)