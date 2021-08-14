FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

#copy scproj and restore
COPY *.csproj ./
RUN dotnet restore

#copy everythin else and build
COPY . ./
RUN dotnet publish -c Release -o out

#Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "weatherapi.dll"]