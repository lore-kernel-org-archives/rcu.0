Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAE14E2CF;
	Tue,  7 May 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074537; cv=none; b=ULxQtK3w7te4bYovzE8oqw8CSEZaSd38HS8CjpO6hS0537y78qSKCG5hWqkF2E1yCg8JPuad8MKYqZrPN7UpqnrLP3mM9LnZZFCNaXaX5mCAfcSePv2/VCMNL7Jb6dDPwuOCrJcYuiJQlWF4FKfifc7aW99HpaCsoJxxaKhOKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074537; c=relaxed/simple;
	bh=ZjgneQmG6RZ/+v/Fm1HO5eBNI8xfD2wpgYqZqDZN69k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWEaLTZxNIM5l/KPLww3WgDdVQZs3Tjb+qM1Qa4s7wtQl4iCBwrBf3NgEq4ajhO6P7J6rfkeZ8Hu6MMx5xd1ApsjvdGk9t9bm+s16JG8VbgInrsmi7xfkKypB7z7M4JEECMWdi+CYif53eekUhF5PE3poo5SKhEx1ETaeDW+548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcE7poQi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcE7poQi"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so36444291fa.0;
        Tue, 07 May 2024 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074534; x=1715679334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJMH87hi18YxOnKpA39ix1VWQw+7nmb6iEumWZVhVHM=;
        b=CcE7poQiIgbMRJzMWr+bXV2V8Gtzn0YYAY9o+ObRtpqaJ+fL0yyjlJt1CDPfchM75C
         JmWOHYXlZfLilvswHPzlXsvfRrWfE9ULVw/B6ZMzC8eVl542Mbw3SEFOC4TauvyCm+NB
         KBwSsqogJyCHHCnB3hYn/FHlv3fDxX4CnyM5HcXpSzprfy1K7zeYD4ukW4+4TxAy1/sd
         zVNX31NVeOP99ZR65XOohpVXTP9McUvmitdCEcVSNB91FObxQkNGLdzJluwP10hFHDxf
         28aH41Ee1J/m17CfUQTiHQKVIfq6CtwvTyWHEeI5Ruk1TdEOkp1GK0g/IVmfq9aTq/t8
         +kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074534; x=1715679334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJMH87hi18YxOnKpA39ix1VWQw+7nmb6iEumWZVhVHM=;
        b=T8JDaNHYTDXCIx8lytscRIE14OTCfgncY8NSDdR/Ic2o9VMCK3A/CgPc26N9wfDVCV
         glxgFBevb0l7X16Au+Ie3UJrtud6R443Hdf7j0RSc8kzjoHiVP34c8NnCr827cXQHft4
         ekdoh6jmB8nUMJfrUNX65cf6kQloT8UJ0eFmnjUckIjVgDVX2c3jfh6ex3ZswHGo00ty
         nP2wW/oD+cX4h/fiYVJvfokCRFia097LPZ/+zQM9O9eV0exs28VdMXXJLEjfuVKFXs0H
         JokGAvoP6rcFpHRV0uhzMGGLUTBItjbjFmk3VrthR0R/ipBZ47e27hyi9s2JaRy+mFzB
         iWew==
X-Forwarded-Encrypted: i=1; AJvYcCUg0cJ5+yoqOAb6YeZxFPeOlfhQm4Z21pg7eyIco7O8p2691ossWiJ0tBcajrkLAbGqF6Zi3Vvp2Coj/s5KekIy7mJagsosxep//FWa
X-Gm-Message-State: AOJu0YxfM8GyMY35NJbGvpVJUqx5+mV7mQs0FX/c6qjzgQnM0h3TpktY
	VR8mThougorpF4dg2Nnz7/66j/uzuS9rckQBT7i6BX/clPBvP0+a
