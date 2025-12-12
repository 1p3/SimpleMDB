# ---------- BUILD STAGE ----------
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY *.sln ./
COPY src/Smdb.Api/*.csproj src/Smdb.Api/
COPY src/Smdb.Core/*.csproj src/Smdb.Core/

RUN dotnet restore src/Smdb.Api/Smdb.Api.csproj

COPY . .

RUN dotnet publish src/Smdb.Api/Smdb.Api.csproj -c Release -o /app/publish

# ---------- RUNTIME STAGE ----------
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "Smdb.Api.dll"]