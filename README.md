<h1><span style="color:#2d7eea">Trial Looker - PBH - Dados Abertos </span></h1>

<h2><span style="color:#2d7eea">Sobre os dados</span></h2>

Foi escolhido um conjunto de dados presentes no [portal de dados abertos da prefeitura de belo horizonte](https://dados.pbh.gov.br).
O conjunto de dados escolhido foi os dados de [Atendimentos em editais públicos](https://dados.pbh.gov.br/dataset/atendimentos-em-editais-publicos)

<h3><span style="color:#2d7eea">Atendimentos em editais públicos PBH</span></h3>

Número de aprovados através dos editais executados pela Secretaria Municipal de Cultura (SMC): BH nas Telas - Fundo e Lei Municipal de Incentivo à Cultura (LMIC). A periodicidade de publicação prevista é anual.
- [2020 - Dados sobre atendimentos editais públicos](https://dados.pbh.gov.br/dataset/atendimentos-em-editais-publicos/resource/2ec9a51e-6c6d-4f5b-b6ca-06cdb58f8718)
- [Dicionário de dados: Dados sobre atendimento](https://dados.pbh.gov.br/dataset/atendimentos-em-editais-publicos/resource/57ab8add-530c-4ae7-b83f-a4d3adf48592)

<h4><span style="color:#2d7eea">Dicionário de dados</span></h4>

| Nome do atributo | Tipo | Descrição do campo |
|----------|:-------------:|------:|
| INSCRICAO | Texto | Número de inscrição do projeto gerado pelo Mapa Cultural. Plataforma utilizada para gestão do espaço cultural pelo sistema de cultura.|
| EDITAL | Texto |  Mecanismo no qual o projeto foi inscrito. No ano de 2020 houve o BH nas telas e LMIC. |
| SETOR | Texto | Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura. |
| TIPO_EMPREEN | Texto | Perfil do empreendedor como pessoa física ou jurídica. |
| EMPREEN_APROVOU PROJETO ANTES |Texto | Demonstra experiência prévia do empreendedor na inscrição de projetos. |
| IDADE | Número | Idade do empreendedor. |
| PROJETO NOVO | Texto | Indica se o projeto é inédito ou sua primeira edição. |
| PERFIL_PUBLICO |Text | Público alvo que pretende atender através do projeto (qualitativo). |
| ESTIMATIVA_PUBLICO |Texto | Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender. |
| PROFISSIONAIS | Número | Número de contratações que são geradas com a execução do projeto. |
| VALOR SOLICITADO | Número | Valor que o empreendedor solicitou via edital para o projeto. |
| VALOR_PROJETO | Número | Valor total do projeto (captação não exclusiva do edital). |
| VALOR_APROVADO | Número | Valor contemplado pelo edital para o projeto. |

<h2><span style="color:#2d7eea">Overview LookML </span></h2>

LookML é uma linguagem de modelagem de dados para descrever dimensões, campos, agregados e relacionamentos baseados em SQL.

O LookML é poderoso porque:

- **É tudo sobre reuso**:  A maioria das análises de dados exige que o mesmo trabalho seja feito repetidas vezes. você extrai
dados brutos, prepara eles, entrega uma análise... e nunca mais consege usar nenhum desses trabalhos novamente. Isso é extremamente
ineficiente, já que a próxima análise muitas vezes envolve muitas das mesmas etapas. Com o LookML, depois de definir uma
dimensão ou uma metrica, você evolui a partir dela, em vez de ter que reescrevê-la novamente.
- **Empodere o usuário final**:  O modelo semantico que os analistas e desenvolvedores de dados criam no LookML condensa e
encapsula a complexidade do SQL e permite que os analistas expressem seu conhecimento sobre o que seus dados significam
de suas cabeças para que outros possam usá-lo. Isso permite que usuários não técnicos façam seus trabalhos &mdash; construção de painéis,
aprofundando no dado em nível de linha e acesso a métricas complexas &mdash; sem ter que se preocupar com o que está por trás da cortina.
- **Allows for data governance**: Ao definir métricas de negócios no LookML, você pode garantir que o Looker seja sempre a fonte única e confiável da verdade.


O aplicativo Looker usa um modelo semantico escrito em LookML para construir consultas SQL em um banco de dados específico que
analistas de negócios podem [Explorar](https://cloud.google.com/looker/docs/r/exploring-data) em. Para obter uma visão geral sobre os fundamentos do LookML, consulte [O que é LookML?](https://cloud.google.com/looker/docs/r/what-is-lookml)

<h2><span style="color:#2d7eea">Aprenda a Falar LookML</span></h2>

Um projeto LookML é uma coleção de arquivos LookML que descreve um conjunto de [views](https://cloud.google.com/looker/docs/r/terms/view-file) relacionadas, [models](https:// cloud.google.com/looker/docs/r/terms/model-file) e [explores](https://cloud.google.com/looker/docs/r/terms/explore).
A LookML project is a collection of LookML files that describes a set of related [views](https://cloud.google.com/looker/docs/r/terms/view-file), [models](https://cloud.google.com/looker/docs/r/terms/model-file), and [Explores](https://cloud.google.com/looker/docs/r/terms/explore).
- Uma [view](https://cloud.google.com/looker/docs/r/terms/view-file) (arquivos .view) contém informações sobre como acessar ou calcular informações de cada tabela (ou
em várias tabelas unidas). Aqui você normalmente definirá a view, suas dimensões e metricas e seus conjuntos de campos.
- Um [model](https://cloud.google.com/looker/docs/r/terms/model-file) (arquivo .model) contém informações sobre quais tabelas usar e como elas devem ser unidas.
Aqui você normalmente definirá o modelo, suas Explorações(explore) e suas junções.
- Um [explore](https://cloud.google.com/looker/docs/r/terms/explore) é o ponto de partida para os usuários corporativos consultarem dados e é o resultado final do LookML que você está
escrevendo. Para ver as explorações neste projeto, selecione uma exploração(explore) no menu Explorar.

<h2><span style="color:#2d7eea">Explorando os Dados</span></h2>

A descoberta de dados ad-hoc é um dos recursos mais poderosos e exclusivos do Looker. Conforme você avalia os casos de uso para o seu
trial, considere quais áreas de negócios você gostaria de explorar. Abra o menu Explorar no menu principal para ver
as exploração(explore) que você está construindo.

<h2><span style="color:#2d7eea">O Fluxo de Desenvolvimento</span></h2>

Para atender a um ambiente de vários desenvolvedores, o Looker é integrado ao Git para controle de versão. Siga [estas instruções](https://cloud.google.com/looker/docs/r/develop/git-setup)
para configurar o Git no o seu projeto. Para editar o LookML, expanda o menu suspenso e ative o Modo Desenvolvedor [Modo de desenvolvimento](https://cloud.google.com/looker/docs/r/terms/dev-mode). Em
Modo Desenvolvedor, as alterações feitas no modelo LookML existem apenas em sua conta até que você confirme as
alterações e envie-os para o seu modelo de produção.

<h2><span style="color:#2d7eea">Recursos Adcionais</span></h2>

Para saber mais sobre o LookML e como desenvolver, visite:
- [Guia do usuário do Looker](https://looker.com/guide)
- [Central de Ajuda do Looker](https://help.looker.com)
- [Universidade Looker](https://training.looker.com/)
