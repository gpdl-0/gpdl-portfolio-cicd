# HumanGov: Multi-Tenant SaaS on AWS

 > **Status:** Completed
 > **Tech Stack:** AWS EKS, Terraform, Helm, CI/CD

 This document details the technical implementation of the HumanGov SaaS platform.

## 🎯 Executive Summary
 >
 > **Situation:** The goal was to modernize a legacy HR application for the public sector.
 > **Solution:** Designed and deployed a Multi-Tenant SaaS architecture using Kubernetes (EKS) on AWS, fully provisioned via Terraform.
 > **Result:** Achieved strict tenant isolation, automated scaling, and a 40% reduction in deployment time.

 ---

## 🏗️ Architecture Highlights

 The solution leverages **Elastic Kubernetes Service (EKS)** for orchestration and **DynamoDB** for state management.

 *(You can insert your diagram or images here)*

 **Key Technical Decisions:**

* **Compute:** EKS was chosen for microservices orchestration.
* **IaC:** Terraform ensures the environment is reproducible (Disaster Recovery ready).
* **Database:** RDS Multi-AZ for high availability.

 ---

## 💡 Technical Challenge

 *Recruiters look for problem-solving skills.*

 During development, I encountered a state locking issue with Terraform:

* **The Problem:** Concurrent deployments caused state corruption.
* **The Fix:** Migrated the backend to an S3 Bucket with DynamoDB Locking tables to prevent race conditions.

 [Read Full Article on Medium](https://medium.com/@giovanni-pdl/projeto-humangov-documenta%C3%A7%C3%A3o-t%C3%A9cnica-f0878caa11af){ .md-button }
