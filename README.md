# SURA Review Tone Experiment

This repository contains a research project conducted under the Summer Undergraduate Research Apprenticeship (SURA) at Carnegie Mellon University. The study tests how online review tone, product type, and rating variance affect consumer purchase intent and product attitude.

## Project Background

Consumers use both star ratings and written reviews to evaluate products. Prior studies often look at these elements in isolation. This project evaluates them together in a full-factorial design. It asks: How do tone, product category, and rating variance shape buying decisions?

The study simulates online product pages. Participants see different combinations of review tone, star rating variance, and product type. They rate their attitude and purchase intent. Responses are measured using 7-point Likert scales.

## Study Design

- 2 × 2 × 2 between-subjects experiment
- N = 359
- Factors:
  - **Review Tone**: Emotional vs. Functional
  - **Product Type**: Hedonic (perfume) vs. Utilitarian (USB drive)
  - **Star Rating Variance**: High vs. Low
- Outcomes:
  - Purchase Intent (2-item average)
  - Attitude Toward Product (2-item average)
  - Influence of Star Ratings
  - Influence of Written Reviews

## Hypotheses and Reasoning

### H1

**For utilitarian products, functional review tone will lower purchase intent and attitude compared to emotional tone.**  
This prediction is based on **Expectancy Violations Theory (EVT)** and prior work on product-review fit. People expect functional tone for utilitarian products. Violating that expectation with emotional language can trigger more attention and improve evaluations. Past studies show emotional reviews reduce the negative impact of low ratings for utilitarian products.

### H2

**The effect of tone is moderated by variance. The tone × product interaction appears only under low rating variance, not high variance.**  
High variance signals risk. When variance is high, the benefit of emotional tone diminishes. Consumers seek clarity. In these cases, functional tone becomes more effective, especially for utilitarian products. Prior work shows that functional language can reduce risk perception under uncertainty.

## Tools

- **R**: Data cleaning using dummy dataset (see `data-cleaning-r/`)
- **SPSS**: Statistical analysis (ANOVA, t-tests)
- **Tableau**: Dashboard and data visualization
- **Qualtrics**: Survey delivery and randomization

## Repository Structure

