# Шаг 0 — разведка по репозиторию

Цель: не задавать вопросов, ответы на которые лежат в файлах. Всё найденное показывается пользователю **на подтверждение**, а не записывается как факт.

## 1. Что вообще есть

```bash
ls -a
git log --oneline -15 2>/dev/null
git branch -a 2>/dev/null
git log -1 --format='%an <%ae> %ad'
```

Язык сообщений коммитов и их формат (`feat:`, `INF-123:`, свободный) — это ответ на вопросы E1 и E3 без вопроса.

## 2. Стек — по файлам-маркерам

| Файл | Стек |
|---|---|
| `package.json` | Node/JS/TS — смотри `scripts`, `engines`, зависимости |
| `go.mod` | Go — версия в первой строке |
| `composer.json` | PHP — `require`, часто видно CMS/фреймворк |
| `pyproject.toml`, `requirements.txt`, `Pipfile` | Python |
| `Gemfile` | Ruby |
| `pom.xml`, `build.gradle` | Java/Kotlin |
| `Cargo.toml` | Rust |
| `*.csproj`, `*.sln` | .NET |
| `pubspec.yaml` | Flutter/Dart |
| `Package.swift`, `*.xcodeproj` | Swift/iOS |
| `mix.exs` | Elixir |
| `bitrix/`, `local/` | 1С-Битрикс |
| `wp-config.php`, `wp-content/` | WordPress |
| `artisan` | Laravel |
| `manage.py` | Django |
| `next.config.*`, `nuxt.config.*`, `vite.config.*` | фронтенд-фреймворк |
| `Dockerfile`, `docker-compose.yml` | контейнеры, а заодно список сервисов и портов |
| `Makefile`, `Taskfile.yml`, `justfile` | готовые команды запуска — выписать как есть |
| `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile` | CI, деплой, среды |
| `.env.example` | перечень нужных переменных (значения — никогда) |
| `migrations/`, `db/migrate/` | миграции БД |
| `README.md`, `CONTRIBUTING.md`, `docs/`, вики | уже написанная документация — перенести, не дублировать |

Быстрый срез:

```bash
ls | head -40
find . -maxdepth 2 -name 'package.json' -o -maxdepth 2 -name 'go.mod' -o -maxdepth 2 -name 'composer.json' \
  -o -maxdepth 2 -name 'pyproject.toml' -o -maxdepth 2 -name 'Dockerfile' -o -maxdepth 2 -name 'Makefile' 2>/dev/null | grep -v node_modules | head -20
```

## 3. Команды запуска

Выписывай **дословно** из `Makefile`, `package.json` → `scripts`, `docker-compose.yml`, README. Не переформулируй и не «улучшай»: команда, которую ты придумал, не работает, а выглядит как проверенная.

## 4. Среды и адреса

Ищи в CI-конфигах, `docker-compose*.yml`, `.env.example`, README: имена сред, домены, хосты. Пароли и токены, если попались, **не переноси** — вместо значения пиши, где они лежат.

## 5. Масштаб кодовой базы

```bash
git ls-files 2>/dev/null | wc -l
git ls-files 2>/dev/null | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -15
```

Даёт реальную картину «на чём это написано» лучше, чем список зависимостей.

## 6. Чего разведка не даёт

Никогда не выводятся из кода и всегда требуют вопроса: зачем проект существует и для кого; кто принимает решения; какие доступы есть, а какие надо запрашивать; почему приняты те или иные решения; что нельзя трогать; где грабли; что считается «готово».
