
(define (domain pacman)

    (:requirements :strips :disjunctive-preconditions :typing :conditional-effects :negative-preconditions)

    (:types
        posicao
    )

    (:predicates
        (pacman-em ?p - posicao)
        (fantasmaR-em ?p - posicao)
        (fantasmaG-em ?p - posicao)
        (fantasmaB-em ?p - posicao)

        (pacman-liberado)
        (fantasmaR-liberado)
        (fantasmaG-liberado)
        (fantasmaB-liberado)

        (fantasmaR-morto)
        (fantasmaG-morto)
        (fantasmaB-morto)

    )
    
    (:action move-pacman-x1y1-right
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x1y1))
    :effect (and (not (pacman-em x1y1)) (pacman-em x2y1)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )


    (:action move-pacman-x1y1-down
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x1y1))
    :effect (and (not (pacman-em x1y1)) (pacman-em x1y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y1-left
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y1))
    :effect (and (not (pacman-em x2y1)) (pacman-em x1y1)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y1-right
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y1))
    :effect (and (not (pacman-em x2y1)) (pacman-em x3y1)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y1-down
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y1))
    :effect (and (not (pacman-em x2y1)) (pacman-em x2y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x3y1-left
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x3y1))
    :effect (and (not (pacman-em x3y1)) (pacman-em x2y1)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x3y1-down
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x3y1))
    :effect (and (not (pacman-em x3y1)) (pacman-em x3y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x1y2-right
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x1y2))
    :effect (and (not (pacman-em x1y2)) (pacman-em x2y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x1y2-up
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x1y2))
    :effect (and (not (pacman-em x1y2)) (pacman-em x1y1)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x1y2-down
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x1y2))
    :effect (and (not (pacman-em x1y2)) (pacman-em x1y3)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y2-left
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y2))
    :effect (and (not (pacman-em x2y2)) (pacman-em x1y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y2-right
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y2))
    :effect (and (not (pacman-em x2y2)) (pacman-em x3y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y2-up
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y2))
    :effect (and (not (pacman-em x2y2)) (pacman-em x2y1)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y2-down
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y2))
    :effect (and (not (pacman-em x2y2)) (pacman-em x2y3)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x3y2-left
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x3y2))
    :effect (and (not (pacman-em x3y2)) (pacman-em x2y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x3y2-up
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x3y2))
    :effect (and (not (pacman-em x3y2)) (pacman-em x3y1)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x3y2-down
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x3y2))
    :effect (and (not (pacman-em x3y2)) (pacman-em x3y3)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x1y3-right
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x1y3))
    :effect (and (not (pacman-em x1y3)) (pacman-em x2y3)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x1y3-up
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x1y3))
    :effect (and (not (pacman-em x1y3)) (pacman-em x1y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y3-left
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y3))
    :effect (and (not (pacman-em x2y3)) (pacman-em x1y3)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y3-right
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y3))
    :effect (and (not (pacman-em x2y3)) (pacman-em x1y3)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x2y3-up
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x2y3))
    :effect (and (not (pacman-em x2y3)) (pacman-em x2y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x3y3-left
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x3y3))
    :effect (and (not (pacman-em x3y3)) (pacman-em x2y3)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )

    (:action move-pacman-x3y3-up
    :parameters ()
    :precondition (and (pacman-liberado)(pacman-em x3y3))
    :effect (and (not (pacman-em x3y3)) (pacman-em x3y2)
                (when 
                    (and (not(fantasmaR-morto)))
                    (and (fantasmaR-liberado))
                )

                (when 
                    (and (fantasmaR-morto) (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )
                
                (when 
                    (and (fantasmaR-morto) (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
            )
    )



    (:action move-fantasmaR-x1y1-right
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x1y1))
    :effect (and (not (fantasmaR-em x1y1)) (fantasmaR-em x2y1)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )


    (:action move-fantasmaR-x1y1-down
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x1y1))
    :effect (and (not (fantasmaR-em x1y1)) (fantasmaR-em x1y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y1-left
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y1))
    :effect (and (not (fantasmaR-em x2y1)) (fantasmaR-em x1y1)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y1-right
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y1))
    :effect (and (not (fantasmaR-em x2y1)) (fantasmaR-em x3y1)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y1-down
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y1))
    :effect (and (not (fantasmaR-em x2y1)) (fantasmaR-em x2y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x3y1-left
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x3y1))
    :effect (and (not (fantasmaR-em x3y1)) (fantasmaR-em x2y1)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x3y1-down
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x3y1))
    :effect (and (not (fantasmaR-em x3y1)) (fantasmaR-em x3y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x1y2-right
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x1y2))
    :effect (and (not (fantasmaR-em x1y2)) (fantasmaR-em x2y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x1y2-up
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x1y2))
    :effect (and (not (fantasmaR-em x1y2)) (fantasmaR-em x1y1)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x1y2-down
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x1y2))
    :effect (and (not (fantasmaR-em x1y2)) (fantasmaR-em x1y3)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y2-left
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y2))
    :effect (and (not (fantasmaR-em x2y2)) (fantasmaR-em x1y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y2-right
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y2))
    :effect (and (not (fantasmaR-em x2y2)) (fantasmaR-em x3y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y2-up
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y2))
    :effect (and (not (fantasmaR-em x2y2)) (fantasmaR-em x2y1)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y2-down
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y2))
    :effect (and (not (fantasmaR-em x2y2)) (fantasmaR-em x2y3)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x3y2-left
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x3y2))
    :effect (and (not (fantasmaR-em x3y2)) (fantasmaR-em x2y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x3y2-up
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x3y2))
    :effect (and (not (fantasmaR-em x3y2)) (fantasmaR-em x3y1)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x3y2-down
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x3y2))
    :effect (and (not (fantasmaR-em x3y2)) (fantasmaR-em x3y3)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x1y3-right
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x1y3))
    :effect (and (not (fantasmaR-em x1y3)) (fantasmaR-em x2y3)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x1y3-up
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x1y3))
    :effect (and (not (fantasmaR-em x1y3)) (fantasmaR-em x1y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y3-left
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y3))
    :effect (and (not (fantasmaR-em x2y3)) (fantasmaR-em x1y3)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y3-right
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y3))
    :effect (and (not (fantasmaR-em x2y3)) (fantasmaR-em x1y3)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x2y3-up
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x2y3))
    :effect (and (not (fantasmaR-em x2y3)) (fantasmaR-em x2y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x3y3-left
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x3y3))
    :effect (and (not (fantasmaR-em x3y3)) (fantasmaR-em x2y3)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )

    (:action move-fantasmaR-x3y3-up
    :parameters ()
    :precondition (and (fantasmaR-liberado)(fantasmaR-em x3y3))
    :effect (and (not (fantasmaR-em x3y3)) (fantasmaR-em x3y2)
                (when 
                    (and (not(fantasmaG-morto)))
                    (and (fantasmaG-liberado))
                )

                (when 
                    (and (fantasmaG-morto) (not(fantasmaB-morto)))
                    (and (fantasmaB-liberado))
                )
                
                (when 
                    (and (fantasmaG-morto) (fantasmaB-morto))
                    (and (pacman-liberado))
                )
            )
    )
)
    