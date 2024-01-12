FROM alpine AS build

ARG COMMIT_SHA=<not-specified>
ARG BUILD_FILE_NAME=mia_template_service_name_placeholder

WORKDIR /build

COPY ./target/${BUILD_FILE_NAME}.jar ./application.jar
COPY LICENSE .

RUN echo "service-name: $COMMIT_SHA" >> ./commit.sha

FROM openjdk:17-ea-slim

LABEL maintainer="alessandro.bonadei@mia-care.io" \
      name="mia_template_service_name_placeholder" \
      description="This is the best template to start creating a service in Springboot integrated inside the Platform" \
      eu.mia-platform.url="https://www.mia-platform.eu" \
      eu.mia-platform.version="0.1.0"

# set deployment directory
WORKDIR /home/java/app

COPY --from=build /build .

USER 1000

CMD ["java", "-jar", "./application.jar"]
