FROM swift:5.1
USER root
LABEL "com.github.actions.name"="SwiftPM-GitHubAction"
LABEL "com.github.actions.description"="Swift Packages with Github Actions"
LABEL "com.github.actions.icon"="airplay"
LABEL "com.github.actions.color"="orange"
LABEL "repository"="http://github.com/zpg6/SwiftUIPolygonGeofence"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Zach Grimaldi <grimaldizach@gmail.com>"
RUN apt-get update && apt-get install -y git
RUN mkdir /SwiftPM-GitHubAction
WORKDIR /SwiftPM-GitHubAction
COPY . /SwiftPM-GitHubAction
