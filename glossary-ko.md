# 영-한 용어집

CS336에서 자주 등장하는 용어 정리. 학습하면서 계속 추가할 예정.

## Tokenization

| 영어 | 한국어 | 설명 |
|------|-------|------|
| Tokenization | 토큰화 | 텍스트를 모델이 처리 가능한 단위로 쪼개는 과정 |
| BPE (Byte Pair Encoding) | 바이트 페어 인코딩 | 자주 등장하는 byte 쌍을 합쳐 vocabulary를 만드는 방식 |
| Vocabulary | 어휘집 | 모델이 알고 있는 토큰 집합 |
| Subword | 서브워드 | 단어보다 작은 단위의 토큰 |
| Merge rule | 머지 규칙 | BPE에서 어떤 byte 쌍을 합칠지 정한 규칙 |

## Architecture

| 영어 | 한국어 | 설명 |
|------|-------|------|
| Transformer | 트랜스포머 | Attention 기반 아키텍처 |
| Attention | 어텐션 | 입력 토큰 간 관계를 학습하는 메커니즘 |
| Self-attention | 셀프 어텐션 | 같은 시퀀스 내 토큰 간 attention |
| Multi-head Attention | 멀티 헤드 어텐션 | 여러 attention을 병렬로 계산 |
| Positional Encoding | 위치 인코딩 | 토큰의 순서 정보를 모델에 전달 |
| Mixture of Experts (MoE) | 전문가 혼합 | 입력에 따라 다른 sub-network를 활성화 |

## Training

| 영어 | 한국어 | 설명 |
|------|-------|------|
| Optimizer | 옵티마이저 | 파라미터 업데이트 알고리즘 |
| Learning rate | 학습률 | 파라미터 업데이트 크기 |
| Gradient | 기울기 | 손실 함수의 파라미터에 대한 미분 |
| Backpropagation | 역전파 | 그래디언트를 출력에서 입력 방향으로 계산하는 과정 |
| Batch size | 배치 크기 | 한 번에 처리하는 샘플 수 |

## Systems

| 영어 | 한국어 | 설명 |
|------|-------|------|
| Kernel | 커널 | GPU에서 실행되는 연산 단위 |
| Triton | 트리톤 | GPU 커널 작성을 위한 Python DSL |
| Parallelism | 병렬화 | 여러 장치에 작업을 분산 |
| Data Parallelism | 데이터 병렬 | 같은 모델, 다른 데이터를 GPU별로 처리 |
| Tensor Parallelism | 텐서 병렬 | 한 텐서를 여러 GPU에 나눠 처리 |
| Pipeline Parallelism | 파이프라인 병렬 | 모델 레이어를 여러 GPU에 나눠 처리 |

## Scaling

| 영어 | 한국어 | 설명 |
|------|-------|------|
| Scaling Law | 스케일링 법칙 | 모델/데이터/연산량과 성능 관계를 나타내는 법칙 |
| Compute | 연산량 | 학습/추론에 필요한 계산량 (FLOPs) |
| FLOPs | 부동소수점 연산 수 | Floating Point Operations |
| Inference | 추론 | 학습된 모델로 예측을 수행 |

## Alignment

| 영어 | 한국어 | 설명 |
|------|-------|------|
| Alignment | 정렬 | 모델을 사람의 의도/선호에 맞추는 과정 |
| SFT (Supervised Fine-Tuning) | 지도 미세조정 | 정답이 있는 데이터로 추가 학습 |
| RLHF | 인간 피드백 강화학습 | Reinforcement Learning from Human Feedback |
| Reward Model | 보상 모델 | 응답의 좋고 나쁨을 점수화하는 모델 |
| Policy | 정책 | 강화학습에서 행동을 결정하는 함수 |
