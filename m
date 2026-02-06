Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1E30AACF
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361501; cv=none; b=lCsUHQBa0N6dDTLkiEjs0jJ0AxghJzXQrrvYvDJDQolm/YrRCRYk/mNk3N7nI0kBq2c0w2P8Mxt5quJZ4r2KfjIVdx6vOW9YjBoJxl7HzKpA4msN8WEZvR2tyU2H+i9Yzn3siwbe+RZs2tSd7Z5CNHbQujnkPXxCyhsU+NjSKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361501; c=relaxed/simple;
	bh=DYab+KFb/uzWGFtM+ObAePP6orjpMR6zjSsqn+3bWo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g3eRilmkn5hXm6XkTqsKFeG4acvQrdXFz5nrwKP4TGb1NfjtiHRSU2FTKEaL78T07Dh6lBljedEJIt959cvircHXkzifsIlrN0DbTLxjYPS/avD1FnWZ3tqQQpo6aBRbDE76wWrXss2EJUA8cdF/LD3buVFZFwyZ+uXoTGwqmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYYmc0eN; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYYmc0eN"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4b77adso2105626c88.1
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361501; x=1770966301; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRf3cjvlRbAntghErCuqDOleUjIWBU7CCGgFHUeg8Rg=;
        b=cYYmc0eNu+10CvcUSxaILwdXh1J9mnekmAgY19syyQBSvqBL2bDRRfYGDw1ECsOhT/
         K40jInMeY6t6zNnpTUbouiDNUIZC0sEHFvLPtSnHxI0sN3ZAAEeYfw1irQQvnBIhFX2u
         +H5UFOXP3jbpQa/bty6pP0kKeTsNWcGOSiStxV3QZaOFCahMtTdeE7RIXpUPzHO0H1wl
         TW7t+Gto3mD9tEmLT/c7/pAIrs8KmEuCq4XhZCqrWHrdUVm69mdiVakL9Yz4c/wjvUFM
         9WugNp73MVfTZAR2Aco9Gzmoq4rkGogRhZNwSc1OJU3gPH6s9Dbo1AUERkTirM+wqnqm
         HDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361501; x=1770966301;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRf3cjvlRbAntghErCuqDOleUjIWBU7CCGgFHUeg8Rg=;
        b=pSgQ534DzfBbu7YomR98mka2Z1youiIt6f27CEC00aT9sqUgET413YMJCZi1PxNCXt
         2qJiM8MQrZpcmDbivVBWk7YaAVYaU2dyEBH33uCjlyYM1lVcoVHiD6V3x7wDeKbCYNEf
         BKp8dNdJnMZ1RPB1JPqaqhVQhNWLniMzSnQKq3hinAjpelfdPkzc8Vy33pzA6MSNOPXV
         CW/ZzzJ6Y5Fsy/bk2Xb/OeJJN/v8y00nMUxrEMPfBZDGsK1HNwchGlyEQHPX/Xm4R96m
         3I48eC13/y/KPIcrjB3Odt5oleqGhWyJSHmZyUhaLB4ASMx01Y3r7BMCLf5XgOsEdAEJ
         wFUw==
X-Forwarded-Encrypted: i=1; AJvYcCW/DMQLVBDhnSrj57iUfBzOgproF9dTXewWci3XfwTxI5xaLOgDD3nkufNoVI301LMK+bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymGvowYK5/OgctLlIcDNkLWba3CBmSGon9oH0tdsm2XxLhVLrd
	tPn6F0fDTofbs0mRVEbWGZxhOpEEqwo+1lEPWP8W89wuSbVcY33zOShL
X-Gm-Gg: AZuq6aKhjUj9Kq4shongsQirZGF2uzOh2looWJIQh0vnbFZF8klK+YLikpVjFlIKTl+
	xAtA2lVZNNTOKrZpKu3ujL2liFLGg5MMIy/EIKfm65N6PzfU05Q7/bc2RWMWfLninQ0QzWJpMjM
	t4fJdKtjqFyQXbvnDRIulVOtM74FQAE/6UIRnQMrBhHlCBzs/w+H59zu0nl5CIviiR+CQyoYvSv
	Ry78DRp9XEVipdHFmQ4GdZ/exW0yt1hlwoe8mizFBHSwf0kLq4IBnZmdxZ+vtcJejeo53USMFGd
	Gr2HHZM0drdpvDSf1nPhknOb2xK/owJPjB9vXaPlc1ChbZBtCDpUbw+kEKAAHVb3gyGb0TOH6eJ
	GwIYF9n1ENtJqwm8vXRO1F69JYHevecUpu2hq2yl7grpyB+chQLLpl5c1932hAhOu3xOCnitbfa
	yPpWmRaJaYaQ==
X-Received: by 2002:a05:7022:6b90:b0:11a:126f:ee78 with SMTP id a92af1059eb24-12704010cbemr892190c88.34.1770361500545;
        Thu, 05 Feb 2026 23:05:00 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:04:59 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Subject: [PATCH RFC 00/12] Implementation of Dynamic Housekeeping &
 Enhanced Isolation (DHEI)
