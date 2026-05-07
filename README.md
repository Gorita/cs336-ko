# CS336: Language Modeling from Scratch — 한국어 학습 가이드

Stanford CS336 강의를 한국어로 학습하기 위한 자료 모음입니다.

> 이 repo는 비공식 학습 자료입니다. 공식 강의 자료는 [cs336.stanford.edu](https://cs336.stanford.edu/) 를 참고하세요.

## 📚 코스 소개

CS336은 Stanford에서 개설한 **언어 모델을 처음부터 직접 구현하는** 코스입니다.
Tokenization, Transformer 아키텍처, 분산 학습, scaling laws, alignment(SFT/RLHF) 까지
LM의 모든 핵심 요소를 직접 코드로 구현하면서 배웁니다.

- **공식 사이트**: https://cs336.stanford.edu/
- **공식 GitHub**: https://github.com/stanford-cs336

## 🎯 이 repo의 목적

영어 자료와 방대한 분량 때문에 시작이 어려운 한국어 학습자를 위해:

- **한국어 학습 가이드** (`lectures/`, `assignments/`) — 강의/과제별 개념 정리, 학습 포인트
- **한국어 번역본** (`lectures/`) — Stanford 강의 코드의 한국어 번역 (실행 가능, 학습 완료 후 작성)
- **영-한 용어집** (`glossary-ko.md`)
- **학습 로드맵** ([`ROADMAP.md`](./ROADMAP.md))
- **Claude Code 페어러닝** — `.claude/skills/cs336-note` 로 학습 노트 자동 정돈

## 🚀 시작하기

### 1. 이 repo clone

```bash
git clone https://github.com/Gorita/cs336-ko.git
cd cs336-ko
```

### 2. Stanford 공식 자료 셋업

`setup.sh` 한 번 실행하면 모든 공식 repo가 `workspace/` 에 clone 됩니다.

```bash
./setup.sh
```

### 3. 학습 시작

[ROADMAP.md](./ROADMAP.md) 의 Phase 1부터 진행합니다.

각 강의는 `lectures/lec{NN}-*/guide.md` 의 한국어 가이드를 보면서 학습합니다.

## 🧭 학습 방식

### 추천: Claude Code 페어러닝 (방식 C)

Claude Code 와 함께 진행하는 페어러닝 방식을 권장합니다:

1. Claude 가 Stanford 원본 (`workspace/spring2025-lectures/lecture_NN.py`) 섹션별로 한국어 풀이
2. 사용자는 채팅으로 반응 / 메모 / 질문
3. **`/cs336-note`** 스킬로 학습 중 노트 자동 정돈 → `workspace/notes/lec{NN}.md` 에 누적
4. 섹션 끝마다 이해 확인 (체크포인트)

이 방식의 자세한 규칙은 [`CLAUDE.md`](./CLAUDE.md) 참조.

### 대안: 혼자 학습

Claude 없이도 가능합니다:
1. `lectures/lec{NN}-*/guide.md` 가이드를 따라 학습
2. Stanford 원본 (`workspace/spring2025-lectures/lecture_NN.py`) 직접 읽기
3. 본인이 노트 작성

## 📖 디렉토리 구조

```
cs336-ko/
├── README.md, ROADMAP.md, CLAUDE.md, glossary-ko.md
├── setup.sh                                # Stanford 공식 자료 자동 셋업
├── lectures/                               # 공개: 강의별 자료
│   ├── LICENSE                             # 번역본용 Stanford MIT
│   ├── lec01-tokenization/
│   │   ├── guide.md                        # 한국어 학습 가이드
│   │   └── lecture_01_ko.py                # 한국어 번역본 (학습 완료 후)
│   └── ...
├── assignments/                            # 공개: 과제별 한국어 가이드
│   └── a{N}-{topic}/
├── .claude/
│   └── skills/cs336-note/                  # 노트 작성 스킬
└── workspace/                              # ⚠️ gitignored (개인 작업 공간)
    ├── notes/                              # 본인 raw 학습 노트
    ├── spring2025-lectures/                # Stanford 공식 강의 (clone)
    ├── assignment{N}-*/                    # Stanford 공식 과제 (clone)
    └── scratch/
```

| 경로 | 내용 |
|------|------|
| [`lectures/`](./lectures/) | 강의별 한국어 가이드 + 번역본 (Lec 1~19) |
| [`assignments/`](./assignments/) | 과제별 한국어 가이드 (A1~A5) |
| [`glossary-ko.md`](./glossary-ko.md) | 영-한 용어집 |
| [`ROADMAP.md`](./ROADMAP.md) | 학습 로드맵 (Phase 1~6) |
| [`CLAUDE.md`](./CLAUDE.md) | 프로젝트 작업 규칙 (페어러닝 시 참조) |
| `workspace/` | Stanford 공식 자료 + 본인 노트 (로컬에만, gitignored) |

## 🤝 기여

오타 수정, 번역 개선, 추가 설명 등 어떤 형태든 환영합니다.
Issue 또는 PR로 기여해주세요.

**기여 시 유의**:
- Assignment **솔루션 코드**는 받지 않습니다 (학습 윤리)
- 번역본은 [옵션 A 충실 번역](./CLAUDE.md#번역-규칙-옵션-a-충실-번역) 원칙 준수

## 📜 라이선스

- 본인 작성 콘텐츠 (가이드, 노트): **CC BY 4.0**
- 코드 스니펫: **MIT**
- 번역본: Stanford 원본 **MIT** 유지 + 출처 명시 (`lectures/LICENSE` 참조)
- Stanford 공식 자료는 각 repo의 라이선스를 따릅니다 (대부분 MIT).
