Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CE274B4D
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429786; cv=none; b=it6rziN56sP+Xk9iM96PfJ+yKlBNiLd5SiFiXjJVKhCYhRCh+2X/QECGJ6NptWmsThSnnvuHIRJsXSX3r5aE5ztnzhfQtlwqLG3MT7xZSz7wRMgnOZvqY+DkvRwupHQQXI4npVFUX3cm3gGTecPcL7TCQd4qo9OTCU1z2e+hpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429786; c=relaxed/simple;
	bh=K282csnd+i+RohN0lyAyqu5SEswFr+duwOwi1wct9Q8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cYH1ggQ2LGqCzRfi+rYl1qm9aTtakYsOH+Azvg4LmOgvF8zffpLotMpjkwK9yV1kjH2x/hYylu2OU3ECVEnlXWZfixmkoMbhl0kqLqBa9DE7XQK5e/B2Muplir8OqjoMPSTHNF11ErdrRL+opR+qmB8vapwL4CpyD7XbYE4mUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE8q2gL3; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE8q2gL3"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c1092cc08cso2893908eec.1
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429783; x=1775034583; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RyxNuajQ+5BdRvcHNkxzuxTLMc1cMVmB8JwBrt3+9bw=;
        b=mE8q2gL32tI9QBovyp6+1Cn8UzcoPJymz+u27QDAjW/wVIpY6HzZpZMDR1BonNds3d
         3gaDfSF6fo03n7ylcwWC7S5otz1fKi7uiYludV2nEi1K/5Balj6HdpqnqCMamgG58hVG
         l3lf5Pgq68O9gNY91iJ/ai7zRH6kerdVkoGWv4RKaNRqjQy2SZ8pvFXSKWgumsNYxkBD
         3pErSQCl2nywldJb2Qlh0XGQvaLGhNJVmK5e6nrgdlE+xo6nAmASPIGXg2PM2pw/iqaS
         htgcHh3S3Hv3vEdOzYv26yj8WdrEdSax2++xJTQWFJnotjAAbLqVzk8qMZCFeetqaa6r
         rmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429783; x=1775034583;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyxNuajQ+5BdRvcHNkxzuxTLMc1cMVmB8JwBrt3+9bw=;
        b=By3ENK0U/GtRagKpc5L6QVqgZKRNJCP5gzGWiPSFCk6M8PbYQhdAzzqrYOttl65LBX
         LMceR+2gF2orm5dmy9vcIdXm9AUQ+/bFJ8Gx3MDXYUPUzqPIFJKEJBKjvXjSBB9Kh9wx
         pHUP2nNUx5Um3IqCp0omOSaKrS8iAwOHhqDOxRrehxumGEcnjD0sDSGmHqtQRrELoVWK
         4h3UP+KfV2qMRY1kzLPxVGAFmaoonXkN/qwF5xQL+8G8V0Vn5Ure8tDna90GS/aP2l2S
         9+0wbPNs7FBr/bk6Ow3wxyAy3kZlB+DEj/oN07M6Kl9AxTvTd5aJsXJXqWf6w5klA75Q
         RiOw==
X-Forwarded-Encrypted: i=1; AJvYcCWkKOCxD1Oe+masR6WIexjw0EmQZYqPLUtUPYZn/sakU4+fNQqZDx5nNfnWyHChPF5lvZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrF9W0G8xjzv9YGnTxE/ltyztkY3z7NOKMBmlrYlLupDB6XyCy
	4ZTZwBfW1KZpoDUT60JwiuUoK6hXDh3oOkkpH4BUliiXjKz42ymn3mz1
X-Gm-Gg: ATEYQzwDm6ZAdUOz5rXdL23VqEFhO7BgqR2V4dEV15btLUEN0YbJqZLTd+ub8GIbYv6
	FOjAPImp34rvht620x3+ZH9qWNV3PyMeGH3uDpNYx8UikWDDHyVGitaiIN5ACFklENGYBB/ND6U
	sQT+YB183jc+eoVPWlPLkWlxJov3ZyuCkhM+jsA5bpAEF2/KbHgYGvq2TBRPSu+LM5BejLfM5Wp
	wTx804xVG5iutiG5ksuNNKdUXugoyZT5Ob3nWMoa5vprCFZiysKfI0CtvCnBDL1rQNLIpgHjmbs
	xpEQ7LXmrrMJ/UhLsxi6oHTHaNRXP0OJzfxHJHt6KqQPGVdMlIxPg1e33uRUiXlXu8WA94cQZYe
	TAshC6nCndhuZYsYL5Zl8iDq89c26w4ea3vY8jTNh1R1hY4Ph9owf3HMJHOvqJQGiN8nt4ktM2i
	rGm0aNCIQolVPfWK6C
X-Received: by 2002:a05:7300:a892:b0:2bd:c285:2f3 with SMTP id 5a478bee46e88-2c15d31d7c4mr1292467eec.6.1774429782498;
        Wed, 25 Mar 2026 02:09:42 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:09:42 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Subject: [PATCH 00/15] Implementation of Dynamic Housekeeping & Enhanced
 Isolation (DHEI)
Date: Wed, 25 Mar 2026 17:09:31 +0800
Message-Id: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEumw2kC/x3MQQqAIBBA0avIrBvIMaK6SrSwHGsgLBQkkO6et
 HyL/wskjsIJJlUgcpYkV6jQjYLtsGFnFFcN1FLfGurQHSyYNaGXYE8cRu30antanYEa3ZG9PP9
 wXt73A7C9sPRgAAAA
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

