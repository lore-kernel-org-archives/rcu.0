Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975981;
	b=wCaynIIAfdULXG9EZgMFxuemGoM5cO7Q9bTqbkMhZZtwTs+3ULmnWfVYueL21q2eLs3G
	 g8V9UN09L+bluc1Ta23Iu/U4RxTpckpqr9eB68D7KsjvRtFYlBdYBCsh2BzYSG0jFijgj
	 IQHSYHT9/kTkd1BkK18Aq625ZePEGpfjMbBP+UKnzKRvntWPh0/Y9ap2NquuT9LruGh1x
	 tSVuSUYWIOAfQzFC/Vsc0pxrm6ofxIdjE2dKCg+qPYRdXzI/QZ4guxJUTPXALNiNvGAvm
	 IZRkbjC5knHmVhYFaqJkP4sm2lgNzUIi6h62YPmrU/0EXxIegXJlVxXHaD0b2xqu8dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uby/azzGeVUPOBj9cIS7TzhQ50RQ5+dHAaKVnGJvY20=;
	b=GgRtCEtPrZQI7Bi32giWUt9R6lJyqr17aHgFyqcowR3dqxjpx8NazaQpAe0FW4jcz+g9
	 wyJxbjHzxIBwU8B+GESch7Mqz3jQ/KVMM8/2pb5d0cPTnivyDQr4mnSVhtyZXsZHbjM2s
	 /5dqg0SVPla/fgobBzCUzEgtSZKWjPZm7LdsDfe8DSEGKgHENHx0La2k1vL66SrMFmREz
	 ncA7TmY1rpb4WOci11xNVK0g+N6+KsZE7PhD+HZWmR4oz/ohOF56PFceGF5+cYaIiMMlh
	 yw2jg0vHQBg1O4PeaAurucn32/unaamiAvdC0zoq+J5zqCBtbEXqzE5u+Jf49av7ToQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMHM6gXx;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBF606A329
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 14:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60DBF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMHM6gXx
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so2205741c88.1
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975979; x=1794580779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uby/azzGeVUPOBj9cIS7TzhQ50RQ5+dHAaKVnGJvY20=;
        b=ZMHM6gXxRODvX0c9H3q8RpqsUMvpaIdJ2sh1WlzcrOw3qSB7vyD7tfmrqNNlv2cbEn
         JUvEUVgo/sIxUwBd0Dvezlq0F0ncY1aHpV03WmLIfm4lbLtI/GWKrU2Swy0c/jkEXnMl
         /fZo70YLyrv73twujbTgNVFTRsmmM1Je3ggjG7bjWc/ZAtCkNh8fG1HrZZ2cWbRKB2Np
         fiKTl9FIyFGf6eIYp6BGSsNZxU/SXosLZgpM6ty1F6EjTH2DZiP+RyZmjLc3zWDqq6O5
         xKL8RdeVKDbUO+HLUcfdMF2PjPM6aE/QOLyWvsuQAaBoU86DRh9YmN81H3rOHHcdOu77
         NhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975979; x=1794580779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uby/azzGeVUPOBj9cIS7TzhQ50RQ5+dHAaKVnGJvY20=;
        b=EZY/3QTPFkYcbdSMre7YSRZXLjoZPHyqLuEUyjIMqWNZSuYVhnNy42ySce+d8C+qxh
         i1kSCteEyvj2uhp1mMTxAde/fHwRhtLvnXjsuZkyehQzrZfxWTay6QMSz1+Bo3lgTNik
         qhEKMzqMqApZt0HLXWYyqvmwSoMEvxgqIiFQW4ncziIx9XBDKpvhlWq0DTxctRRKZJeg
         e1HRSFATMwJaWJbAcLBglUS84rg3HAqFTCH1drQckd8z0bQVXz4PGoic2P+H2hvXm3p1
         4LYg80VbepMvUGOW9WceVAKrXSiq73vQ4ZOKPiFfLl8uN/g1nP64vbbIdG2aMLUoRTSR
         8YOw==
