#Build Stage
FROM microsoft/dotnet:2.2-sdk as build-env

LABEL maintainer="laxmimanoj"

WORKDIR /api1
COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -o /publish

#Runtime Stage
FROM microsoft/dotnet:2.2-aspnetcore-runtime as runtime-env

WORKDIR /publish

COPY --from=build-env /publish .

EXPOSE 5001

ENTRYPOINT [ "dotnet","api1.dll" ]