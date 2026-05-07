---
name: cs336-deep-quiz
description: CS336 학습한 강의 내용에 대해 서브에이전트(Socratic Examiner) 기반 깊이 검증. 객관적 핵심 개념(guide.md 학습 목표) + 사용자 미해결([ ])을 통합 출제. 표면적 답변에 의심하며 max 3회 follow-up. 결과 actionable 한 부분만(gap/surface) 노트 [ ] 추가, 이전 [ ]가 mastered면 [x] close 제안. 사용자가 "테스트", "퀴즈", "검증", "이해했는지 확인", "/cs336-deep-quiz" 같은 표현을 쓰거나 강의 한 단위 학습 끝났을 때 사용.
---

# cs336-deep-quiz: 학습 검증 스킬 (서브에이전트 기반)

## 핵심 원칙

> **표면적 답변에 한 번 의심한다. 깊이 있는 답에는 인정한다. trick question 금지.**

이 스킬의 가치:
1. **객관 + 주관 통합 출제** — guide.md 학습 목표(객관) + notes [ ] (주관) 균형
2. **서브에이전트 분리** — Examiner 페르소나, 메인 페어러닝 컨텍스트 보호
3. **끈질긴 검증 (max 3 probe)** — 표면적 답에 의심
4. **닫힘 루프** — gap → 노트 [ ] / 이전 [ ] mastered → [x]

## 호출 형태

```
/cs336-deep-quiz [--concepts N]
```

기본: 3 개념 (객관 2 + 주관 1).

## 실행 단계

### Step 0: 컨텍스트 로드 (자동)

- 현재 강의 식별: cwd, 최근 읽은 파일, 최근 대화
  - 추론 불가 시 사용자에게 물음
- 출제 소스 로드:
  - `lectures/lec{NN}-*/guide.md` — 학습 목표 (`🎯 학습 목표` 섹션)
  - `workspace/spring2025-lectures/lecture_{NN}.py` — 원본 강의 코드
  - `workspace/notes/lec{NN}.md` — 사용자 노트 (`[ ]` 항목 수집)

### Step 1: 검증 대상 개념 선정

기본 3개 = **객관 2 + 주관 1**:

- **객관 2개**: `guide.md` 학습 목표에서 핵심 메커니즘/트레이드오프 추출
- **주관 1개**: `workspace/notes/lec{NN}.md` 의 `[ ]` 중 1개 (사용자 미해결)
  - `[ ]` 항목이 없으면 객관 3개로 대체

**제외 기준** (필수 개념만):
- ❌ 숫자 / 이름 / 날짜 trivia
- ❌ 구현 minutia
- ❌ 강의에서 곁가지로 다룬 것
- ❌ 사용자가 안 본 부분

**사용자 확인**:
```
이 3개 검증할게요:
1. BPE 동작 원리 (강의 학습 목표)
2. vocab 크기 trade-off (강의 학습 목표)
3. tokenization이 LM에 미치는 영향 (당신의 미해결 [ ])

OK? 조정 원하시면 알려주세요.
```

사용자가 조정 가능: "BPE 빼고 X 넣어줘", "주관 항목 빼줘" 등.

### Step 2: 개념별 검증 (서브에이전트)

각 개념마다 **general-purpose 서브에이전트** 호출, "Socratic Examiner" 페르소나.

#### 서브에이전트 동작 패턴

메인이 서브에이전트를 호출할 때마다 다음 정보 전달:
- 검증 대상 개념
- 출제 컨텍스트 (관련 강의 자료 발췌)
- 평가 기준 (Bloom: Understand 통과 = mastered)
- 지금까지의 다이얼로그 (transcript)
- 사용자 최신 답변

서브에이전트는 다음 중 하나 결정:
- **continue**: 다음 질문 (의심 follow-up)
- **finish**: 평가 (mastered / surface / gap + 구체적 gap)

