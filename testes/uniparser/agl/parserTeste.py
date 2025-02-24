import sys, os

directions = {"up": (0, -1), "down": (0, 1), "left": (-1, 0), "right": (1, 0)}

def in_mapa(x, y, w, h):
    return 1 <= x <= w and 1 <= y <= h

def move_gelo(x, y, dx, dy, mapa, w, h):
    cx, cy = x, y
    while True:
        nx, ny = cx + dx, cy + dy
        if not in_mapa(nx, ny, w, h): break
        if mapa[ny-1][nx-1] != "I": break
        cx, cy = nx, ny
    return cx, cy

def linkar_portais(mapa, w, h):
    ports = []
    for y in range(1, h+1):
        for x in range(1, w+1):
            if mapa[y-1][x-1] == "O":
                ports.append((x, y))
    pairs = {}
    if len(ports) % 2 == 0:
        for i in range(0, len(ports), 2):
            a, b = ports[i], ports[i+1]
            pairs[a] = b
            pairs[b] = a
    return pairs

def gerar_acoes_pacman(x, y, d, mapa, w, h, portais):
    dx, dy = directions[d]
    name = f"move-pacman-x{x}y{y}-{d}"
    pre = f"""(and (pacman-em  x{x}y{y}) (turno-pacman) (not (check-turno)) )"""
    tx, ty = x + dx, y + dy
    if (not in_mapa(tx, ty, w, h)) or (mapa[ty-1][tx-1] == "#"):
        fx, fy = x, y
        extra = ""
    else:
        cell = mapa[ty-1][tx-1]
        if cell == "O" and (tx, ty) in portais:
            fx, fy = portais[(tx, ty)]
            extra = ""
        elif cell == "I":
            fx, fy = move_gelo(tx, ty, dx, dy, mapa, w, h)
            extra = ""
        else:
            fx, fy = tx, ty
            extra = ""
        if cell in ["!", "@", "$"]:
            fruit = "R" if cell == "!" else "G" if cell == "@" else "B"
            extra = (f"\n                (fruta{fruit}-ativa)"
                    f"\n                (not (frutaR-ativa))"
                    f"\n                (not (frutaG-ativa))"
                    f"\n                (not (frutaB-ativa))")
    if d == "up":
        ghost_eff = "(fantasmaB-down) (fantasmaG-up) (fantasmaR-right)"
    elif d == "down":
        ghost_eff = "(fantasmaB-up) (fantasmaG-down) (fantasmaR-left)"
    elif d == "left":
        ghost_eff = "(fantasmaB-right) (fantasmaG-left) (fantasmaR-up)"
    elif d == "right":
        ghost_eff = "(fantasmaB-left) (fantasmaG-right) (fantasmaR-down)"
    eff = (f"""
            (and 
            (when (and (pacman-perigo ?p)) (and (pacman-morto)))
        
            (not (pacman-em  x{x}y{y})) (check-turno) (pacman-em  x{fx}y{fy}) {extra} 
        {ghost_eff})""")
    return f"""
    (:action {name}    
    :parameters ()    
    :precondition {pre}   
    :effect {eff}
    )"""

