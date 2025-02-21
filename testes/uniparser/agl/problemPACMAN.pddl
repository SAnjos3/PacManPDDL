
    (define (problem pacmanCOMPETICAOTOP)
        (:domain pacman)
        (:objects
        x1 x2 x3 x4 x5 y1 - posicao
		)
    (:init
    (turno-pacman)
		(pacman-em x1 y1)
		(parede-em x2 y1)
		(fantasmaG-em x3 y1)
		(parede-em x4 y1)
		(frutaR-em x5 y1)
		(fantasmaR-morto)
		(fantasmaB-morto)
		(inc x1 x2)
		(inc x2 x3)
		(inc x3 x4)
		(inc x4 x5)
		(dec x2 x1)
		(dec x3 x2)
		(dec x4 x3)
		(dec x5 x4)
)
    (:goal
        (and
            (not(pacman-morto))
			(fantasmaG-morto))))