# Welcome to my portfolio

 **Transforming business requirements into resilient, scalable, and automated infrastructure.**

!!! info "Wait, this is not just a website."
     **This portfolio is a Serverless Engineering Project.**

     Unlike traditional static sites, this environment is deployed via a fully automated CI/CD pipeline on AWS using Infrastructure as Code (IaC).
     
[:material-arrow-right: Click here to see how I engineered this platform](projects/serverless-portfolio.md)

## 📍 Live Architecture

 Welcome to my technical sandbox. The diagram below illustrates the **Serverless Infrastructure** delivering this content to you right now:

``` mermaid
graph LR
    User((You)) -->|HTTPS| CDN[CloudFront Edge]
    CDN -->|OAC Auth| S3[S3 Private Bucket]
    GitHub[GitHub Actions] -->|OIDC AssumeRole| AWS[AWS Account]
    GitHub -->|Sync HTML| S3
    GitHub -->|Invalidate Cache| CDN
```

* **Cost:** < $0.10/month (FinOps optimized).
* **Security:** OIDC Authentication (Keyless) and Private Storage.
* **Automation:** Continuous Deployment on every push to `main`.

 ---

## 📂 Project Catalog

 Select a case study to view implementation details, challenges, and architecture.



* **Multi-Tenant SaaS Architecture (HumanGov)**
     ---

     A complete *Software as a Service* solution deployed on AWS using Kubernetes (EKS) and Terraform. Focus on tenant isolation and scalability.

     [:material-arrow-right: View Technical Documentation](projects/humangov-saas.md)

* **Serverless Portfolio Engineering**
     ---

     The "Meta-Project". How I built this site with zero fixed costs, high performance, and security using OIDC, CloudFront and SSL.

     [:material-arrow-right: View Technical Documentation](projects/serverless-portfolio.md)

 ---

## 🤝 Let's Build Together?

 I am available for **Cloud Engineer** or **DevOps** opportunities.

 [LinkedIn :fontawesome-brands-linkedin:](https://www.linkedin.com/in/giovanni-pdl/){ .md-button } [GitHub :fontawesome-brands-github:](https://github.com/gpdl-0){ .md-button }
