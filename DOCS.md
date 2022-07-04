---
date: 2022-07-04T10:00:00+00:00
title: SonarQube
author: akath19
tags: [ Sonar, SonarQube, Analysis, report ]
logo: sonarqube.svg
repo: aosapps/drone-sonar-plugin
image: aosapps/drone-sonar-plugin
---

This plugin can scan your code quality and post the analysis report to your SonarQube server. SonarQube (previously called Sonar), is an open source code quality management platform.

The below pipeline configuration demonstrates simple usage:

```yaml
steps:
- name: code-analysis
  image: aosapps/drone-sonar-plugin
  settings:
    sonar_host:
      from_secret: sonar_host
    sonar_token:
      from_secret: sonar_token
```

Customized parameters could be specified:

```diff
  steps:
  - name: code-analysis
    image: aosapps/drone-sonar-plugin
    settings:
      sonar_host:
        from_secret: sonar_host
      sonar_token:
        from_secret: sonar_token
+      projectKey: drone-sonar-plugin
+      projectName: "Drone Sonar Plugin"
+     ver: 1.0
+     timeout: 20
+     sources: .
+     level: DEBUG
+     showProfiling: true
+     exclusions: **/static/**/*,**/dist/**/*.js
+     usingProperties: true
+      propertiesFilePath: assets/sonar-project.properties
```

# Secret Reference

The following properties should be stored in secrets to keep your pipeline secure
* `sonar_host`: Host of SonarQube with schema (http/https).
* `sonar_token`: Token used to authenticate against Sonarqube, generate via Sonarqube UI


# Parameters

* `projectKey`: Project key in Sonarqube, defaults to `DRONE_REPO`
* `projectName`: Project name to set in Sonarqube, defaults to `DRONE_REPO`
* `ver`: Code version, defaults to `DRONE_BUILD_NUMBER`.
* `timeout`: Timeout for connecting to Sonarqube in seconds, defaults to `60`.
* `sources`: Comma-separated paths to directories containing source files. 
* `inclusions`: Comma-delimited list of file path patterns to be included in analysis. When set, only files matching the paths set here will be included in analysis.
* `exclusions`: Comma-delimited list of file path patterns to be excluded from analysis. Example: `**/static/**/*,**/dist/**/*.js`.
* `level`: Control the quantity / level of logs produced during an analysis. Default value `INFO`. 
    * DEBUG: Display INFO logs + more details at DEBUG level.
    * TRACE: Display DEBUG logs + the timings of all ElasticSearch queries and Web API calls executed by the SonarQube Scanner.
* `showProfiling`: Display logs to see where the analyzer spends time. Default value `false`
* `branchAnalysis`: Pass currently analysed branch to SonarQube. (Must not be active for initial scan!) Default value `false`
* `usingProperties`: Using the `sonar-project.properties` file in root directory as sonar parameters. (Not include `sonar_host` and `sonar_token`.) Default value `false`
* `propertiesFilePath`: Custom path for the properties fule to use, use only if your file isn't named `sonar-project.properties` or if the file isn't located in the root of the project


# Notes
Code repository: [aosapps/drone-sonar-plugin](https://github.com/akath19/drone-sonar-plugin).  
SonarQube Parameters: [Analysis Parameters](https://docs.sonarqube.org/display/SONAR/Analysis+Parameters)
