
<!-- authors: Seungku Kim * 1 Suhyeok Jang * 1 Byungjun Yoon 1 Dongyoung Kim 1 2 John Won 1 Jinwoo Shin 1 2
*Equal contribution 1KAIST 2RLWRLD.  -->
<!-- arxiv link TBD -->


<!-- static/images/robocurate_main_figure.png -->
## Abstract
We present RoboCurate, a novel neural trajectory generation framework that increases diversity via controllable video generation and filters low-quality samples by evaluating motion similarity between generated video and simulator replay. Specifically, RoboCurate replays the predicted actions in a simulator and assesses action quality by measuring the consistency of motion between the simulator rollout and the generated video. In addition, we unlock observation diversity beyond the available dataset via image-to-image editing and apply action-preserving video-to-video transfer to further augment appearance.


## Method

<!-- generation 1 figure image in images/robocurate_stage1_generation.png -->
1. Generation Stage:
We expand observation diversity with two components: (1) image-to-image (I2I) editing on the initial frame for scene-level variation, and (2) video-to-video (V2V) transfer for appearance diversity while preserving initial motion.

<!-- filtering 1 figure image in images/robocurate_stage2_filtering.png -->
2. Filtering Stage:
We filter suboptimal synthetic trajectories with inaccurate actions by replaying the predicted actions in a simulator and assesses action quality by measuring the consistency of motion between the simulator rollout and the generated video. We train an attentive probe on top of a frozen video encoder to measure motion similarity between the simulator rollout and the generated video with automatically generated positive and negative samples from real data.

<!-- 2 column section (both column should have same height)
for left column have 2 rows where on top row videos/good_action_alignement with caption: Accurate action: Simulator rollout = Synthetic video and bottom row videos/bad_action_alignement with caption: Inaccurate action: Simulator rollout ≈ Synthetic video and 
for right column data overview image in images/data_overview.png caption: Examples of negative and positive pairs for attentive probe training. -->


## Results
ALLEX Humanoid robot

3 column for 3 methods (Real, Real + DreamGen, Real + RoboCurate (Ours)
3 row for 3 tasks In-distribution, Out-of-distribution (Novel Object), Out-of-distribution (Novel Behavior)
In-distribution: Pick and Place Can
Out-of-distribution (Novel Object): Pick and Place Cup
Out-of-distribution (Novel Behavior): Pour Can
<!-- refer to videos/* -->



GR-1 Tabletop
We report the average success rate (%) over 50 trials across 24 tasks (18 rearrangement and 6 articulated)
<!-- result static/images/gr1_tabletop_result.png -->

DexMimicGen
We report the average success rate (%) over 50 trials across 6 tasks (3 GR-1 Humanoid and 3 Bimanual Panda Arms (Dexterous Hands)), trained with 100 demonstrations per task.
<!-- result static/images/dexmimicgen_result.png -->

we observe that our visual augmentation pipeline (e.g., I2I editing and V2V transfer) substantially improves downstream task performance. Moreover, our action-level filtering is effective for curating neural trajectory and further enhances VLA performance.