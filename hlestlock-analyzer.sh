#!/bin/bash

# Localização do arquivo de log do Apache
LOG_FILE="/var/log/apache2/access.log"

# Função para imprimir o banner
print_banner() {
  echo -e "\033[31m"
  echo -e "                                                         "
  echo -e "   _   _   _           _     _            _              "
  echo -e "  | | | | | |         | |   | |          | |             "
  echo -e "  | |_| | | | ___  ___| |_  | | ___   ___| |_            "
  echo -e "  |  _  | | |/ _ \/ __| __| | |/ _ \ / __| __|           "
  echo -e "  | | | | | |  __/ \__ \ |_ | | (_) | (__| |_            "
  echo -e "  \_| |_/ |_|\___| |___/\__||_|\___/ \___|\__|  v1.0.0   "
  echo -e "                                                         "
  echo -e "                   Log Analyzer                          "
  echo -e "                   Developed by ZeD                      "
  echo -e "                                                         "
  echo -e "\033[0m"
}

# Função para imprimir separador
print_separator() {
  echo "------------------------------------------------------------"
}

# Função para verificar se o arquivo de log existe
check_log_file() {
  if [[ ! -f $LOG_FILE ]]; then
    echo "Arquivo de log não encontrado!"
    exit 1
  fi
}

# Função para análise de IPs mais frequentes
analyze_top_ips() {
  clear
  echo "Top 10 IPs que acessaram o servidor:"
  awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10
  print_separator
}

# Função para análise de URLs mais acessadas
analyze_top_urls() {
  clear
  echo "Top 10 URLs mais acessadas:"
  awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10
  print_separator
}

# Função para análise de agentes de usuário mais comuns
analyze_user_agents() {
  clear
  echo "Top 10 Agentes de Usuário (Browsers):"
  awk -F\" '{print $6}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10
  print_separator
}

# Função para análise de erros mais comuns
analyze_common_errors() {
  clear
  echo "Erros mais comuns:"
  awk '{print $9}' $LOG_FILE | grep "^ *[45]" | sort | uniq -c | sort -nr | head -n 10
  print_separator
}

# Função para análise de picos de tráfego por hora
analyze_traffic_peaks() {
  clear
  echo "Picos de tráfego por hora:"
  awk '{print $4}' $LOG_FILE | cut -d: -f2 | sort | uniq -c | sort -nr | head -n 10
  print_separator
}

# Função para análise de códigos de status HTTP
analyze_http_status() {
  clear
  echo "Distribuição dos códigos de status HTTP:"
  awk '{print $9}' $LOG_FILE | sort | uniq -c | sort -nr
  print_separator
}

# Função para identificar possíveis tentativas de SQL Injection
analyze_sql_injection() {
  clear
  echo "Possíveis tentativas de SQL Injection:"
  grep -Ei "union.*select.*|\'.*or.*1=1" $LOG_FILE
  print_separator
}

# Função para identificar possíveis tentativas de RFI
analyze_rfi() {
  clear
  echo "Possíveis tentativas de Remote File Inclusion (RFI):"
  grep -Ei "((http|https):\/\/|ftp:\/\/)" $LOG_FILE
  print_separator
}

# Função para identificar possíveis tentativas de LFI
analyze_lfi() {
  clear
  echo "Possíveis tentativas de Local File Inclusion (LFI):"
  grep -Ei "(\/\.\.\/|\/etc\/passwd)" $LOG_FILE
  print_separator
}

# Função para identificar possíveis tentativas de scanners de vulnerabilidade
analyze_scanners() {
  clear
  echo "Possíveis tentativas de Scanners de Vulnerabilidade (Nikto, Nmap, etc.):"
  grep -Ei "nikto|nmap|acunetix|w3af|nessus" $LOG_FILE
  print_separator
}

# Função para identificar possíveis tentativas de brute force
analyze_brute_force() {
  clear
  echo "Possíveis tentativas de Brute Force:"
  awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | awk '$1 > 100'
  print_separator
}

# Função para análise de tráfego por método HTTP
analyze_http_methods() {
  clear
  echo "Distribuição de métodos HTTP:"
  awk '{print $6}' $LOG_FILE | cut -d'"' -f2 | sort | uniq -c | sort -nr
  print_separator
}

# Função para contagem de bytes transferidos
analyze_byte_transfer() {
  clear
  echo "Total de bytes transferidos por IP:"
  awk '{print $1, $10}' $LOG_FILE | awk '{arr[$1]+=$2} END {for (i in arr) print arr[i], i}' | sort -nr | head -n 10
  print_separator
}

# Função para exibir o menu
show_menu() {
  echo "Selecione uma opção:"
  echo ""
  echo " 1) Top 10 IPs que acessaram o servidor"
  echo " 2) Top 10 URLs mais acessadas"
  echo " 3) Top 10 Agentes de Usuário (Browsers)"
  echo " 4) Erros mais comuns"
  echo " 5) Picos de tráfego por hora"
  echo " 6) Distribuição dos códigos de status HTTP"
  echo " 7) Possíveis tentativas de SQL Injection"
  echo " 8) Possíveis tentativas de Remote File Inclusion (RFI)"
  echo " 9) Possíveis tentativas de Local File Inclusion (LFI)"
  echo "10) Possíveis tentativas de Scanners de Vulnerabilidade"
  echo "11) Possíveis tentativas de Brute Force"
  echo "12) Distribuição de métodos HTTP"
  echo "13) Total de bytes transferidos por IP"
  echo "14) Sair"
  echo ""
}

# Função principal
main() {
  # Imprimir o banner
  print_banner

  # Verificar se o arquivo de log existe
  check_log_file

  # Loop principal para exibir o menu e processar a escolha do usuário
  while true; do
    # Exibir o menu
    show_menu

    # Ler a escolha do usuário
    read -p "Digite a sua escolha [1-14]: " choice

    # Processar a escolha do usuário
    case $choice in
      1) analyze_top_ips ;;
      2) analyze_top_urls ;;
      3) analyze_user_agents ;;
      4) analyze_common_errors ;;
      5) analyze_traffic_peaks ;;
      6) analyze_http_status ;;
      7) analyze_sql_injection ;;
      8) analyze_rfi ;;
      9) analyze_lfi ;;
      10) analyze_scanners ;;
      11) analyze_brute_force ;;
      12) analyze_http_methods ;;
      13) analyze_byte_transfer ;;
      14) echo "Saindo..." ; exit 0 ;;
      *) echo "Opção inválida. Por favor, tente novamente." ;;
    esac
  done
}

# Executar a função principal
main
