FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /app
COPY publish/ ./
ENV DEPLOYMENT_MODE=production
ENV HOST=http://+
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "Smdb.Api.dll"]

# Restore ONLY the API (and its deps)
RUN dotnet restore src/Smdb.Api/Smdb.Api.csproj

# Copy the rest of the source
COPY . .

# Publish API
RUN dotnet publish src/Smdb.Api/Smdb.Api.csproj -c Release -o /app/publish

# ---------- RUNTIME STAGE ----------
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080

ENTRYPOINT ["dotnet", "Smdb.Api.dll"]