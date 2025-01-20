# 🌟 Script de Exportação de Banco de Dados - Atividade Avaliativa de Sistemas Operacionais II

Este script foi desenvolvido como parte da atividade avaliativa da disciplina **Sistemas Operacionais II**, no **4º semestre de 2024** do curso **Análise e Desenvolvimento de Sistemas** da **Fatec Jales**.

**Clique na imagem abaixo para assistir ao vídeo explicativo! 🎥**

[![Vídeo da Atividade](https://img.youtube.com/vi/bRVFAnvon7U/0.jpg)](https://www.youtube.com/watch?v=bRVFAnvon7U)

---

## 🚀 Preparando o Ambiente de Execução

Antes de colocar a mão na massa e rodar o script, você vai precisar preparar o seu ambiente. Não se preocupe, dividi o processo em duas etapas: **Configuração do Banco de Dados** e **Configuração do Sistema Operacional**.

### 🖥️ Configuração do Banco de Dados

1. **Baixe e instale o SQL Server 2016**
   - Comece pelo básico! Baixe o **SQL Server 2016** e instale-o em sua máquina. (Se você já tem ele, pode pular essa parte.)

2. **Configuração da Porta do Banco**
   - Abra o **SQL Server Management Studio 2016** e configure a porta que o banco vai utilizar.
   - Vá até os **Protocolos para sua Instância**, clique com o botão direito em **TCP/IP > Propriedades > Aba "IP Addresses"** e configure a **porta TCP** (sugiro 1433 ou 1435 para facilitar). 
     - *Dica:* Isso garante que seu banco fique acessível na rede!
   - Após configurar, reinicie a instância para garantir que tudo esteja funcionando direitinho.

   ![Configuração Porta](https://github.com/user-attachments/assets/c6c5f7f5-b362-4d13-8456-fae80a2d43b9)

3. **Abra a Porta no Firewall**
   - Pressione `Win + R`, digite **firewall.cpl** e pressione Enter.
   - **Abra a porta configurada** no Firewall, como mostrado no GIF abaixo:
   ![GIF Firewall](https://github.com/user-attachments/assets/728f4b17-3225-4384-8eb7-d1a1dc4b337c)

4. **Criação do Banco de Dados e Usuário**
   - Crie um novo **usuário** (por exemplo: `teste` | senha: `123456`).
   - Crie o **banco de dados** a ser utilizado no script e garanta que ele tenha as permissões necessárias.
   - Permita que softwares de terceiros (como o seu script) utilizem o banco com o login do usuário criado.

   ![Criação Banco](https://github.com/user-attachments/assets/7b8a496d-9f2c-4155-8ca0-8eff8c6528c6)

### 🖥️ Configuração do Sistema Operacional

1. **Baixe o PowerShell 7**
   - Vá até a **Microsoft Store** e baixe o **PowerShell 7**. É uma ferramenta essencial para rodar o script e facilitar a automação!

   ![Powershell 7](https://github.com/user-attachments/assets/c7c94eac-6682-47a0-9320-b8c2f17d598b)

2. **Permita a Execução de Scripts no PowerShell**
   - Abra o PowerShell 7 e execute o seguinte comando para garantir que você possa rodar o script sem problemas:

   ```powershell 
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
   ```

### 3. **Configure o Arquivo .env**

   - Finalmente, configure o arquivo **`.env`** com as informações do seu banco de dados: instância, nome do banco, usuário e senha. Não esqueça de salvar as alterações!

   ![Configuração .env](https://github.com/user-attachments/assets/3ac0b6ec-3e70-43fa-98cf-9ffc2e805198)

---

Agora, com o ambiente todo configurado, você está pronto para rodar o script e começar os testes! 🚀

Se precisar de ajuda, tem alguma dúvida ou quer sugerir melhorias? Fique à vontade para abrir uma **issue** ou me chamar para bater um papo! 😄

---

**Um bom trabalho e que o código esteja com você!** 👨‍💻💻
