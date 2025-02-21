import re
regex = re.compile(r"\((move-pacman-|usar-portal-|move-ice-)([a-zA-Z]+) ")

direcoes_mapa = {
    "up" : "N",
    "down" : "S",
    "left" : "W",
    "right" : "E"
}

mov = []
with open("sas_plan", "r") as saida:
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
