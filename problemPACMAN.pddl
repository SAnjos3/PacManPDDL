
    (define (problem pacmanCOMPETICAOTOP)
        (:domain pacman)
        (:objects
        x1 x2 x3 x4 x5 y1 y2 y3 y4 y5 - posicao
		)
    (:init
    (pacman-liberado)
		(parede-em x1 y1)
		(fantasmaR-right)
		(parede-em x1 y2)
		(fantasmaR-right)
		(parede-em x1 y3)
		(fantasmaR-right)
		(parede-em x1 y4)
		(fantasmaR-right)
		(parede-em x1 y5)
		(fantasmaR-right)
		(parede-em x2 y1)
		(fantasmaR-right)
		(pacman-em x2 y2)
		(fantasmaR-right)
		(fantasmaR-right)
		(fantasmaR-right)
		(parede-em x2 y5)
		(fantasmaR-right)
		(parede-em x3 y1)
		(fantasmaR-right)
		(fantasmaR-right)
		(frutaR-em x3 y3)
		(fantasmaR-right)
		(fantasmaR-right)
		(parede-em x3 y5)
		(fantasmaR-right)
		(parede-em x4 y1)
		(fantasmaR-right)
		(fantasmaR-right)
		(fantasmaR-right)
		(fantasmaR-em x4 y4)
		(fantasmaR-right)
		(parede-em x4 y5)
		(fantasmaR-right)
		(parede-em x5 y1)
		(fantasmaR-right)
		(parede-em x5 y2)
		(fantasmaR-right)
		(parede-em x5 y3)
		(fantasmaR-right)
		(parede-em x5 y4)
		(fantasmaR-right)
		(parede-em x5 y5)
		(fantasmaR-right)
		(inc x1 x2)
		(inc x2 x3)
		(inc x3 x4)
		(inc x4 x5)
		(inc y1 y2)
		(inc y2 y3)
		(inc y3 y4)
		(inc y4 y5)
		(dec x2 x1)
		(dec x3 x2)
		(dec x4 x3)
		(dec x5 x4)
		(dec y2 y1)
		(dec y3 y2)
		(dec y4 y3)
		(dec y5 y4)
)
    (:goal
        (and
            (not(pacman-morto))
			(fantasmaR-morto))))