X-Forwarded-Encrypted: i=1; AL+hErHxhqrE39vs5tAII/RjNelpHvhkgyET9n2/FJU+c4sb/huidWQAqPsmd0HZ+kUYMrugeb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uFy+oLswwVyV2feDH58jx2erLx1SrGsaZoaB1W0J1VLeuH2KI
	eiNHINEAYcIf79KGVROG1puJ4z1NEEAWULtoK+9xl/We92E4nUhA+S/NUyz98jW89nU=
X-Gm-Gg: AYBFou2Aw8G4THUGABiqBoARPwzuNerYOQvLFWwn9RwORn/Yq3NY0Xe1jeoGNdDveCl
	a0+VfojCwTONOp15C+QOwQbnXjwCGNiup8hxuo5GrD6BvEEM8ApNfj6zLaB3AbzBfQTmfD1QLir
	I5T2yPSyqbk7k7Gu10oznrIBrQ1j+YSuccnIEr/4aF12yzRP5yCFjmMK+5JPIPGoWWdiDh8pyk6
	5d4KNFKUtAG1b/PLqNNG180KtikSIuB/3SQybVMfAciaKspsHRwAmAUOt7dBvISq2GJoENImKUN
	u5Ep3PvgwxKjamQP3l1qaOacPr4tzQaZQj5fz7VWWxiTsfoGMDUB+bfw57ErjzA8BT18ZafPLJd
	/rtTXKmHmgONeQqwrEaurZ3Zco+Syf7m9BS0YEGU7NalzvAgPEec5Nw2x+DAQwRIVc49vKJaUKr
	WXpR86VX8LNAlLn22Ad0yHjJ+nDzJ/R0tFLeUKW24LJAz7mjvzYALoAtFCThRS7OKG+PVkI30Av
	cNDuQYwO4oV+Xk+s5rfGeWHBHMbxK+tmteitXtyflJrHTXftY6+xmMXEAOe+udpeiTosGRffbi5
	jUFhHziWS9U7MtXOXOdl+ygR99m/UKq56uRTBcg=
X-Received: by 2002:a05:7300:8281:b0:369:f2f4:b227 with SMTP id 5a478bee46e88-36f75b1ffd2mr3080840eec.18.1793975978031;
        Fri, 06 Nov 2026 06:39:38 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7182068eec.26.2026.11.06.06.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:36 -0800 (PST)
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
Subject: [PATCH 0/5] rcu: Record callback enqueue stacks and add torture tests
Date: Fri,  6 Nov 2026 22:39:08 +0800
Message-ID: <20261106143913.3627722-1-kunwu.chan@gmail.com>
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

This series adds KASAN auxiliary stack recording for RCU Tasks
callbacks, rcutorture coverage for duplicate-callback detection,
and KASAN aux-stack verification tests across RCU and SRCU flavors.

This series is based on [1]. For testing, I also applied Joel
Fernandes' fix for debugobjects tracking of barrier callbacks
[2], which is needed for the barrier tests.

The changes:
- Record the enqueueing stack in call_rcu_tasks_generic().
- Enable duplicate-callback testing for the "tasks" and
  "tasks-tracing" torture types.
- Add a KASAN aux-stack verification test module with a Kconfig
  choice for each supported flavor.
- Add one rcutorture scenario per flavor for the verification
  test.

Tested on x86_64:

- TASKS01, TASKS02, TASKS03, TRACE01, and TRACE02 completed
  3-minute runs successfully.

- With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and
  rcutorture.object_debug=1, duplicate-callback detection was
  triggered as expected for both torture types.

- TRACE01 was run for 1 minute with
  CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and
  rcutorture.object_debug=1. The test detected both duplicate
  callback heads through the SRCU enqueue path:
