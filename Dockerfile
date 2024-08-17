FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base 

WORKDIR /app 

EXPOSE 80 

  

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build 

WORKDIR /src 

COPY ["BlazorApp2/BlazorApp2.csproj", "BlazorApp2/"] 

RUN dotnet restore "BlazorApp2/BlazorApp2.csproj" 

COPY . . 

WORKDIR "/src/BlazorApp2" 

RUN dotnet build "BlazorApp2.csproj" -c Release -o /app/build 

  

FROM build AS publish 

RUN dotnet publish "BlazorApp2.csproj" -c Release -o /app/publish /p:UseAppHost=false 

  

FROM base AS final 

WORKDIR /app 

COPY --from=publish /app/publish . 

ENTRYPOINT ["dotnet", "BlazorApp2.dll"] 