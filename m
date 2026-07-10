Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410C367293
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654106; cv=none; b=VaIXbhgTHYBVxuUHO6B5bBrH462ZqUpJYgF2xvKfclOAKTFeBMfZKHXIqeBfvUKp7Wx5cavttjmhocvhqcMeclqjQ463Wj4fPwyRcK6I8rYqrYmg2UP9V4X3k3zaomoBScXOWyc+dVcorL2vGYZ69Uld1mvvKj8JlD+A5nh45kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654106; c=relaxed/simple;
	bh=mig4XcqfSs9jGe1JwCW+tEhYbOeUSyy7jkGAdEvFKT4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m669ZFd1Xj3v6dbd3v1Fb9KYc612b3cFMMw449aDMTjR21+yrjWgkT+1XWOG8qOLcOjb2DQdGYPlAaZaK9ADffUkb+NCOQsZjfu8sF/nUpEjNnze5IsgAp++kCbHeDv/4Il4JlO/w7FYjY2J9Mdg1RcUKqSDA55KPMJiyyeWIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hceESrwl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hceESrwl"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381891a9525so638637a91.3
        for <rcu@vger.kernel.org>; Thu, 09 Jul 2026 20:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654104; x=1784258904; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ArKjKlGhzUaijvYetaer+EHSm9Nlpk5QM4HhQLD/GMg=;
        b=hceESrwlXY73i9GzfFWQwZlf3OdBQAukch0A3Qr2RqGH1g2dthWDQAxBiujSzx5faN
         ugXNgz7TVbQbI/Zlku3mvaQG9dtehnB9w3oZ8+1XZKN9lccFP/I1e5ghpqk8Il2Eb9T+
         8OG6rSqAsRWY+iiApIQOu09GKWP7VHxdUucEMUc6DVGGKyqYu5XQe3RKnMAoAA3T3vGi
         7B45b2GH6oIBERUB3lFk/26nccwKE3ZG3dIDNq84UG2egXsBCPaZclfOhjUe+rEH277F
         zFKgijZVTIHDIbRfJDjOrnngD4mtshX+XTzz4snrWIElAMU2IhkuzGyxgJmFqeiHjGmF
         q5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654104; x=1784258904;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ArKjKlGhzUaijvYetaer+EHSm9Nlpk5QM4HhQLD/GMg=;
        b=WI5Hnk3jRhsm63rr+za3MCy0Q+SoQCtAoximDtuZHysmTCB1E4dhHq6pvMZU68C7Xa
         ZBZ5LHSY2aeE2ecyYeJd94QOoTOesuhcAIqqBOBRwhwCkCIBpXIlZWFa+tbtTzq8mRTt
         EIydm95ymIYV/RL/epiuYRuBYuk0UyAMDSbEHoScxU9dckU+6lxdpz6rTxFgJ8FLHwFH
         2kn9Dj2ASM1rvt7h+n91p9cLaPOwNXQWyNeiS6RYwC80wGlgBOYnfc9WbNkN+7l0Kqoh
         yauhGsKuIpQqqMILQZPLFdkjwOCStzFM0ORTQNOBXvwx5FJpkND6i7tJgcemG2yctN7Z
         ENWg==
X-Forwarded-Encrypted: i=1; AHgh+RpKvT1KQV78cdUlDHGth6dAwwV6UnUSX+M8WyYV9T9PkMBKiekp2ceWvcDXlkEGCogtXTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqBan+0aazyOWtfTd+acvYXhRWclNKQgE6raJ/8n9IXX764PV
	czDCtNbKSKKrWtJrGTJ8ANYAJkg1Fg142oMy38Q9SVxKpn+eha+ZcKbX
X-Gm-Gg: AfdE7ckFRGfoYMHWhMuZrTSnGZhBHP/VZhlttdrWYHfePp0BOzmAU2RSJ7ITXCa/toT
	+yNbm2GNGGmApMQheYfG9s6tBnDSmrF+nc4MSTBkaTNiFXbbzCTFIyJekKJnp9LIqF8BctCfLiR
	v6aOXogCL6fXVOl5VCHIR52VOQQWYIlvlymq2f/oSkE3pzh4dy+e/HYRAssYLlmD91ARiuc0gFT
	qFO/EuICXRZI6VnR6otaEaNLED1GlriAhUYhYU21ze/Pku9pXRnRqbnXAWcXuwQSiRqkG0jqYOg
	yT5S8PsMDMxR7IvJQ6N/GmkV50B1rh2nvYvXdPyh1eqfLx8vb8q0jUlms3nI0wK7Wr3raPHrQOI
	K3KachehRqxRgRBFHT+p7dvWQ2zXQ8zqXP2PjRx0JBdWcAoRhYRWqnE0xjbkwL8Dgr0urOhehuh
	FXJWJqY//LV4ZikAz/VuvIDQ==
