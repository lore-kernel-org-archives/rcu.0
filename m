Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991937;
	b=Q0ZR7hqi1BK8c4oyZTStAcTy3KMwwCu9k+0raHDKNkWf3EBzR6HkkDw4A8ZCqghkpRsX
	 OmI3IZspi2EU4IbKtBvIS4uV2W0RGgD7eoMOCE5TQPLHga8ie/M1vizAyeakS5NaVY/Xh
	 TexKGqH2+0VTVHRbqpDEQ7yZgRU5t/UUWS2fIl4Z1+GxKRNRK2ZtbPEczTwpmIS4fSsGb
	 axca98/ZhDEaWAfEscWGSItcfmq0/rX14rQWiQ2anXQQTs2vsNTTuVZX5ssw6ifI6a430
	 Q4+YDs7rYspOnC/XQetO3JcqtNFzUBADqNwKXpDvdRZR4jzbdDGvOEAl0hQcV/wVMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1WgGB0H3hcDggQb2lPP883pQXAgEMa/uaMUXMUun2LY=;
	b=BYozHsQacFV1sm8ZTAQv4e0fVwEaUoT4Ou4MvAnni2YKPtTGdsTkB7xM5HaoAp67NZ6+
	 R3DL4QMYGGLsHbzTqedjmfq4hiYfpjpidVk0P8rhcuBOXOcwueUs/Zkw5dFq+AbzC/+58
	 zJcC3qGhirAsAZ9UnHf9atDEcPgpYdyRHW/6bcVeHojnf02kTSIv173EGHSHcBSsO2kuW
	 pap26+1V1TmkHTDWMDHo9LxiA65Pt/OThu+C8kIxyEiqAiJmINigliM4qNwr2e4X5ujG/
	 Lh+wbvi28xcfPA/+Y+GQ6RksOds1qF/12snHwmE6KeY9lH4TnyNmjRMwe+N6EMRaUIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZAa9UMj;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD3606A32A
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 08:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CD3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZAa9UMj
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50604721c8so94018166b.3
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 00:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991936; x=1795596736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1WgGB0H3hcDggQb2lPP883pQXAgEMa/uaMUXMUun2LY=;
        b=yZAa9UMjhDpG2TGaelaJuE/Na+kQoKQBM9+lmtZCW+GUegJ+lTWRsrqFSVCz6r/agu
         ZSVsi9W6YPJ5AuqzSuefmYJVg47Xjyzo+XVWBq3/NAGc6BIh7SwnrbTsv3GJ0T5F/Cza
         i33nf9jxedKGqSaG3G/PupuTkiS5Iig1G+YghTu/jshQ02LEf7iZyNEFWrDGcPx/FpjR
         gUoZao4NRq6M3ckuq/2dHvCxXnoGIn+U2K8hfeku67cVeowUiooGIYJRvsjpLTKi+LfX
         QeNkxAmIeSvAbFyvYFh8JyuTQUm3xs5PyCwOEdNzqgMRcluyvhfO6aZQGxMC7LCk+uAk
         j/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991936; x=1795596736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1WgGB0H3hcDggQb2lPP883pQXAgEMa/uaMUXMUun2LY=;
        b=cU/H0cd8PJkTYQVNh673zYlzN5SSAzIifYthd4P++pmAv1Fc6Ij0v1Uf5LMjnecRfP
         MyU759xUjEhajjR7W5gtANI4NKPR2ixsFta8McawC8c8gXqR4MtPLgHEQCuauLWqX3Pu
         z1X0Ks3cfRpXB3A91VCkUDoYILRGlm5ZHUC4YM5VN0l0nDYhoJbMh7kRY/Mt/5suL7id
         0wzK47sEMGJ9pCxfTnwQ5s++kroDFSWcgHHHzl5ntrKKael/7JAv9WkkW2IQ2l2NEmb9
         hG9whgGI4NzfSrXRYBrhWeUkeAay9Y0lF8ii3r58/JtmZOV+GolcWejOatSEErMmLHdg
         7GHQ==
