import typing as typ
import xmltodict
import os

def get_querys_from_xml(file, type) -> typ.List[str]:
    """
    Função que lê um arquivo XML e retorna as querys encontradas

    Args:
        file (lista): Lista contendo as querys executadas
    """
    querys = []
    

    with open(file=file, mode="r", errors="ignore", encoding='utf-8') as f:
        data = xmltodict.parse(f.read())

        eventos = data['TraceData']['Events']['Event']
        # eventos.pop()

        for e in range(len(eventos)):
            # pprint.pprint(e)
            for l in eventos[e]['Column']:
                # pprint.pprint(l)
                if l['@name'] == 'TextData':
                    # pprint.pprint(l['#text'])
                    for query in [type.lower(), type.title(), type.upper()]:
                        if query in l["#text"]:
                            querys.append(l['#text'])
                        elif query is None:
                            continue
    
    return querys


def create_querys_file(querys: typ.List[str]) -> None:
    """
    Cria um arquivo com as querys encontradas no XML

    Args:
        querys (lista): Querys contendo as consultas encontradas no XML
    """
    
    if not os.path.exists("./resultado"):
        os.makedirs("./resultado")

    with open("./resultado/log.txt", "w") as f:
        for q in range(len(querys)):
            f.write(f"\n=======================  INICIO Query [{q}]  =======================\n\n")
            f.write(querys[q])
            f.write(f"\n\n=======================  FIM Query [{q}]  =======================\n\n")

def main():
    """
    Função principal
    """
    FILE = "XMLEXEMPLO.xml"
    TYPE = "SELECT"
    querys = get_querys_from_xml(FILE, TYPE)
    create_querys_file(querys)


if __name__ == "__main__":
    main()

