# Hlestlock - Analisador de Log

 ![image](https://github.com/user-attachments/assets/50031d32-3d5f-4766-ba96-1a251e094a2b)



## Descrição
O **Hlestlock** é um script em Bash que permite analisar arquivos de log de servidores **apache2**. Ele fornece várias funcionalidades, como listar IPs que acessaram o servidor, contar acessos por recurso, identificar User-Agents utilizados, e muito mais. Este script é útil para administradores de sistemas e desenvolvedores que desejam monitorar e entender melhor o tráfego de seus servidores.

## Pré-requisitos
- Um sistema operacional baseado em Unix (Linux, macOS, etc.)
- Bash instalado
- Um arquivo de log no formato adequado (extensão `.log`)

## Instalação
1. Clone este repositório:
   ```bash
   git clone https://github.com/robersonrodrigo/hlestlock-analyzer
   cd hlestlock-analyzer
   
2. Dê permissão de execução ao script:
   ```bash
   chmod +x hlestlock-analyzer.sh

## Uso
 Para executar o script, utilize o seguinte comando:
   ```bash
   ./hlestlock-analyzer.sh /caminho/do/arquivo.log

## Funcionalidades

O script oferece um menu interativo com as seguintes opções:

    Listar IPs: Mostra todos os IPs que acessaram o servidor e a quantidade de acessos.
    Quantidade de acessos por recurso: Exibe a quantidade de acessos por recurso para cada IP.
    User-Agents utilizados por IP: Lista os User-Agents utilizados por cada IP.
    Ferramentas utilizadas pelos IPs: Identifica ferramentas como curl, wget, nmap, etc., utilizadas pelos IPs.
    Procurar acesso por arquivo: Permite procurar por acessos a arquivos específicos no log.
    Primeiro/Último acesso por IP: Mostra o primeiro e o último acesso de cada IP.
    Sair: Encerra o script e limpa arquivos temporários.

## Contribuição

   Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request.
   
## Créditos

    Desenvolvedor Principal: ZeD 
    
 Roberson Rodrigo - https://github.com/robersonrodrigo/ | https://www.linkedin.com/in/robersonr
     
   Contribuições Especiais:
   Carlos Tuma - https://github.com/carlosalbertotuma | https://www.linkedin.com/in/carlos-tuma

   0ff3ns!v3 S3cur!ty ®
