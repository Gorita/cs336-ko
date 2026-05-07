# CS336: Language Modeling from Scratch — 한국어 학습 가이드

Stanford CS336 강의를 한국어로 학습하기 위한 가이드 모음입니다.

> 이 repo는 비공식 학습 자료입니다. 공식 강의 자료는 [cs336.stanford.edu](https://cs336.stanford.edu/) 를 참고하세요.

## 📚 코스 소개

CS336은 Stanford에서 개설한 **언어 모델을 처음부터 직접 구현하는** 코스입니다.
Tokenization, Transformer 아키텍처, 분산 학습, scaling laws, alignment(SFT/RLHF) 까지
LM의 모든 핵심 요소를 직접 코드로 구현하면서 배웁니다.

- **공식 사이트**: https://cs336.stanford.edu/
- **공식 GitHub**: https://github.com/stanford-cs336

## 🎯 이 repo의 목적

영어 자료와 방대한 분량 때문에 시작이 어려운 한국어 학습자를 위해:

- 강의별 한국어 학습 가이드
- 과제별 한국어 안내
- 영-한 용어집
- 학습 로드맵

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

이후 디렉토리 구조:

```
cs336-ko/
├── lectures/                  # 한국어 강의 가이드 (이 repo)
├── assignments/               # 한국어 과제 가이드 (이 repo)
├── glossary-ko.md             # 영-한 용어집
└── workspace/                 # ⬇️ Stanford 공식 자료 (gitignored)
    ├── spring2025-lectures/
    ├── assignment1-basics/
    ├── assignment2-systems/
    ├── assignment3-scaling/
    ├── assignment4-data/
    └── assignment5-alignment/
```

### 3. 학습 시작

[ROADMAP.md](./ROADMAP.md) 를 따라 진행하세요.

## 📖 디렉토리 안내

| 경로 | 내용 |
|------|------|
| [`lectures/`](./lectures/) | 강의별 한국어 가이드 (Lec 1~19) |
| [`assignments/`](./assignments/) | 과제별 한국어 가이드 (A1~A5) |
| [`glossary-ko.md`](./glossary-ko.md) | 영-한 용어집 |
| [`ROADMAP.md`](./ROADMAP.md) | 학습 로드맵 |
| `workspace/` | Stanford 공식 자료 (로컬에만 존재) |

## 🤝 기여

오타 수정, 번역 개선, 추가 설명 등 어떤 형태든 환영합니다.
Issue 또는 PR로 기여해주세요.

## 📜 라이선스

- 본인 작성 콘텐츠 (한국어 가이드, 노트): **CC BY 4.0**
- 코드 스니펫: **MIT**
- Stanford 공식 자료는 각 repo의 라이선스를 따릅니다 (대부분 MIT).