#### 서브에이전트 프롬프트 템플릿

```
당신은 "Socratic Examiner" 입니다.
학생이 다음 개념을 진짜 이해하는지 검증합니다.

[검증 개념]
{concept}

[출제 컨텍스트]
{relevant lecture content + guide.md excerpt}

[평가 기준]
- Bloom Understand 이상 통과 → mastered
- Recall 만 가능, "왜"를 못 설명 → surface
- 잘못된 mental model → gap (구체적 gap 명시)

[규칙]
1. 깊이 우선 — 이 개념 안에서만 probe, 다른 개념 곁가지 금지
2. trick question / trivia 금지 (필수 개념만)
3. 표면적 답변에는 한 번 더 의심 ("왜 그렇게 되는지 설명해줘")
4. 깊이 있는 답에는 인정하고 종료
5. Max 3 follow-up (이미 3회 probe 한 후엔 무조건 finish)
6. 사용자 답변에 잘못된 mental model 보이면 즉시 gap 마킹
7. 의심을 위한 의심 금지 — 실제로 부족한 점이 있을 때만 probe

[지금까지 transcript]
{transcript}

[학생 최신 답변]
{latest answer}

[당신의 결정]
다음 JSON 형식으로 답변:
{
  "action": "continue" | "finish",
  "next_question": "...",  // continue 시
  "assessment": "mastered" | "surface" | "gap",  // finish 시
  "gap_description": "..."  // finish + (surface | gap) 시
}

next_question 작성 규칙:
- 구체적, 사용자 답변에 대한 직접 follow-up
- 일반 "왜?" 금지 (사용자 단어 인용)
- 답변 길이는 1-2 문장으로 이끌도록
```

#### 다이얼로그 운영 (메인 에이전트 역할)

```
loop:
  서브에이전트 호출 → action 받음
  if action == "continue":
    next_question 사용자에게 보여줌
    사용자 답변 받음
    transcript 업데이트, 다시 서브에이전트 호출
  if action == "finish":
    평가 결과 저장
    break
```

#### 다이얼로그 예시 (성공)

```
[메인] BPE 동작 원리 검증 시작.
       서브에이전트 첫 질문: "BPE가 byte 단위에서 시작하는 이유는?"
[사용자] 모든 문자를 표현 가능해서

[메인] 서브에이전트 호출 (transcript 포함, 사용자 답변 전달)
[서브] "그건 부분적 답. character로도 모든 문자 표현 가능. 왜 굳이 byte?"
[메인] 사용자에게 보여줌
[사용자] vocab 시작이 256으로 작아서 merge로 통제 가능

[메인] 서브에이전트 호출
[서브] action: finish, mastered (vocab/merge 관계 이해됨)
[메인] ✅ BPE 동작 원리 — mastered
       다음 개념으로
```

#### 다이얼로그 예시 (gap 식별)

```
[서브 Q1] BPE merge 우선순위는 어떻게 결정?
[사용자] 빈도 높은 쌍 우선

[서브 Q2 (의심)] 학습 시점에 우선순위가 정해지나, 인코딩 시점에 정해지나?
[사용자] 모르겠음

[서브 finish] action: finish, gap
gap_description: "학습 시점 vs 인코딩 시점의 merge 적용 차이 이해 부족"

[메인] ❌ BPE merge 우선순위 — gap
       gap: 학습 시점 vs 인코딩 시점 차이 이해 부족
```

### Step 3: 결과 → 노트 업데이트 (사용자 확인 후)

#### 업데이트 대상

- **gap 결과** → `[ ]` 추가 (구체적 gap 설명)
- **surface 결과** → `[ ]` 추가 (어떤 부분이 약한지)
- **이전 [ ] 가 mastered** → `[x]` close (간단한 결론 inline)
- **mastered (이전 [ ] 아님)** → 노트에 안 적음 (채팅에만)

#### 일괄 사용자 확인