The Linux kernel provides mechanisms like 'isolcpus' and 'nohz_full' to
reduce interference for latency-sensitive workloads. However, these are
locked behind the "Reboot Wall" - they can only be configured via boot
parameters and require a system restart for changes to take effect.

In modern cloud-native environments, CPU resources often need to be
dynamically re-partitioned to accommodate container scaling without
the performance penalty and downtime of a full system reboot. Similarly,
high-frequency trading (HFT) platforms require the ability to fine-tune
CPU isolation at runtime to minimize jitter for critical execution threads
based on shifting market demands.

This patch series introduces Dynamic Housekeeping & Enhanced Isolation
(DHEI). DHEI allows administrators to reconfigure the kernel's
housekeeping boundaries at runtime via a new sysfs interface at
/sys/kernel/housekeeping/.

Key Features:
- Fine-grained control: Separate sysfs nodes for timer, rcu, tick,
  workqueue, kthread, managed_irq, domain, and misc.
- Dynamic NOHZ_FULL: Supports enabling/disabling full dynticks mode
  on-the-fly.
- SMT Awareness: Optional 'smt_aware_mode' for core-granular isolation.
- Safety Guards: Prevents isolating all CPUs, requires at least one
  online housekeeping CPU, and enforces CAP_SYS_ADMIN capability.

Core Architecture:
1. Notifier-Driven Synchronization: HK_UPDATE_MASK blocking notifier chain.
2. Decoupled Memory Management: Runtime-safe cpumask allocation.
3. Subsystem Handlers: Dynamic migration for IRQ, RCU, Sched, etc.

The series is organized as follows:
- Patches 01-03: Core infrastructure (dynamic allocation, notifier,
  enum separation)
- Patches 04-09: Subsystem notifier handlers (genirq, RCU, scheduler,
  watchdog, workqueue, mm/compaction)
- Patch 10: tick/nohz dynamic full dynticks
- Patches 11-13: SMT-aware isolation, boot-time bridging, sysfs interface
- Patch 14: ABI documentation
- Patch 15: kselftest suite

Tested on x86_64 (8 vCPUs, SMT enabled) with all selftests passing.

As suggested by Joel Fernandes and Thomas Gleixner, this V1 version
provides a stronger rationale for dynamic isolation and addresses
all RFC feedback regarding naming and notifier robustness.

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Ben Segall <bsegall@google.com>
To: Mel Gorman <mgorman@suse.de>
To: Valentin Schneider <vschneid@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
To: Paul E. McKenney <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
To: Josh Triplett <josh@joshtriplett.org>
To: Boqun Feng <boqun.feng@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
To: Zqiang <qiang.zhang@linux.dev>
To: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>

Changes since RFC:
- Dynamic RCU NOCB rewrite: Perform full runtime offload/deoffload via remove_cpu()/add_cpu() for online CPUs, with lazy initialization.
- Robust Timer Migration: Added logic to dynamically migrate tick_do_timer_cpu when a housekeeper is isolated.
- Enhanced Isolation Safety: Hardened sysfs interface with CAP_SYS_ADMIN checks, 0600 permissions, and strict cpumask validations including SMT subset checks.
- Lifecycle Cleanups: Replaced system_state boot checks with slab_is_available() and added hotplug shutdown guards for clean power-off.
- Testing & Docs: Added comprehensive kselftest suite for isolation scenarios and detailed ABI documentation.
- Link to RFC: https://lore.kernel.org/all/20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com/

---
Qiliang Yuan (15):
      sched/isolation: Support dynamic allocation for housekeeping masks
      sched/isolation: Introduce housekeeping notifier infrastructure
      sched/isolation: Separate housekeeping types in enum hk_type
      genirq: Support dynamic migration for managed interrupts
      rcu: Support runtime NOCB initialization and dynamic offloading
      sched/core: Dynamically update scheduler domain housekeeping mask
      watchdog: Allow runtime toggle of lockup detector affinity
      workqueue: Support dynamic housekeeping mask updates
      mm/compaction: Support dynamic housekeeping mask updates for kcompactd
      tick/nohz: Transition to dynamic full dynticks state management
      sched/isolation: Implement SMT-aware isolation and safety guards
      sched/isolation: Bridge boot-time parameters with dynamic isolation
      sched/isolation: Implement sysfs interface for dynamic housekeeping
      Documentation: isolation: Document DHEI sysfs interfaces
      selftests: dhei: Add functional tests for dynamic housekeeping

 .../ABI/testing/sysfs-kernel-housekeeping          |  22 ++
 include/linux/sched/isolation.h                    |  40 +++-
 kernel/irq/manage.c                                |  49 +++++
 kernel/rcu/rcu.h                                   |   4 +
 kernel/rcu/tree.c                                  |  76 +++++++
 kernel/rcu/tree.h                                  |   2 +-
 kernel/rcu/tree_nocb.h                             |  27 ++-
 kernel/sched/core.c                                |  28 +++
 kernel/sched/isolation.c                           | 236 ++++++++++++++++++++-
 kernel/time/tick-sched.c                           | 130 +++++++++---
 kernel/watchdog.c                                  |  25 +++
 kernel/workqueue.c                                 |  42 ++++
 mm/compaction.c                                    |  27 +++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dhei/Makefile              |   4 +
 tools/testing/selftests/dhei/dhei_test.sh          | 160 ++++++++++++++
 16 files changed, 818 insertions(+), 55 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260324-dhei-v12-final-891d1ba62bd3

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>

