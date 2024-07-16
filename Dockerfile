# Use the official .NET 5 SDK as the build image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# Copy the .csproj file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime as the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENV ASPNETCORE_ENVIRONMENT=Development
ENTRYPOINT ["dotnet", "la.dll"]