X-Google-Smtp-Source: AGHT+IFG5/103/vdpVk3U53dphlffMl8nvbsVYnVfX178IeE/38l2crOJmcQIt7WJLDKPCEPjIGu2A==
X-Received: by 2002:a05:651c:10a2:b0:2e0:eb96:7b53 with SMTP id k2-20020a05651c10a200b002e0eb967b53mr7731882ljn.44.1715074533549;
        Tue, 07 May 2024 02:35:33 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:33 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 00/48] RCU changes for v6.10
Date: Tue,  7 May 2024 11:34:42 +0200
Message-Id: <20240507093530.3043-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is for 6.10 kernel:

fixes: Fix a lockdep complain for lazy-preemptible kernel,
remove redundant BH disable for TINY_RCU, remove redundant READ_ONCE()
in tree.c, fix false positives KCSAN splat and fix buffer overflow in
the print_cpu_stall_info().

misc: Misc updates related to bpf, tracing and update the
MAINTAINERS file.

rcu-sync-normal-improve: An improvement of a normal
synchronize_rcu() call in terms of latency. It maintains a separate
track for sync. users only. This approach bypasses per-cpu nocb-lists
thus sync-users do not depend on nocb-list length and how fast regular
callbacks are processed.

rcu-tasks: RCU tasks, switch tasks RCU grace periods to
sleep at TASK_IDLE priority, fix some comments, add some diagnostic
warning to the exit_tasks_rcu_start() and fix a buffer overflow in
the show_rcu_tasks_trace_gp_kthread().

rcutorture: Increase memory to guest OS, fix a Tasks
Rude RCU testing, some updates for TREE09, dump mode information
to debug GP kthread state, remove redundant READ_ONCE(), fix some
comments about RCU_TORTURE_PIPE_LEN and pipe_count, remove some
redundant pointer initialization, fix a hung splat task by when
the rcutorture tests start to exit, fix invalid context warning,
add '--do-kvfree' parameter to torture test and use slow register
unregister callbacks only for rcutype test.

Johannes Berg (1):
  rcu: Mollify sparse with RCU guard

Neeraj Upadhyay (1):
  MAINTAINERS: Update Neeraj's email address

Nikita Kiryushin (2):
  rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
  rcu: Fix buffer overflow in print_cpu_stall_info()

Paul E. McKenney (29):
  scftorture: Increase memory provided to guest OS
  rcutorture: Disable tracing to permit Tasks Rude RCU testing
  rcu: Add lockdep checks and kernel-doc header to rcu_softirq_qs()
  rcutorture: Enable RCU priority boosting for TREE09
  rcutorture: Dump # online CPUs on insufficient cb-flood laundering
  rcutorture: Dump GP kthread state on insufficient cb-flood laundering
  rcutorture: ASSERT_EXCLUSIVE_WRITER() for ->rtort_pipe_count updates
  rcu-tasks: Make Tasks RCU wait idly for grace-period delays
  bpf: Select new NEED_TASKS_RCU Kconfig option
  arch: Select new NEED_TASKS_RCU Kconfig option
  tracing: Select new NEED_TASKS_RCU Kconfig option
  bpf: Choose RCU Tasks based on TASKS_RCU rather than PREEMPTION
  ftrace: Choose RCU Tasks based on TASKS_RCU rather than PREEMPTION
  rcu: Make TINY_RCU depend on !PREEMPT_RCU rather than !PREEMPTION
  srcu: Make Tiny SRCU explicitly disable preemption
  rcu: Create NEED_TASKS_RCU to factor out enablement logic
  rcu: Remove redundant BH disabling in TINY_RCU
  rcu: Make Tiny RCU explicitly disable preemption
  rcu: Remove redundant READ_ONCE() of rcu_state.gp_flags in tree.c
  rcu: Bring diagnostic read of rcu_state.gp_flags into alignment
  rcu: Mark writes to rcu_sync ->gp_count field
  rcu: Mark loads from rcu_state.n_online_cpus
  rcu: Make hotplug operations track GP state, not flags
  rcu: Inform KCSAN of one-byte cmpxchg() in rcu_trc_cmpxchg_need_qs()
  rcu: Remove redundant CONFIG_PROVE_RCU #if condition
  rcu-tasks: Replace exit_tasks_rcu_start() initialization with
    WARN_ON_ONCE()
  rcutorture: Remove extraneous rcu_torture_pipe_update_one()
    READ_ONCE()
  rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
  torture: Scale --do-kvfree test time