[    0.405836] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
[    0.405852] ODEBUG: activate active (active state 1) object: 0000000020df980d object type: rcu_head hint: 0x0
[    0.734724] rcu: __call_srcu(): Duplicate call_srcu() CB 0000000020df980d->rcu_torture_leak_cb+0x0/0x10()
[    0.734780] ODEBUG: activate active (active state 1) object: 000000006634e8c9 object type: rcu_head hint: 0x0
[    0.776688] rcu: __call_srcu(): Duplicate call_srcu() CB 000000006634e8c9->rcu_torture_leak_cb+0x0/0x10()
[    0.779126] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.
[   65.411342] tasks-tracing-torture:--- End of test: SUCCESS: ...

Both duplicate callback heads (the stack-allocated rh2 and
the kmalloc-allocated rhp) were rejected and neither was invoked.

- With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
  object_debug=1, and n_barrier_cbs=4, the TASKS01 barrier
  test completed 630/630 rounds without barrier errors.
  The only debugobjects warnings were the four intentional
  warnings from the duplicate-callback test at startup.

- All five aux-stack scenarios (TASKSKASAN01, TREEKASAN01,
  SRCUKASAN01, TINYKASAN01, and SRCUTINYKASAN01) produced the
  expected KASAN use-after-free reports. Each report's
  "Last potentially related work creation" entry showed the
  expected enqueue helper:

===== TASKSKASAN01 =====
[    1.244567] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
[    1.244707] Last potentially related work creation:
[    1.244716]  aux_test_call_rcu_tasks.constprop.0+0xc/0x20

===== TREEKASAN01 =====
[    0.670399] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
[    0.670561] Last potentially related work creation:
[    0.670571]  aux_test_call_rcu_tree.constprop.0+0xc/0x20

===== SRCUKASAN01 =====
[    0.658679] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0xc0
[    0.658919] Last potentially related work creation:
[    0.658932]  aux_test_call_srcu.constprop.0+0x16/0x30

===== TINYKASAN01 =====
[    0.951503] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
[    0.951641] Last potentially related work creation:
[    0.951650]  aux_test_call_rcu_tiny.constprop.0+0xc/0x20

===== SRCUTINYKASAN01 =====
[    1.009005] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0xc0
[    1.009141] Last potentially related work creation:
[    1.009150]  aux_test_call_srcu.constprop.0+0x16/0x30


These reports are intentional and are counted as runtime
errors by rcutorture.

[1] https://lore.kernel.org/all/20261027070923.3054462-1-kunwu.chan@gmail.com/
[2] https://lore.kernel.org/all/20261104153046.965890-1-joelagnelf@nvidia.com/

Kunwu Chan (5):
  rcu-tasks: Record callback enqueue stack
  rcutorture: Test duplicate call_rcu_tasks() callback enqueue
  rcutorture: Test duplicate call_rcu_tasks_trace() callback enqueue
  rcu: Add KASAN aux-stack verification test
  rcutorture: Add KASAN aux-stack verification scenarios

 kernel/rcu/Kconfig.debug                      |  38 +++++++
 kernel/rcu/Makefile                           |   1 +
 kernel/rcu/rcu_kasan_aux_test.c               | 107 ++++++++++++++++++
 kernel/rcu/rcutorture.c                       |   2 +
 kernel/rcu/tasks.h                            |   4 +
 .../rcutorture/configs/rcu/SRCUKASAN01        |   6 +
 .../rcutorture/configs/rcu/SRCUKASAN01.boot   |   2 +
 .../rcutorture/configs/rcu/SRCUTINYKASAN01    |  12 ++
 .../configs/rcu/SRCUTINYKASAN01.boot          |   2 +
 .../rcutorture/configs/rcu/TASKSKASAN01       |  13 +++
 .../rcutorture/configs/rcu/TASKSKASAN01.boot  |   2 +
 .../rcutorture/configs/rcu/TINYKASAN01        |  12 ++
 .../rcutorture/configs/rcu/TINYKASAN01.boot   |   2 +
 .../rcutorture/configs/rcu/TREEKASAN01        |   6 +
 .../rcutorture/configs/rcu/TREEKASAN01.boot   |   2 +
 15 files changed, 211 insertions(+)
 create mode 100644 kernel/rcu/rcu_kasan_aux_test.c
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01.boot

-- 
2.43.0