Date: Fri, 06 Feb 2026 02:04:21 -0500
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHeShWkC/x3MQQqDMBAF0KvIrBtIo0TottADdCsiafLVgTZKR
 qVFvHuDy7d5OwkSQ+hW7JSwsfAUM66Xgvzo4gDFIZuMNlYbbVUPt6wJKvyi+7DvWKa3n1fpwgh
 WQGVfFqWr6pryMSf0/D3/hp6PO7XH8QdgPdvjdAAAAA==
X-Change-ID: 20260206-feature-dynamic_isolcpus_dhei-ee46b6e3a477
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
 Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 Qiliang Yuan <realwujing@gmail.com>, Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.14.3

The Linux kernel provides mechanisms like 'isolcpus' and 'nohz_full' to
reduce interference for latency-sensitive workloads. However, these are
locked behind the "Reboot Wall" - they can only be configured via boot
parameters and require a system restart to change.

*** THIS IS AN RFC ***
This series is being submitted as an Request For Comments to discuss the
architectural changes required to support dynamic reconfiguration of
housekeeping boundaries. Key points for discussion:
- The use of a blocking notifier chain for cross-subsystem synchronization.
- Compatibility with existing boot-time isolcpus and nohz_full parameters.
- User-space sysfs interface design for granular isolation control.

While cgroup2 (cpuset) provides task-centric resource partitioning (including
unbound kthreads), it lacks the infrastructure to reconfigure core kernel
subsystems or manage per-CPU kernel activities. Specifically, cgroups cannot:
- Managed interrupt (IRQ) migration.
- RCU callback offloading and grace-period kthread placement.
- Per-CPU kernel threads (e.g., watchdog/n) and global subsystem logic (e.g., kcompactd).
- Subsystem-level masks for unbound workqueues.
- Dynamic toggling of full dynticks (NOHZ_FULL) mode.

This patch series introduces Dynamic Housekeeping & Enhanced Isolation
(DHEI). DHEI allows administrators to reconfigure the kernel's
housekeeping boundaries at runtime via a new sysfs interface at
/sys/kernel/housekeeping/.

Core Architecture:
1. Notifier-Driven Synchronization: A new blocking notifier chain
   (HK_UPDATE_MASK) allows isolation.c to signal all participating
   subsystems (IRQ, RCU, Sched, Watchdog, Workqueue, kcompactd, Tick)
   whenever a housekeeping mask is modified.
2. Decoupled Memory Management: Replaced boot-time memory allocators
   with runtime-safe variants, allowing masks to be allocated or resized
   after the system is running.
3. Subsystem Handlers: Each critical subsystem implements a reconfiguration
   handler to migrate pending work, re-affine kthreads, or re-route
   interrupts dynamically.

Key Features:
- Fine-grained control: Separate sysfs nodes for timer, rcu, tick,
  workqueue, kthread, etc.
- Dynamic NOHZ_FULL: Supports enabling/disabling full dynticks mode
  on-the-fly by re-kicking CPUs to evaluate tick dependencies.
- SMT Awareness: An optional 'smt_aware_mode' ensures that all SMT
  siblings of a physical core stay in the same isolation state.
- Safety Guard: Prevents the isolation of all CPUs, ensuring at least
  one online CPU is always available for housekeeping tasks.

This series provides the necessary infrastructure for cloud-native
orchestrators and high-frequency trading platforms to dynamically
re-partition CPU resources without incurring the downtime of a reboot.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
Qiliang Yuan (12):
      sched/isolation: Remove __init restriction from housekeeping cores
      sched/isolation: Introduce reconfiguration notifier chain
      genirq: Implement dynamic migration for Managed IRQs
      rcu: Sync RCU housekeeping mask on notification
      sched/core: Dynamic update housekeeping_cpumask(HK_TYPE_DOMAIN)
      watchdog: Allow runtime toggle of hardlockup detector on CPUs
      workqueue: Dynamic housekeeping mask update support
      kcompactd: Add housekeeping notifier for dynamic mask update
      sched/isolation: Separate housekeeping types and add sysfs interface
      tick/nohz: Implement dynamic nohz_full state update
      sched/isolation: Implement SMT sibling auto-isolation and safety check
      sched/isolation: Bridge isolcpus and support runtime tick offload init

 include/linux/sched/isolation.h |  40 +++++--
 include/linux/tick.h            |   2 +-
 kernel/irq/manage.c             |  52 +++++++++
 kernel/rcu/tree.c               |  43 +++++++
 kernel/sched/core.c             |   5 +-
 kernel/sched/isolation.c        | 252 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h            |   2 +-
 kernel/sched/topology.c         |  26 +++++
 kernel/time/tick-sched.c        |  63 +++++++++-
 kernel/watchdog.c               |  24 ++++
 kernel/workqueue.c              |  39 +++++++
 mm/compaction.c                 |  26 +++++
 12 files changed, 547 insertions(+), 27 deletions(-)
---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20260206-feature-dynamic_isolcpus_dhei-ee46b6e3a477

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>

