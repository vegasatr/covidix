#!/bin/bash

# Скрипт для автоматической загрузки изменений на GitHub с версионированием
set -e

VERSION_FILE="version.txt"

if [ ! -f "$VERSION_FILE" ]; then
  echo "0.1.0" > "$VERSION_FILE"
fi

CURRENT_VERSION=$(cat "$VERSION_FILE" | tr -d '[:space:]')
echo "Текущая версия: $CURRENT_VERSION"

IFS='.' read -r major minor patch <<< "$CURRENT_VERSION"
patch=$((patch + 1))
NEW_VERSION="$major.$minor.$patch"
echo "Новая версия: $NEW_VERSION"

echo "$NEW_VERSION" > "$VERSION_FILE"

git add .
git commit -m "Automated update: изменения для версии $NEW_VERSION (v$NEW_VERSION)"
BRANCH_NAME="v$NEW_VERSION"
git checkout -b "$BRANCH_NAME"
git push origin "$BRANCH_NAME"

echo "Изменения отправлены в ветку $BRANCH_NAME (версия $NEW_VERSION)" 