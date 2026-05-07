# cs336-ko 프로젝트 작업 규칙

Stanford CS336 (Language Modeling from Scratch) 한국어 학습 가이드 repo.

## 디렉토리 구조

```
cs336-ko/                              # public repo
├── lectures/                          # 공개: 강의별 한국어 자료
│   ├── LICENSE                        # Stanford 원본 MIT (번역본 적용)
│   ├── lec{NN}-{topic}/               # 강의별 폴더
│   │   ├── guide.md                   # 한국어 학습 가이드
│   │   └── lecture_{NN}_ko.py         # 한국어 번역본 (학습 후 작성)
├── assignments/                       # 공개: 과제별 한국어 가이드
│   └── a{N}-{topic}/
├── glossary-ko.md, ROADMAP.md, README.md
├── setup.sh                           # Stanford 공식 repo 자동 clone
└── workspace/                         # ⚠️ gitignored (개인 작업 공간)
    ├── notes/                         # 본인 raw 학습 노트
    │   └── lec{NN}.md
    ├── spring2025-lectures/           # Stanford 공식 (clone)
    ├── assignment{N}-*/               # Stanford 공식 (clone)
    └── scratch/
```

**핵심 구분**:
- `lectures/`, `assignments/` = 공개 가공 자료 (다른 학습자도 봄)
- `workspace/` = 본인 학습 raw 자료 (gitignored, 본인만)

## 학습 진행 방식

### 방식 C — 페어러닝 (chat 기반)

1. Claude가 Stanford 원본 (`workspace/spring2025-lectures/lecture_NN.py`) 섹션별로 한국어 풀이
2. 사용자가 채팅으로 반응 / 메모 / 질문
3. 섹션 끝마다 체크포인트 (이해 확인)
4. 본인 raw 노트는 `workspace/notes/lec{NN}.md` 에 누적 (cs336-note 스킬 사용)

### 학습 → 번역 흐름

```
1. 학습 (Stanford 원본 + 한국어 풀이)
   → workspace/notes/lec{NN}.md 에 raw 노트
2. 학습 완료
   → lectures/lec{NN}-*/lecture_{NN}_ko.py 번역 (옵션 A: 충실 번역)
   → lectures/lec{NN}-*/guide.md 정리 (한국어 학습 가이드)
```

**중요**: 번역은 **학습 완료 후**. 이해 없이 기계 번역하지 말 것.

## 번역 규칙 (옵션 A: 충실 번역)

- 코드 구조 / imports / 함수명 그대로 유지
- `text(...)` 안 문자열만 한국어로 번역
- 보충 설명은 별도 `guide.md` 로 분리 (코드에 추가 X)
- 파일 헤더에 출처 + 라이선스 명시
- 원본 LICENSE는 `lectures/LICENSE` 에 (Stanford MIT)

## 노트 운영

- 위치: `workspace/notes/lec{NN}.md` (gitignored)
- 형식: Timeline 기반, 일자별 `## YYYY-MM-DD` 헤더
- 항목: 모두 bullet (`-`)
- 질문: `[ ]` (미해결) / `[x]` (해결 — 사용자 판단)
- 노트 작성은 **`cs336-note` 스킬** 사용 (자족성 평가 + 정돈)

### 학습 시작/종료 시

- 학습 시작 시: `workspace/notes/lec{NN}.md` 의 미해결 `[ ]` 항목 자동 표시
- 학습 종료 시: 오늘 남은 미해결 요약

## 학습 검증 (Deep Quiz)

강의 한 단위 학습이 끝나면 `cs336-deep-quiz` 스킬로 진짜 이해했는지 검증.

- 서브에이전트(Socratic Examiner) 가 표면적 답에 의심 (max 3 probe)
- 검증 대상: 객관 2 (`guide.md` 학습 목표) + 주관 1 (`notes` 의 `[ ]`)
- 결과 처리:
  - **gap / surface** → `notes/lec{NN}.md` 에 `[ ]` 추가 제안 (사용자 확인 후)
  - **이전 `[ ]` 가 mastered** → `[x]` close 제안
  - **mastered** (신규) → 노트에 안 적음 (채팅에만)
- 빈번한 호출 권장 X (학습 단위 끝마다 1회)

### 닫힘 루프

```
학습 → /cs336-note (노트 누적) 
     → /cs336-deep-quiz (검증, 서브에이전트 의심)
     → gap 발견 시 노트에 [ ] 추가 (사용자 확인)
     → 다음 학습 시작 시 [ ] 자동 표시
```

## Assignment 작업

- 작업 위치: `workspace/assignment{N}-*/` (Stanford clone, gitignored)
- 한국어 가이드: `assignments/a{N}-*/` (공개)
- **솔루션 공개 X** (학습 윤리)
- Claude는 힌트/리뷰 역할만, 정답 코드 제공 X

## 페어러닝 원칙

- 사용자가 직접 사고/생산하도록 유도 (소크라테스식 질문)
- Claude의 요약을 그대로 노트에 넣지 않음 (사용자 출력만 노트)
- 막혔을 때만 힌트, 정답 즉답 X
- 모든 응답은 한국어 (기술 용어/코드는 원어)

## Git 규칙

- workspace/ 는 항상 gitignored (절대 커밋 X)
- Public repo 라 커밋에 회사 이메일 / 민감 정보 금지
- Local commit author: `Gorita <mkcode2014@gmail.com>` (이미 설정됨)
- Commit 메시지는 한국어 가능, 명료하게

## 라이선스

- 본인 작성 (가이드, 노트): CC BY 4.0 (사용자 결정)
- 코드: MIT
- 번역본: Stanford 원본 MIT 유지 + 출처 명시