X-Forwarded-Encrypted: i=1; AL+hErH2x8MTpZ1KxYJGhSdXyT4sPZuqQj/ekg2tF0NgV5exnhjNAKOY0zbjJXD+LtAlPBj5x5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z96GfAfsBXZzdX1CGIRwS+6BLSLZC39qcg2OoLap0q3XP/r25SM
	U73VvBVYCOXF2fFl1TEgWN+DjbPprT6/dhKDvqvhAx3LJ7FpOQxyK2UR
X-Gm-Gg: AYBFou2JWdrlla+/qejZWBPRKFp8Bnr6K8gjNbhcB8elw/X/RBs0TL5ARItArrhyDZF
	TgQPzHnd0PjfIzHMD/pVl6liY/64MC4UJPqykUuSkZPlCkj7k5XnWc27LvsD+GPtr3p+rOH0Fzh
	MJuHIQli7+XViZjt6zjHEtUbjSOxpARJAcHkm8rfNxoeZHvXUVmI67GsOqX8uIZi0Nht/i+LWo8
	QCXs3BRhATbHP7bpwpm0lHoGOq8wREeoUU2MeJfYOuhW+1fDg8LdI/InntS18Fc3zrhRoKTOyrX
	Z0Sx3xX119rvxhlcmUBgvS9/gGAFNOXCuhZfdpPxIE9FppFFNqaELfctYp3Cz2FvEV8zFwQLPbY
	5TimiUxFjF7uCP2ctADWLhjLvcEHONLLEkvDxMhUyY+ms6qUcWFdM3OtmI6eLwj2gMOnvm0p0Nt
	XsHdkrDynvrzQaG2hVc0QMbUk2kl5Lvw5G+zHNEf9kfu3S0QRZUoHJ7JEtIPY0FDLuY2X7pYlAp
	AgBlgW/+WUPQKnTa0mt+OCuLJqEUVSsEzC1zeEfhbdVH41GQpyER8PXk+Q5W0m13B0V9Bv8A4mD
	KT2U6Af0RwGAi6O4v9T5PKvBmlZPiMOa/qE8
X-Received: by 2002:a17:907:86a3:b0:c29:f5d8:9c78 with SMTP id a640c23a62f3a-c510e36c026mr129861766b.39.1794991934985;
        Wed, 18 Nov 2026 00:52:14 -0800 (PST)
