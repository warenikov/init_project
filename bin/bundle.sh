#!/usr/bin/env sh
# Склеивает скиллы в один markdown-файл — для агентов и чатов без доступа к файловой системе.
# Использование: ./bin/bundle.sh > init-project-prompt.md
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

emit() {
  printf '\n\n<!-- ===== %s ===== -->\n\n' "$1"
  cat "$ROOT/$1"
}

cat <<'HEADER'
# init-project + task-log — единый текст инструкций

Ниже — инструкция по инициализации документации проекта и по ведению истории задач,
склеенная в один файл: сам скилл, справочники и шаблоны документов.
Работай по разделу «init-project / SKILL.md», остальные разделы — материалы, на которые он ссылается.
HEADER

emit skills/init-project/SKILL.md
for f in "$ROOT"/skills/init-project/references/*.md; do
  emit "skills/init-project/references/$(basename "$f")"
done
emit skills/init-project/templates/CLAUDE.md.template
find "$ROOT/skills/init-project/templates/docs" -name '*.md' | sort | while read -r f; do
  emit "${f#"$ROOT"/}"
done
emit skills/task-log/SKILL.md
