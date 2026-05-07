# CS336 학습 로드맵

전체 19개 강의 + 5개 과제를 **6개 Unit**으로 나누어 단계적으로 학습합니다.

## 전체 구조

| Unit | 강의 | 과제 | 주제 |
|------|------|------|------|
| 1. Foundations | Lec 1-4 | Assignment 1 | Tokenization, Transformer, MoE |
| 2. Systems | Lec 5-8 | Assignment 2 | GPU, Triton, 병렬 처리 |
| 3. Scaling | Lec 9-12 | Assignment 3 | Scaling Laws, Inference, Evaluation |
| 4. Data | Lec 13-14 | Assignment 4 | 데이터 수집/필터링/중복 제거 |
| 5. Alignment | Lec 15-17 | Assignment 5 | SFT, RLHF, RL for Reasoning |
| 6. Guest | Lec 18-19 | - | 초청 강연 |

## 📍 Phase 1: Foundations (가장 중요)

LM의 모든 기본 요소를 직접 구현합니다. **이 단계가 코스의 핵심**입니다.

### 강의
- **Lecture 1** — Overview, Tokenization (BPE)
- **Lecture 2** — PyTorch, Resource Accounting
- **Lecture 3** — Architectures, Hyperparameters
- **Lecture 4** — Mixture of Experts

### 과제
- **Assignment 1: Basics**
  - BPE Tokenizer 구현
  - Transformer 아키텍처 구현
  - AdamW Optimizer 구현
  - 미니 LM 학습

⏱ **예상 기간**: 3~4주 (주당 10~15시간)

📌 **학습 가이드**: [`lectures/`](./lectures/), [`assignments/a1-basics/`](./assignments/a1-basics/)

## 📍 Phase 2: Systems

GPU 활용과 분산 학습을 다룹니다.

- Lec 5: GPUs
- Lec 6: Kernels, Triton
- Lec 7-8: Parallelism (Data, Tensor, Pipeline)
- Assignment 2: 메모리 효율적 분산 학습 코드 작성

## 📍 Phase 3: Scaling & Performance

- Lec 9, 11: Scaling Laws
- Lec 10: Inference
- Lec 12: Evaluation
- Assignment 3: Scaling laws 측정 및 fitting

## 📍 Phase 4: Data

- Lec 13-14: Data
- Assignment 4: 데이터 필터링/중복 제거 파이프라인

## 📍 Phase 5: Alignment & RL

- Lec 15: SFT/RLHF
- Lec 16-17: Reinforcement Learning
- Assignment 5: SFT + RL for reasoning tasks

## 📍 Phase 6: Guest Lectures

- Lec 18: Junyang Lin (Qwen)
- Lec 19: Mike Lewis

## 사전 지식

- **필수**: Python, 기본 ML 개념
- **권장**: PyTorch, Transformer 이해, 선형대수
- **GPU**: Assignment 진행 시 클라우드 GPU 권장 (Modal, Lambda Labs, RunPod)

## 학습 팁

1. **강의는 직접 시청** — 영상은 본인이, 정리는 한국어로
2. **과제는 직접 구현** — 막히면 힌트만, 정답은 보지 말 것
3. **노트 작성 → 검증** — 본인 언어로 정리한 후 누군가에게 설명할 수 있는 수준이 목표
4. **Phase 1 이후는 관심사에 따라** — 시스템/스케일링/정렬 중 끌리는 곳부터
