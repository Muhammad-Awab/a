FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base 
EXPOSE 80 

FROM base AS final 

WORKDIR /app 
COPY . /app


ENTRYPOINT ["dotnet", "DigitalFolder.dll"] 