def generate_domain(mapa, w, h, portais):
    lines = []
    cnts = set()
    for y in range(1, h+1):
        for x in range(1, w+1):
            if mapa[y-1][x-1] != "#":
                cnts.add(f"x{x}y{y}")
    lines.append("(define (domain pacmanNew)")
    lines.append("  (:requirements :strips :negative-preconditions :typing :disjunctive-preconditions :conditional-effects :derived-predicates)")
    lines.append("  (:types posicao)")
    lines.append("  (:constants")
    lines.append("       " + " ".join(sorted(cnts)) + " - posicao")
    lines.append("  )")
    lines.append("  (:predicates")
    lines.append("       (pacman-em  ?p - posicao)")
    lines.append("       (fantasmaR-em ?p - posicao)")
    lines.append("       (fantasmaG-em ?p - posicao)")
    lines.append("       (fantasmaB-em ?p - posicao)")
    lines.append("       (frutaR-ativa)")
    lines.append("       (frutaG-ativa)")
    lines.append("       (frutaB-ativa)")
    lines.append("       (check-turno)")
    lines.append("       (pacman-morto)")
    lines.append("       (fantasmaR-morto)")
    lines.append("       (fantasmaG-morto)")
    lines.append("       (fantasmaB-morto)")
    lines.append("       (turno-pacman)")
    lines.append("       (turno-red)")
    lines.append("       (turno-green)")
    lines.append("       (turno-blue)")
    lines.append("       (pacman-perigo ?p - posicao)")
    lines.append("       (left ?p1 - posicao ?p2 - posicao)")
    lines.append("       (right ?p1 - posicao ?p2 - posicao)")
    lines.append("       (up ?p1 - posicao ?p2 - posicao)")
    lines.append("       (down ?p1 - posicao ?p2 - posicao)")
    lines.append("       (fantasmaR-up)")
    lines.append("       (fantasmaR-down)")
    lines.append("       (fantasmaR-left)")
    lines.append("       (fantasmaR-right)")
    lines.append("       (fantasmaG-up)")
    lines.append("       (fantasmaG-down)")
    lines.append("       (fantasmaG-left)")
    lines.append("       (fantasmaG-right)")
    lines.append("       (fantasmaB-up)")
    lines.append("       (fantasmaB-down)")
    lines.append("       (fantasmaB-left)")
    lines.append("       (fantasmaB-right)")
    lines.append("  )")
    lines.append("""
        (:derived
        (pacman-perigo ?p - posicao)
        (or
            (and
                (pacman-em ?p)
                (fantasmaR-em ?p)
                (not (frutaR-ativa)))
            (and
                (pacman-em ?p)
                (fantasmaG-em ?p)
                (not (frutaG-ativa)))
            (and
                (pacman-em ?p)
                (fantasmaB-em ?p)
                (not (frutaB-ativa)))
        ))""")
    lines.append(f"""
    (:action comer-fantasma-red
    :parameters (?p - posicao)
    :precondition(and (pacman-em ?p)(fantasmaR-em ?p) (frutaR-ativa)
        (not(frutaB-ativa))
        (not(frutaG-ativa)))
    :effect(and (check-turno)(fantasmaR-morto)
        (not(frutaR-ativa))
        (not(fantasmaR-em ?p))))

    (:action comer-fantasma-green
    :parameters (?p - posicao)
    :precondition(and (pacman-em ?p)(fantasmaG-em ?p) (frutaG-ativa)
        (not(frutaB-ativa))
        (not(frutaR-ativa)))
    :effect(and (check-turno)(fantasmaG-morto)
        (not(frutaG-ativa))
        (not(fantasmaG-em ?p))))
    
    (:action comer-fantasma-blue
    :parameters (?p - posicao)
    :precondition(and (pacman-em ?p) (fantasmaB-em ?p) (frutaB-ativa)
        (not(frutaR-ativa))
        (not(frutaG-ativa)))
    :effect(and (check-turno)(fantasmaB-morto)
        (not(frutaB-ativa))
        (not(fantasmaB-em ?p))))""")
    
    for y in range(1, h+1):
        for x in range(1, w+1):
            if mapa[y-1][x-1] != "#":
                for d in directions.keys():
                    lines.append(gerar_acoes_pacman(x,y,d,mapa,w,h,portais))

    for ghost in ["fantasmaR-em", "fantasmaG-em", "fantasmaB-em"]:
        for d in directions.keys():
            name = f"{ghost}-{d}"
            if ghost=="fantasmaR-em":
                turn, next_eff = "turno-red", {"up":"right","down":"left","left":"up","right":"down"}[d]
            elif ghost=="fantasmaG-em":
                turn, next_eff = "turno-green", d
            else:
                turn, next_eff = "turno-blue", {"up":"down","down":"up","left":"right","right":"left"}[d]

            pre = f"(and ({turn}) (not (check-turno)) ({ghost} ?p1) ({d} ?p1 ?p2))"
            eff = f"(and (not ({ghost} ?p1)) ({ghost} ?p2) (when (and (pacman-em  ?p2) ({ghost} ?p2)) (pacman-morto)))"
            lines.append(f"(:action {name}\n    :parameters (?p1 - posicao ?p2 - posicao)\n    :precondition {pre}\n    :effect {eff}\n)\n")
            
    for turn, nxt, agnt in [("turno-pacman","turno-red",""), ("turno-red","turno-green","(fantasmaR-morto)"), ("turno-green","turno-blue","(fantasmaG-morto)"), ("turno-blue","turno-pacman","(fantasmaB-morto)")]:
        lines.append(f"""
                    (:action avancar-turno-{turn}
                        :parameters ()\n    
                        :precondition (and (check-turno) (or ({turn}) (and({turn}){agnt}) ) (not (pacman-morto)))    
                        :effect (and (not (check-turno)) (not ({turn})) ({nxt}))
                    )""")

    lines.append(")")
    return "\n".join(lines)

def generate_problem(mapa, w, h):
    lines = []
    lines.append("(define (problem pacmanNewProblem)")
    lines.append("  (:domain pacmanNew)")
    lines.append("  (:init")
    pac_found = False
    for y in range(1, h+1):
        for x in range(1, w+1):
            cell = mapa[y-1][x-1]
            if cell == 'P':
                lines.append(f"       (pacman-em  x{x}y{y})")
            if cell == 'R':
                lines.append(f"       (fantasmaR-em x{x}y{y})")
            if cell == 'G':
                lines.append(f"       (fantasmaG-em x{x}y{y})")
            if cell == 'B':
                lines.append(f"       (fantasmaB-em x{x}y{y})")
    lines.append("       (turno-pacman)")
    lines.append("       (not (frutaR-ativa))")
    lines.append("       (not (frutaG-ativa))")
    lines.append("       (not (frutaB-ativa))")
    for y in range(1, h+1):
        for x in range(1, w+1):
            if mapa[y-1][x-1] != "#":
                for d, (dx, dy) in directions.items():
                    nx, ny = x+dx, y+dy
                    if in_mapa(nx, ny, w, h) and mapa[ny-1][nx-1] != "#":
                        lines.append(f"       ({d} x{x}y{y} x{nx}y{ny})")
    lines.append("  )")
    lines.append("""  (:goal (and (not (pacman-morto))
        (fantasmaR-morto)
        (fantasmaG-morto)
        (fantasmaB-morto))
                )""")
    lines.append(")")
    return "\n".join(lines)

def main():
    entrada = sys.stdin.read()
    mapa = entrada.strip().split("\n")
    if not mapa:
        sys.exit(1)
    h = len(mapa)
    w = len(mapa[0])
    portais = linkar_portais(mapa, w, h)
    dom = generate_domain(mapa, w, h, portais)
    prob = generate_problem(mapa, w, h)
    with open("domainNew.pddl", "w") as f:
        f.write(dom)
    with open("problemNew.pddl", "w") as f:
        f.write(prob)
    print("Arquivos gerados.")

if __name__ == "__main__":
    main()