```
다음 변경사항을 workspace/notes/lec01.md 에 적용할까요?

추가될 [ ] (액션 아이템):
+ [ ] BPE merge 메커니즘 — 학습 시점 vs 인코딩 시점 차이 (퀴즈 gap)

닫을 [x] (이전 미해결, 퀴즈에서 확인됨):
+ [x] tokenization이 LM에 미치는 영향 → 시퀀스 길이/메모리/효율 trade-off (퀴즈 확인)

[Y/N]
```

사용자 Y → 노트 업데이트
사용자 N → 노트 안 건드림 (퀴즈 결과는 채팅에 그대로 남음)

#### 노트 업데이트 형식

```markdown
## 2026-05-08
- [ ] BPE merge 메커니즘 — 학습 시점 vs 인코딩 시점 차이 (퀴즈 gap)
- [x] tokenization이 LM에 미치는 영향 → 시퀀스 길이/메모리/효율 trade-off (퀴즈 확인)
```

- **출처 표시**: `(퀴즈 gap)`, `(퀴즈 확인)` 짧게
- **이전 `[ ]` 의 라인 자체를 수정** (별도로 새 줄 추가 X) — history 보존하되 결과는 한 곳

### Step 4: 종합 보고 (최종 출력)

```
검증 결과:
✅ BPE 동작 원리 — mastered
✅ vocab 크기 trade-off — mastered
❌ BPE merge 메커니즘 — gap
   학습 시점 vs 인코딩 시점 차이 이해 부족

노트 업데이트: 1개 [ ] 추가, 1개 [x] close (적용됨)

다음 행동 제안:
- BPE merge 섹션 다시 확인 (workspace/spring2025-lectures/lecture_01.py:533-563)
- 다음 학습 시작 시 [ ] 자동 표시됨
```

## 안티패턴 (절대 안 함)

1. ❌ **Trivia / 숫자 trick** ("BPE가 정확히 몇 token vocab?")
2. ❌ **다른 개념 곁가지** 검증 중인 개념 안에서만
3. ❌ **3회 이상 probe** (max 강제)
4. ❌ **표면적 답에 그냥 통과** (한 번은 의심)
5. ❌ **의심을 위한 의심** (실제 부족 점 없는데 더 묻기)
6. ❌ **노트 verbatim 출제** ("노트에 X라고 적었던데, X가 뭐야?")
7. ❌ **자동 노트 업데이트** (사용자 확인 필수)
8. ❌ **mastered 결과 노트 추가** (actionable 만)

## 자족적 답변에는 즉시 종료

서브에이전트가 첫 답변에서 이미 깊이 있다고 판단하면 → 바로 mastered.
의심을 위한 의심 금지.

예:
```
[서브 Q1] BPE가 byte 단위에서 시작하는 이유는?
[사용자] vocab 시작이 256으로 작아서 — Unicode character 14만개 대비 통제 가능. 
        그 위에서 코퍼스 빈도 기반 merge 로 vocab을 키워나감.

[서브 finish] action: finish, mastered (이미 mechanism + reason 모두 설명됨)
```

→ 한 번에 끝. 굳이 더 묻지 않음.

## 서브에이전트 호출 (general-purpose)

```python
Agent(
  description="Examiner: {concept}",
  subagent_type="general-purpose",
  prompt=examiner_prompt_template_filled
)
```

## 출제 소스 우선순위

```
1. lectures/lec{NN}-*/guide.md  ← 학습 목표 (필수 개념의 정의)
2. workspace/spring2025-lectures/lecture_{NN}.py  ← Stanford 원본 (검증 가능한 진실)
3. workspace/notes/lec{NN}.md  ← 사용자 [ ] (주관 보조)
```

guide.md 가 없으면 lecture_{NN}.py 에서 핵심 추출.
notes 가 없거나 [ ] 가 없으면 객관만으로 출제.

