#!/usr/bin/env bash
# CS336 학습 환경 셋업 스크립트
# Stanford 공식 repo들을 workspace/ 에 clone 합니다.

set -euo pipefail

WORKSPACE_DIR="workspace"
GITHUB_ORG="https://github.com/stanford-cs336"

REPOS=(
  "spring2025-lectures"
  "assignment1-basics"
  "assignment2-systems"
  "assignment3-scaling"
  "assignment4-data"
  "assignment5-alignment"
)

echo "📁 workspace/ 디렉토리 준비"
mkdir -p "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR"

for repo in "${REPOS[@]}"; do
  if [ -d "$repo/.git" ]; then
    echo "✓ $repo (이미 존재, skip)"
  else
    echo "⬇  $repo clone 중..."
    git clone "$GITHUB_ORG/$repo.git"
  fi
done

mkdir -p notes scratch

echo ""
echo "✅ 셋업 완료!"
echo ""
echo "📍 다음 디렉토리에서 작업하세요:"
echo "   - 강의 자료:   workspace/spring2025-lectures/"
echo "   - 과제 작업:   workspace/assignment1-basics/ ..."
echo "   - 본인 노트:   workspace/notes/"
echo ""
echo "📖 한국어 가이드는 lectures/, assignments/ 에서 확인하세요."