Uladzislau Rezki (Sony) (6):
  rcu: Add data structures for synchronize_rcu()
  rcu: Update lockdep while in RCU read-side critical section
  rcu: Reduce synchronize_rcu() latency
  rcu: Add a trace event for synchronize_rcu_normal()
  rcu: Support direct wake-up of synchronize_rcu() users
  rcu: Allocate WQ with WQ_MEM_RECLAIM bit set

Zenghui Yu (1):
  doc: Remove references to arrayRCU.rst

Zqiang (7):
  rcu-tasks: Fix the comments for tasks_rcu_exit_srcu_stall_timer
  rcutorture: Use the gp_kthread_dbg operation specified by cur_ops
  rcutorture: Make rcutorture support print rcu-tasks gp state
  rcutorture: Removing redundant function pointer initialization
  rcutorture: Make stall-tasks directly exit when rcutorture tests end
  rcutorture: Fix invalid context warning when enable srcu barrier
    testing
  rcutorture: Use rcu_gp_slow_register/unregister() only for rcutype
    test

linke li (1):
  rcutorture: Re-use value stored to ->rtort_pipe_count instead of
    re-reading

 .mailmap                                              |    3 -
 Documentation/RCU/whatisRCU.rst                       |    6 +-
 Documentation/admin-guide/kernel-parameters.txt       |   14 ++++
 MAINTAINERS                                           |    2
 arch/Kconfig                                          |    4 -
 include/linux/rcupdate.h                              |    2
 include/linux/rcupdate_wait.h                         |   18 +++---
 include/linux/srcutiny.h                              |    2
 include/trace/events/rcu.h                            |   27 +++++++++
 kernel/bpf/Kconfig                                    |    2
 kernel/bpf/trampoline.c                               |    2
 kernel/rcu/Kconfig                                    |    2
 kernel/rcu/rcu.h                                      |   20 +++---
 kernel/rcu/rcutorture.c                               |    4 -
 kernel/rcu/srcutiny.c                                 |   31 ++++++++--
 kernel/rcu/srcutree.c                                 |    5 -
 kernel/rcu/sync.c                                     |    8 ++
 kernel/rcu/tasks.h                                    |    6 +-
 kernel/rcu/tiny.c                                     |    2
 kernel/rcu/tree.c                                     |   28 +++++++++
 kernel/rcu/tree.h                                     |   14 ++++
 kernel/rcu/tree_exp.h                                 |    2
 kernel/rcu/tree_plugin.h                              |    4 -
 kernel/rcu/tree_stall.h                               |    2
 kernel/rcu/update.c                                   |    4 -
 kernel/trace/Kconfig                                  |    4 -
 kernel/trace/ftrace.c                                 |    3 -
 tools/testing/selftests/rcutorture/bin/torture.sh     |    2
 tools/testing/selftests/rcutorture/configs/rcu/TREE09 |    5 +
 include/linux/rcupdate.h                                |   20 +++++-
 kernel/rcu/Kconfig                                      |    6 +-
 kernel/rcu/rcutorture.c                                 |   81 +++++++++++++++------------
 kernel/rcu/tasks.h                                      |   38 +++++++++++-
 kernel/rcu/tiny.c                                       |    2
 kernel/rcu/tree.c                                       |  408 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 kernel/rcu/tree.h                                       |   10 ++-
 kernel/rcu/tree_stall.h                                 |    9 ++-
 tools/testing/selftests/rcutorture/bin/torture.sh       |    4 -
 38 files changed, 666 insertions(+), 140 deletions(-)

-- 
2.39.2