## 사용 시점 (CLAUDE.md 권고)

- 강의 한 단위 학습 끝났을 때 1회
- "이해했는지 확인해줘" 류 명시 요청
- 자주 쓰면 피로 → 빈번한 호출 권장 X

## 다른 스킬과 협업

```
학습 (페어러닝)
   → /cs336-note 로 노트 누적
   → /cs336-deep-quiz 로 검증
   → gap 발견 시 노트에 [ ] 자동 제안 (사용자 확인)
   → 다음 학습 시 /cs336-note --start 로 [ ] 표시
   → 다시 학습/검증
```

→ **닫힘 루프** ✓

## 디자인 결정 기록

- **서브에이전트 선택**: Examiner 페르소나 분리 → 메인의 페어러닝 친근함 보호 + 검증의 객관성
- **개념 default 3**: depth > breadth, 5개 이상은 피로
- **객관 2 + 주관 1**: 강의 핵심 + 사용자 자기 의심 균형
- **max 3 probe**: 끈질김과 짜증 사이 균형
- **노트는 actionable 만**: mastered 기록은 노이즈
- **사용자 확인 후 노트 업데이트**: 자동 변경은 통제권 박탈
- **이전 [ ] mastered → [x] close**: 닫힘 루프 (학습 진보 가시화)

## 사용 예시 (전체 흐름)

```
사용자: /cs336-deep-quiz

AI: [컨텍스트] Lecture 1 - Tokenization 검증할게요.
    
    이 3개 검증 대상으로 골랐어요:
    1. BPE 동작 원리 (학습 목표)
    2. vocab 크기 trade-off (학습 목표)
    3. tokenization이 LM에 미치는 영향 (당신의 미해결 [ ])
    
    OK? 조정 원하시면 알려주세요.

사용자: OK

AI: [개념 1] BPE 동작 원리 검증 시작.
    
    Q: BPE가 byte 단위에서 시작하는 이유는?

사용자: 모든 문자를 표현 가능해서

AI: (서브에이전트 의심) character로도 모든 문자 표현 가능한데, 왜 byte를 택했을까?

사용자: vocab 시작이 256으로 작아서 merge로 통제 가능

AI: ✅ mastered. 다음.
    
    [개념 2] vocab 크기 trade-off 검증.
    Q: vocab 크기를 키우면 어떤 것이 나아지고 어떤 것이 나빠지나?

사용자: 시퀀스 길어진다? 어렴풋이...

AI: (서브에이전트 의심) "시퀀스 길어진다"는 vocab 키우면 어떻게 된다는 거야? 길어져, 짧아져?

사용자: 헷갈림. 짧아지는 듯?

AI: (서브에이전트 의심) 짧아진다고 생각하는 이유는?

사용자: vocab이 크면 한 token이 더 긴 문자열을 나타내니까

AI: ✅ surface→ recovered to mastered. 다음.

    [개념 3] tokenization이 LM에 미치는 영향 검증.
    ...

[전체 검증 완료 후]

AI: 검증 결과:
    ✅ BPE 동작 원리 — mastered
    ✅ vocab 크기 trade-off — mastered (probe 후 회복)
    ❌ tokenization이 LM에 미치는 영향 — gap
       sequence length 와 attention 비용의 관계 이해 부족
    
    노트 업데이트 제안:
    + [ ] sequence length 와 attention 비용 관계 (퀴즈 gap)
    + [x] tokenization이 LM에 미치는 영향 → 시퀀스 길이가 attention/메모리에 직접 영향 (퀴즈 일부 확인)
    
    적용할까요? [Y/N]

사용자: Y

AI: ✓ workspace/notes/lec01.md 업데이트됨.
    
    다음 행동 제안:
    - attention 비용은 Lec 5-6 (GPU/Kernel) 에서 더 깊게 다룸
    - 다음 학습 시작 시 [ ] 미해결 자동 표시됨
```
