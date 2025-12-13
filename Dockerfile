FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /app
COPY publish/ ./
ENV DEPLOYMENT_MODE=production
ENV HOST=http://+
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "Smdb.Api.dll"]