# Lecture 1: Overview, Tokenization

## 📺 강의 자료

- **공식 사이트**: https://cs336.stanford.edu/
- **YouTube**: 검색 "Stanford CS336 Lecture 1" (자막 가능)
- **강의 코드**: [`workspace/spring2025-lectures/lecture_01.py`](https://github.com/stanford-cs336/spring2025-lectures/blob/main/lecture_01.py)
- **참고 영상**: [Andrej Karpathy의 Tokenization 영상](https://www.youtube.com/watch?v=zduSFxRajkE) (강사가 추천)

> 💡 CS336 강의는 Python 파일로 작성된 "내러티브 강의"입니다.
> `python execute.py -m lecture_01` 으로 실행하면 인터랙티브 trace를 볼 수 있어요.

## 🎯 학습 목표

이 강의를 마치면 다음을 할 수 있어야 합니다.

- [ ] CS336 코스의 목적과 학습 방식 이해
- [ ] LM에서 **Tokenization**이 왜 필요한지 설명
- [ ] Character / Byte / Word tokenizer의 한계 이해
- [ ] **BPE (Byte Pair Encoding)** 의 기본 원리와 동작 방식 이해
- [ ] BPE의 `merge` 연산을 직접 따라가볼 수 있음

## 📋 강의 구조

| 섹션 | 내용 | 핵심 메시지 |
|------|------|------------|
| Welcome | 코스 소개 | 두 번째 학기 |
| Why this course | 왜 LM을 처음부터? | 추상화는 leaky함, 본질 이해가 연구의 기반 |
| Current landscape | 현재 LM 산업화 | GPT-4 1.8T, $100M, 200K H100 — 우리는 작은 모델로 배움 |
| What/Course logistics | 학습 방식 | Mechanics + Mindset 전수 가능, Intuition은 일부 |
| Course components | 5개 unit 미리보기 | Basics → Systems → Scaling → Data → Alignment |
| **Tokenization** | 본격 콘텐츠 시작 | Char/Byte/Word → BPE |

## 🧠 핵심 개념 (한국어 정리)

### 왜 이 코스가 존재하는가?

**문제**: 연구자들이 점점 기술의 **본질에서 멀어짐**

- 8년 전: 직접 구현하고 학습 (e.g., Word2Vec)
- 6년 전: 다운로드 후 fine-tune (e.g., BERT)
- 현재: API로 prompt만 (e.g., GPT-4, Claude)

추상화는 생산성을 높이지만 **leaky** 합니다 (프로그래밍 언어와 다름).
근본적 연구를 하려면 stack을 뜯어볼 수 있어야 합니다.

### 우리가 배울 수 있는 것

| 종류 | 학습 가능? | 설명 |
|------|----------|------|
| Mechanics (작동 원리) | ✅ | Transformer 구조, GPU 병렬화 등 |
| Mindset (사고방식) | ✅ | 하드웨어 활용 극대화, scaling laws 진지하게 |
| Intuitions (직관) | ⚠️ 부분적 | 작은 모델에서의 직관이 큰 모델로 다 transfer 안 됨 |

### Tokenization이란?

> **Tokenizer**: 문자열 ↔ 토큰(정수 인덱스) 변환기

```
"Hello world" → [9906, 1917]   (encode)
[9906, 1917] → "Hello world"   (decode)
```

LM은 정수 시퀀스만 다룰 수 있습니다. **어떻게 텍스트를 정수로 만들 것인가?** 가 tokenization 문제.

### 4가지 방식 비교

| 방식 | 어떻게? | 문제점 |
|------|--------|-------|
| **Character** | Unicode codepoint | 시퀀스가 너무 길어짐 (vocab 작음) |
| **Byte** | UTF-8 byte 단위 | 시퀀스 더 길어짐 (vocab 256으로 작지만) |
| **Word** | 공백/구두점 기준 | OOV (모르는 단어) 문제, vocab 폭발 |
| **BPE** | 자주 나오는 byte 쌍을 합침 | 적절한 절충안 (현재 표준) |

### BPE의 핵심 아이디어

> **자주 같이 나타나는 byte 쌍을 하나의 새 token으로 합친다 (반복)**

#### 예시 (간단화)

원본: `low low low lower newer`

1. **byte 단위로 분해**: `[l, o, w, " ", l, o, w, ...]`
2. **가장 자주 나오는 쌍 찾기**: `(l, o)` → 자주 나옴
3. **새 token으로 머지**: `lo` → 새 인덱스 256
4. **이걸 반복** → vocabulary가 점점 커짐

각 머지 규칙은 `(byte1, byte2) → new_token` 형태로 저장됩니다.

#### 강의의 `merge` 함수

```python
def merge(indices: list[int], pair: tuple[int, int], new_index: int) -> list[int]:
    """indices에서 pair가 나오는 모든 위치를 new_index로 치환"""
    new_indices = []
    i = 0
    while i < len(indices):
        if i + 1 < len(indices) and indices[i] == pair[0] and indices[i + 1] == pair[1]:
            new_indices.append(new_index)
            i += 2
        else:
            new_indices.append(indices[i])
            i += 1
    return new_indices
```

이 함수가 BPE의 핵심입니다. 직접 한 줄씩 따라가보세요.

### Compression Ratio

좋은 tokenizer의 지표:

```
compression ratio = (원본 byte 수) / (token 수)
```

ratio가 높을수록 한 token에 더 많은 정보가 압축됨 → 시퀀스 짧아짐 → 효율 ↑

### 강의의 핵심 메시지 (요약)

> "Tokenizer: strings ↔ tokens (indices)"
> "Character-based, byte-based, word-based tokenization highly suboptimal"
> "BPE is an effective heuristic that looks at corpus statistics"
> "Tokenization is a necessary evil, maybe one day we'll just do it from bytes..."

→ Tokenization은 **필요악**. 언젠가는 byte에서 직접 학습할 수 있을지도 (실제로 연구 중)

## 📝 학습 체크리스트

강의를 다 보고 나서 다음 질문에 답할 수 있는지 확인하세요.

- [ ] 왜 character tokenizer는 비효율적인가?
- [ ] Byte tokenizer는 character보다 왜 더 작은 vocab을 쓰는가?
- [ ] Word tokenizer의 OOV 문제는 무엇인가?
- [ ] BPE에서 merge 순서는 어떻게 정해지는가?
- [ ] BPE의 vocab size를 키우면 어떤 trade-off가 생기는가?
- [ ] Compression ratio가 의미하는 것은?
- [ ] `merge()` 함수가 어떻게 동작하는지 코드로 따라갈 수 있는가?

## 🚧 자주 막히는 부분

### 1. "왜 byte 단위로 시작하나?"
모든 Unicode 문자를 표현 가능 (UTF-8). vocab 시작이 256으로 고정되어 깔끔. character는 Unicode가 너무 많음 (~150,000개).

### 2. "BPE merge는 한 번 정하면 끝인가?"
학습 시: 코퍼스 전체에서 가장 빈번한 쌍을 골라 merge → 반복. 정해진 횟수만큼 또는 vocab size까지.
인코딩 시: 학습된 merge rule을 **순서대로** 적용.

### 3. "GPT-2 tokenizer를 보면 왜 공백이 token에 붙어 있나?"
공백을 단어 앞에 붙이는 게 효율적이라 그렇게 디자인됨. `tiktoken` 라이브러리로 직접 확인 가능.

## 🔗 다음 강의 연결

- **Lecture 2**: PyTorch + Resource Accounting (메모리/연산 계산)
- **Assignment 1**: BPE Tokenizer를 직접 구현하게 됨

## 📚 추가 자료

- [Sennrich et al., 2016 - Neural Machine Translation of Rare Words with Subword Units](https://arxiv.org/abs/1508.07909) — BPE 원논문
- [Andrej Karpathy - Let's build the GPT Tokenizer](https://www.youtube.com/watch?v=zduSFxRajkE) — 강사가 추천하는 비디오 (강추)
- [tiktoken](https://github.com/openai/tiktoken) — OpenAI의 BPE 구현
- [Hugging Face Tokenizers](https://huggingface.co/docs/tokenizers) — 실전 라이브러리

## 💭 학습 메모

본인 raw 학습 노트는 `workspace/notes/lec01.md` 에 작성합니다 (gitignored).
페어러닝 시 `/cs336-note` 스킬을 사용하면 자동으로 정돈된 형태로 저장됩니다.
