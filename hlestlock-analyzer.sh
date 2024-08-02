#!/bin/bash

# Define cores para formatação
cor_vermelho="\e[1;31m"   # Define vermelho claro e negrito
cor_verde="\e[1;32m"      # Define verde claro e negrito
cor_reset="\e[0m"         # Reseta a formatação para o padrão

# Função para exibir o banner de uso
banner() {
    echo "Uso: ./hlestlock-analyzer.sh /caminho/do/arquivo.log"
}

# Função para exibir o banner principal
banner2() {
    echo -e "\033[31m"
    echo -e ""
    echo -e "   _   _  _           _    _            _              "
    echo -e "  | | | || |         | |  | |          | |             "
    echo -e "  | |_| || | ___  ___| |_ | | ___   ___| |_            "
    echo -e "  |  _  || |/ _ \/ __| __|| |/ _ \ / __| __|           "
    echo -e "  | | | || |  __/\__ \ |_ | | (_) | (__| |_            "
    echo -e "  \_| |_/|_|\___||___/\__||_|\___/ \___|\__|  v1.0.0   "
    echo -e "                                                        "
    echo -e "                  Log Analyzer                          "
    echo -e "                  Developed by ZeD                      "
    echo ""   
    echo -e "\033[0m"
}

# Verifica se o arquivo de log é válido e tem permissão de leitura
validar_arquivo() {
    if [[ -r "$1" && "$1" == *.log ]]; then
        return 0
    else
        echo "Arquivo de log inválido ou sem permissão de leitura"
        banner
        exit 1
    fi
}

# Gera um array contendo os IPs únicos
gerar_array_ips() {
    mapfile -t ips < <(cut -d " " -f 1 "$1" | sort -u)
}

# Listar IPs e quantidades de acesso
listar_ips() {
    clear 
    banner2
    echo -e -n "${cor_vermelho}IPs que acessam o servidor${cor_reset} | "
    # Exibir a quantidade de acessos
    echo -e "${cor_verde}Quantidade de acessos${cor_reset}"
    echo ""	
    # Processar e exibir os IPs e suas quantidades de acesso
    cut -d " " -f 1 "$1" | grep -v ":" | sort | uniq -c | sort -unr | while read -r count ip; do
        echo -e "${cor_vermelho}${ip}${cor_reset}  -  ${cor_verde}${count}${cor_reset} Acessos${cor_reset}"
    done
}

# Mostrar quantidade de acessos por recurso
acessos_por_recurso() {
    clear
    banner2
    echo -e "${cor_vermelho}Quantidade de acessos por recurso${cor_reset}"
    awk '{print $7}' "$1" | sort | uniq -c | sort -nr | head -n 20
}

# Mostrar User-Agents utilizados por IP
user_agents_por_ip() {
    clear
    banner2
    for ip in "${ips[@]}"; do
        echo -e "${cor_verde}User-Agents utilizados pelo IP: $ip${cor_reset}"
        grep "$ip" "$1" | cut -d '"' -f 6-10 | cut -d '"' -f 1 | sort | uniq -c
    done
}

# Identificar ferramentas utilizadas pelos IPs
ferramentas_por_ip() {
    clear
    banner2
    for ip in "${ips[@]}"; do
        echo -e "${cor_vermelho}Ferramentas utilizadas pelo IP: $ip${cor_reset}"
        grep "$ip" "$1" | cut -d '"' -f 6-10 | egrep -oi "AppleWebKit|nmap|curl|wget|nikto" | sort -u
    done
}

# Procurar acessos por arquivo
procurar_acesso_por_arquivo() {
    clear
    banner2
    echo -e "${cor_vermelho}Qual arquivo deseja procurar?${cor_reset}"
    echo -e "${cor_verde}Ex: passwords.txt${cor_reset}"
    read -r arquivo
    grep -i "$arquivo" "$1" | sort -u
}

# Mostrar primeiro e último acesso por IP
primeiro_ultimo_acesso() {
    clear
    banner2
    for ip in "${ips[@]}"; do
        echo -e "${cor_verde}Primeiro acesso do IP: $ip${cor_reset}"
        grep "$ip" "$1" | head -n1
        echo -e "${cor_verde}Último acesso do IP: $ip${cor_reset}"
        grep "$ip" "$1" | tail -n1
    done
}

# Função para exibir o menu
exibir_menu() {
	echo ""
	echo -e "${cor_verde}Menu:${cor_reset}"
	echo ""
	echo -e "[1] - Listar endereços IP"
	echo -e "[2] - Quantidade de acessos por recurso"
	echo -e "[3] - Exibir User-Agents utilizados por endereço IP"
	echo -e "[4] - Exibir ferramentas utilizadas pelos endereços IP"
	echo -e "[5] - Pesquisar por acesso a um arquivo específico"
	echo -e "[6] - Exibir primeiro e último acesso por endereço IP"
	echo -e "[7] - Sair"
	echo ""
}

# Função principal
main() {
    if [ "$#" -ne 1 ]; then
        banner
        exit 1
    fi

    validar_arquivo "$1"
    gerar_array_ips "$1"

    while true; do
        exibir_menu
        echo -e -n "${cor_verde}Escolha uma opção: ${cor_reset}"
        read -r opcao
        case "$opcao" in
            1) listar_ips "$1" ;;
            2) acessos_por_recurso "$1" ;;
            3) user_agents_por_ip "$1" ;;
            4) ferramentas_por_ip "$1" ;;
            5) procurar_acesso_por_arquivo "$1" ;;
            6) primeiro_ultimo_acesso "$1" ;;
            7) 
                echo "Saindo..."
                exit 0
                ;;
            *) 
                echo "Opção inválida, tente novamente."
                ;;
        esac
        echo ""
    done
}

banner2
main "$@"
