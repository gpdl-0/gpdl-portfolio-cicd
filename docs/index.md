# Olá, eu sou o Giovanni

Bem-vindo ao meu portfólio de engenharia. Sou um **Cloud Support Engineer** focado em arquitetura Cloud, DevOps e Automação.

!!! warning "🚧 Site em Construção Ativa (CI/CD Live)"
    Este portfólio é um **Laboratório Vivo**. Você está visualizando uma versão implantada automaticamente via pipeline de CI/CD.

    O conteúdo e a estrutura estão sendo refinados diariamente. Acompanhe as mudanças no [Repositório GitHub](https://github.com/gpdl-0/gpdl-portfolio-cicd).

---

## 🚀 Projetos em Destaque

### 1. HumanGov: Arquitetura SaaS Multi-Tenant na AWS

**Stack:** AWS, Terraform, Kubernetes, DevOps

Recentemente documentei a implementação de uma infraestrutura complexa para um SaaS governamental. O projeto foca em isolamento de *tenants*, escalabilidade e provisionamento automatizado.

> *"O HumanGov é uma solução SaaS projetada para modernizar a gestão de recursos humanos no setor público..."*

[Ler Artigo Completo no Medium :material-arrow-right:](https://medium.com/@giovanni-pdl/projeto-humangov-documenta%C3%A7%C3%A3o-t%C3%A9cnica-f0878caa11af){ .md-button .md-button--primary }

---

### 2. Este Portfólio (Meta-Projeto)

**Stack:** AWS S3, CloudFront, OIDC, GitHub Actions

Este próprio site que você está navegando é uma demonstração de engenharia **Serverless** e **FinOps**. Não há servidores ligados. Todo o provisionamento é feito via código (IaC).

**Arquitetura Atual:**

```mermaid
graph LR
    User((Visitante)) -->|HTTPS| CDN[CloudFront Edge]
    CDN -->|OAC Auth| S3[S3 Bucket Privado]
    GitHub[GitHub Actions] -->|OIDC AssumeRole| AWS[AWS Account]
    GitHub -->|Sync HTML| S3
    GitHub -->|Invalidate Cache| CDN
    
    style CDN fill:#ff9900,stroke:#333,stroke-width:2px
    style S3 fill:#ff9900,stroke:#333,stroke-width:2px
    style GitHub fill:#24292e,stroke:#fff,color:#fff
´´´
*Custo: Próximo de zero (Arquitetura Estática).

*Segurança: Autenticação OIDC (Sem chaves de acesso fixas) e Bucket Privado.

*Automação: Deploy automático a cada push na branch main.

## Contato e Redes
Estou sempre aberto a discutir desafios de Cloud e oportunidades.

<div class="grid cards" markdown>

:fontawesome-brands-linkedin: LinkedIn
Conecte-se comigo profissionalmente :material-arrow-right: Acessar Perfil

:fontawesome-brands-medium: Medium
Leia meus artigos técnicos e documentações :material-arrow-right: Ler Artigos

:fontawesome-brands-github: GitHub
Explore meu código fonte e infraestrutura :material-arrow-right: Ver Repositórios

</div>
