# Log Analyzer

Um script Bash para análise de logs. Este script permite que você visualize várias métricas e informações sobre o tráfego e possíveis ataques em seus logs.

## Funcionalidades

- **Top 10 IPs que acessaram o servidor**
- **Top 10 URLs mais acessadas**
- **Top 10 Agentes de Usuário (Browsers)**
- **Erros mais comuns**
- **Picos de tráfego por hora**
- **Distribuição dos códigos de status HTTP**
- **Possíveis tentativas de SQL Injection**
- **Possíveis tentativas de Remote File Inclusion (RFI)**
- **Possíveis tentativas de Local File Inclusion (LFI)**
- **Possíveis tentativas de Scanners de Vulnerabilidade**
- **Possíveis tentativas de Brute Force**
- **Distribuição de métodos HTTP**
- **Total de bytes transferidos por IP**

## Como Usar

1. Certifique-se de que você tenha permissões de leitura para o arquivo de log.
2. Altere a variável `LOG_FILE` para o caminho correto do arquivo de log, se necessário.
3. Torne o script executável:
   ```bash
   chmod +x hlestlock-analyzer.sh