X-Received: by 2002:a17:90b:57cd:b0:37f:9ce1:7369 with SMTP id 98e67ed59e1d1-389416ec46emr8567000a91.31.1783654104099;
        Thu, 09 Jul 2026 20:28:24 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:28:23 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Subject: [PATCH v4 00/11] Dynamic Housekeeping Management (DHM) via CPUSets
Date: Fri, 10 Jul 2026 11:28:11 +0800
Message-Id: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMxmUGoC/12Qy2rDMBBFfyVoXRVppDhyVv2PUsJYD3uKH0GK1
 Ybgf68cAk6zm3vhHC5zY8lH8okddzcWfaZE01iCftsx2+HYek6uZAYCKqGF4T/zN40td93ATdD
 Kg9O1dYYV4Bx9oN+77POr5I7SZYrXuzvD2j40Uj1rMnDBReUCSIsN7t1HOyD173Ya2KrJckMV7
 AvjiWcJPNCIfbkKXsvaWgRl0YUXPAa78SAqHjxe5ui5u444kD1Rmnp7ntPpIV7XCDxI6RthD/p
 1jdpslfz3j6wKCiZI1M6opjLP6LIsf0y1iCdtAQAA
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

This series introduces Dynamic Housekeeping Management (DHM) to the Linux
kernel, enabling runtime reconfiguration of kernel-noise housekeeping
(nohz_full tick suppression, RCU NOCB offloading, and managed IRQ
migration) through the existing cgroup v2 cpuset isolated partition
mechanism — no new kernel ABI required.

When a cpuset partition is set to isolated mode, DHM cycles each CPU in
that partition offline, reconfigures the housekeeping masks (removing the
CPU from HK_TYPE_KERNEL_NOISE and related types), and brings it back
online.  The subsystems (tick/nohz, RCU NOCB, genirq) pick up the new
masks through their existing CPU hotplug callbacks.  Destroying the
partition reverses the cycle: each CPU is taken offline, restored to all
housekeeping masks, and brought back online.

Housekeeping cpumask pointers are RCU-protected to allow lock-free readers
during updates.  A global dhm_cycling_cpus mask suppresses transient
cpuset partition invalidation while CPUs are being cycled.

This work is related to Waiman Long's [PATCH-next 00/23] series
(20260421030351.281436-1-longman@redhat.com), which also targets runtime
cpuset housekeeping control.  DHM's distinguishing feature is zero-boot-
parameter activation: nohz_full+nocb isolation can be achieved at runtime
without any boot-time nohz_full= or rcu_nocbs= parameters.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
V3 -> V4:
- Drop apply() callback architecture entirely (struct housekeeping_cbs,
  pre_validate/apply hooks, housekeeping_update_types() notification).
  Thomas Gleixner identified concurrent in-kernel mask apply as
  fundamentally unsafe ("broken beyond repair") and endorsed CPU-by-CPU
  hotplug cycling as the correct approach.
- Track A prerequisites (housekeeping boot type isolation, RCU reader
  protection, cpuset trigger) submitted upstream separately; v4 builds
  on top of those three committed patches.
- Fix rcu/nocb lazy_init: remove __init from rcu_organize_nocb_kthreads()
  forward declaration (tree.h) to prevent GCC from placing the function in
  .init.text, which caused an NX-protected page fault when
  rcu_nocb_cpu_isolate() was called at runtime.  Add noinline to
  rcu_nocb_lazy_init() to preserve the GCC IPA call chain.
- Fix cpuset remote partition cycling suppression: extend dhm_cycling_cpus
  guard to the remote-partition disable path in cpuset_hotplug_update_tasks(),
  preventing false partition invalidation during hotplug cycling steps.
  Fixes selftest TEST_MATRIX[69] (A2: expected 1-2, got 1-3).

V2 -> V3:
- Replace notifier chain with explicit per-type callback interface
  (struct housekeeping_cbs with .name, .pre_validate, .apply fields).
- RCU-protect all housekeeping cpumask pointers; callers must hold
  rcu_read_lock() or use housekeeping_cpumask_rcu() in apply() callbacks.
- Drop 5 patches from v2: HK_TYPE enum separation (upstream aliases are
  already correct), no-op timer/hrtimer patches, kthread dead code, and
  workqueue double-update.
- Fix deadlock in rcu_hk_workfn(): remove cpus_read_lock() wrapper around
  remove_cpu()/add_cpu() which take cpu_hotplug_lock write side.
- Fix UAF in rcu_hk_apply(): snapshot the housekeeping cpumask inside the
  work function under rcu_read_lock(), not at apply() time where the old
  pointer may be freed by synchronize_rcu() before the work runs.
