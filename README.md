# 🎲 Engenharia de Dados 🎲

Aqui você encontra soluções práticas e criativas para automatização de tarefas, manipulação de dados e criação de pipelines, utilizando tecnologias amplamente empregadas no mercado.

## 📂 **Descrição dos Projetos**


### **[📦 Partial Backup](https://github.com/BraceroInSabot/Engenharia-de-Dados/tree/main/Partial%20Backup)**

Realiza backup de todas as tabelas do banco e faz o upload para o serviço S3 Bucket, da AWS.

- **Ferramentas utilizadas**: Airflow, AWS, Docker, Python e SQL (postgres).
- **✨ Funcionalidades principais**:
  - 🔍 Gera arquivos CSV por meio de Querys. Os arquivos são armazenados dentro de um container, que possui uma pasta compartilhada localmente.
  - ☁️ Os arquivos são encaminhados para a nuvem (AWS).
  - ⏱️ Todo este processo pode ter o seu tempo para execução configurado.

---

### **[🔎 SQL Profiler Searcher](https://github.com/BraceroInSabot/Engenharia-de-Dados/tree/main/SQL%20Profiler%20Searcher)**

Analisa e busca eventos específicos em um arquivo de Log gerado pelo SQL Server Profiler (SSMS), facilitando o diagnóstico de problemas.

- **Ferramentas utilizadas**: Python.
- **✨ Funcionalidades principais**:
  - 📂 Importação e processamento de arquivos de log gerados pelo SQL Profiler.
  - 🎯 Filtros personalizáveis por clausula (select, insert, update...).
  - 🗒️ Exportação de Log em TXT.

---

### **[🗄️ Bash Backup](https://github.com/BraceroInSabot/Engenharia-de-Dados/tree/main/Bash%20Backup)**

Realiza backups completos de forma automatizada, garantindo a segurança de arquivos e diretórios.

- **Ferramentas utilizadas**: Shell Script (Bash).
- **✨ Funcionalidades principais**:
  - 🔒 Geração de backups locais.
  - ⚙️ Configurações personalizáveis para quantidade de arquivos.
 
---

### **[📑 XLS para TXT com Formatação CSV](https://github.com/BraceroInSabot/Engenharia-de-Dados/tree/main/XLS%20para%20TXT%20com%20formatacao%20CSV)**

Converte planilhas do Excel (.xls) em formato antigo para arquivos TXT. Serão formatados como CSV, mantendo padrões de estrutura e serão trocados os pontos pela virgula no separador de casa decimal.

- **Ferramentas utilizadas**: Python, Pandas.
- **✨ Funcionalidades principais**:
  - 🛑 Precisa ser analisado antes se não há linhas nulas no conjunto de dados.
  - ✅ Possibilita a leitura de sistemas que necessitam desta formatação.

---

## 🛠️ **Como Utilizar os Projetos**

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git
   ```
2. Navegue até o diretório do projeto desejado:
   ```bash
   cd nome-do-projeto
   ```
3. Siga as instruções do arquivo README dentro de cada pasta para configurar e executar o projeto. 📘