Received: from kernel.. ([191.40.25.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm71077266b.10.2026.11.18.00.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:52:14 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 0/7] rcu: Record callback enqueue stacks and add torture tests
Date: Wed, 18 Nov 2026 16:51:40 +0800
Message-ID: <20261118085147.1668598-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series records the enqueueing stack for RCU Tasks callbacks and
adds rcutorture coverage for duplicate callbacks and KASAN
auxiliary-stack recording.

Changes since v1, in response to feedback from Joel Fernandes,
Paul E. McKenney, and Zqiang:
v1: https://lore.kernel.org/all/20261106143913.3627722-1-kunwu.chan@gmail.com/

- Dropped the RCU_KASAN_AUX_TEST module, its Kconfig flavor choice,
  and the five *KASAN01 scenarios.  The verification is now an
  rcutorture self-test that uses the selected flavor's callback and
  barrier operations, enabled by the new
  rcutorture.kasan_debug boot parameter, so it can be run from
  kvm.sh --kasan with existing scenarios.

- rcu_test_debug_objects() now skips flavors that do not set
  ->debug_objects.  The flag previously guarded only the
  ->call()/->cb_barrier() sanity check, so torture_type=trivial
  with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and
  rcutorture.object_debug=1 invoked a NULL function pointer.
  This panic was reproduced before the fix and verified fixed
  after it, with identical rcutorture arguments.

- New in v2: kasan-aux.sh automates the auxiliary-stack checks using
  kvm.sh --kasan, existing scenarios, and the existing checkers,
  ending with a single kvm-recheck.sh pass over the filtered logs.
  kasan-aux.sh can run and check the auxiliary-stack test on its
  own.  The final patch also runs it from torture.sh when both RCU
  and KASAN testing are enabled.

Tested on x86_64 with kvm.sh --kasan, kasan_multi_shot, and
rcutorture.kasan_debug=1 (30-second runs, built kernels reused via
kvm-again.sh to select flavors):

  Scenario Flavor         "Last potentially related work creation"
  TASKS01  tasks          call_rcu_tasks_generic
  TASKS01  rcu            __call_rcu_common
  TASKS01  srcu           __call_srcu
  TASKS01  tasks-tracing  __call_srcu
  TINY01   rcu            call_rcu
  TINY01   srcu           call_srcu

kasan-aux.sh checks for rcu_test_kasan() in the auxiliary stack.  
All runs reached "End of test: SUCCESS" with one intentional report, 
which the torture summary flags (Bugs: 1) as it flags the 
intentional warnings from rcutorture.object_debug=1.

Also verified:
- tasks with object_debug=1 and kasan_debug=1, 3-minute run:
  the four intentional debugobjects warnings, then the KASAN
  report, then SUCCESS with barrier: 633/633.
- Direct kvm.sh runs of trivial, tasks-rude, and busted with one or
  both self-tests enabled: clean skip messages, no splats, exit code 0.
  kasan-aux.sh expects these flavors to skip.
- TASKS01 without KASAN and kasan_debug=1: test skipped,
  exit code 0.
- tasks with both self-tests disabled: no splats, exit code 0.
- kasan-aux.sh --check negatives: a TINY01 build with
  kasan_record_aux_stack() compiled out of call_rcu() fails with a
  missing auxiliary stack, and a non-KASAN run is rejected at the
  configuration check.

Keep this test out of runs intended to find real KASAN bugs:
KASAN suppresses reports after the first unless kasan_multi_shot
is also supplied, and the report taints the kernel.

The seventh patch runs kasan-aux.sh from torture.sh on the scenarios
selected by --configs-rcutorture, so the added kernel builds scale
with that selection; --no-kasan or dropping that patch avoids them
entirely.  Feedback on whether that default is worthwhile would be
welcome.

For example:

  tools/testing/selftests/rcutorture/bin/kvm.sh --configs TASKS01 \
    --kasan --duration 30s \
    --bootargs "rcutorture.kasan_debug=1 kasan_multi_shot"

  tools/testing/selftests/rcutorture/bin/kasan-aux.sh

This series was tested on top of [1] with Joel's RCU Tasks barrier
debugobjects fix [2] applied.

[1] https://lore.kernel.org/all/20261027070923.3054462-1-kunwu.chan@gmail.com/
[2] https://lore.kernel.org/all/20261104153046.965890-1-joelagnelf@nvidia.com/

 
Kunwu Chan (7):
  rcu-tasks: Record callback enqueue stack
  rcutorture: Require debug_objects flag for debug-objects test
  rcutorture: Test duplicate call_rcu_tasks() callback enqueue
  rcutorture: Test duplicate call_rcu_tasks_trace() callback enqueue
  rcutorture: Add KASAN aux-stack self-test
  rcutorture: Add kasan-aux.sh aux-stack checker
  rcutorture: Run KASAN aux-stack checks from torture.sh

 Documentation/RCU/torture.rst                 |  46 ++++
 .../admin-guide/kernel-parameters.txt         |  11 +
 kernel/rcu/rcutorture.c                       |  55 ++++-
 kernel/rcu/tasks.h                            |   4 +
 .../rcutorture/bin/kasan-aux-check.sh         | 158 ++++++++++++
 .../selftests/rcutorture/bin/kasan-aux.sh     | 228 ++++++++++++++++++
 .../selftests/rcutorture/bin/torture.sh       |   9 +
 7 files changed, 509 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kasan-aux.sh

-- 
2.43.0