- Fix tick apply(): snapshot housekeeping_cpumask_rcu() under
  rcu_read_lock() as required by lockdep for runtime-mutable types.
- Activate context_tracking dynamically via ct_cpu_track_user() /
  ct_cpu_untrack_user() in tick apply(), eliminating the dependency on
  CONFIG_CONTEXT_TRACKING_USER_FORCE flagged by tglx.
- Fix genirq apply(): snapshot HK_TYPE_MANAGED_IRQ mask under
  rcu_read_lock() before the IRQ iteration loop.
- Simplify cpuset noise_types to BIT(HK_TYPE_KERNEL_NOISE) |
  BIT(HK_TYPE_MANAGED_IRQ), replacing the redundant per-alias bitmask.
- housekeeping_update_types(): always use cpu_possible_mask as base
  for HK_TYPE_KERNEL_NOISE, so de-isolation restores the mask to all
  possible CPUs rather than leaving it at its last non-trivial value.
- Initialize watchdog_cpumask from HK_TYPE_KERNEL_NOISE (not
  HK_TYPE_TIMER) at boot; keep it in sync at runtime via a new
  housekeeping_cbs callback.
- Add kernel-noise selftest to test_cpuset_prs.sh, including
  cpu_in_cpulist() for correct cpulist range membership detection and
  nohz_full sysfs verification when CONFIG_NO_HZ_FULL is active.
- Add RCU caller fixes: sched/core (HK_TYPE_KERNEL_NOISE) and
  drivers/hv (HK_TYPE_MANAGED_IRQ) are required because those types
  are updated at runtime; hrtimer (HK_TYPE_TIMER) and arm64/topology
  (HK_TYPE_TICK) are defensive fixes.
- Reorder patches so all subsystem callbacks are registered before the
  cpuset patch that triggers housekeeping_update_types().

V1 -> V2:
- Rebrand series from DHEI to DHM (Dynamic Housekeeping Management).
- Drop custom sysfs interface entirely.
- Integrate housekeeping control into cgroup v2 cpuset isolated partition
  mechanism.
- Add SMT-aware isolation constraints to prevent splitting SMT siblings.
- Add comprehensive documentation and cgroup functional selftests.
- Refactor mask transition logic to use RCU-safe handover.

v3: https://lore.kernel.org/r/20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com
v2: https://lore.kernel.org/r/20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com
v1: https://lore.kernel.org/all/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com

---
Jing Wu (11):
      sched/isolation: Add runtime housekeeping mask updates with boot snapshots
      sched/isolation: RCU-protect runtime-mutable housekeeping cpumask readers
      cgroup/cpuset: Drive kernel-noise housekeeping updates from isolated partitions
      context_tracking: allow runtime per-CPU user tracking enable/disable
      rcu/nocb: support lazy init for runtime CPU isolation
      watchdog: sync watchdog_cpumask with HK_TYPE_KERNEL_NOISE on isolation
      tick/nohz: add runtime tick_nohz_full_mask update for CPU isolation
      cpuset: add dhm_cycling_cpus mask to suppress transient invalidation
      cpuset: drive kernel-noise isolation via per-CPU hotplug cycling
      docs: cgroup-v2: document kernel-noise isolation via isolated partitions
      selftests/cgroup: add kernel-noise isolation test to cpuset selftest

 Documentation/admin-guide/cgroup-v2.rst           |  17 +
 arch/arm64/kernel/topology.c                      |   9 +-
 drivers/base/cpu.c                                |  20 +-
 drivers/hv/channel_mgmt.c                         |  50 +-
 include/linux/context_tracking.h                  |   2 +
 include/linux/nmi.h                               |   2 +
 include/linux/rcupdate.h                          |   2 +
 include/linux/sched/isolation.h                   |  32 +-
 include/linux/tick.h                              |   4 +
 kernel/cgroup/cpuset.c                            | 161 +++++-
 kernel/context_tracking.c                         |  38 +-
 kernel/rcu/tree.h                                 |   2 +-
 kernel/rcu/tree_nocb.h                            |  43 +-
 kernel/sched/core.c                               |   7 +-
 kernel/sched/isolation.c                          | 197 +++++++-
 kernel/sched/sched.h                              |   2 +-
 kernel/time/hrtimer.c                             |   5 +-
 kernel/time/tick-sched.c                          |  47 +-
 kernel/watchdog.c                                 |  26 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 580 +++++++++++++++++++++-
 20 files changed, 1181 insertions(+), 65 deletions(-)
---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260408-wujing-dhm-8f43e2d49cd8

Best regards,
-- 
Jing Wu <realwujing@gmail.com>

