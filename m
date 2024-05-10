Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF1173;
	Fri, 10 May 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365858; cv=none; b=l9dNDvxGSj1xs17HwBPKDEFhvuTDP4XUj9pG1jlx42+aS0ZC7qTmLC0fJDHRTpiGkTwgOxTNJprZNgZcRn5LAqVUYOFvIq3BEbD5JFdXu+4NKVbVJoBPNJSkaCc0HRe0/BSneNuM716s9TqgnW1sG3KCxySrKPisp3xxldYpgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365858; c=relaxed/simple;
	bh=OssFYeY19duAuzmRM7/hkRjARkNJ6KRGC529+UldMfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rs+AxMgcp7M2WkerasK30Ndyp2CAo86B5wKcrB+osH3o/n9SduU9ppLawz+ZQjMZVyV/eqdtaUjLQ6rbYhSklOBvDimByZeHpopX2CoQ1YLkHKwWG5CYdHtj7M1T/Q5r0phywuXJDuBgGaKxzphrALCKLXZrnt3BB8CapVUytJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isBVwkKa; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isBVwkKa"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f1e8eaee5so3132125e87.1;
        Fri, 10 May 2024 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715365854; x=1715970654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Or2cO1AFvNBZUQMsCspyrUBDKduERhim98CgiK0M+DM=;
        b=isBVwkKaOY4HAEFhpsV9ItpLC9Ixv/Q9PpTKkMXNnbdHlVdIFbHXkhlRChJj5bi2Rd
         UEpzu3eGuiWHz0hFQYrox/ido/ZIGH7rzrNoOuJHZWdbWzRVX/VrGmzcPEjOVc8antLU
         l0qJXkvjFOT1cIR/YLBV035F/TYavwFD0DOAg3jUVTRzIaHfPIahxZWR2ntWV8Z0wnSE
         EgnFlppHLCbPfiSu1KOg072sPAE7eNrBhWOIQShvzE4midp1zp6t33JhG10vakW+uri8
         /Wz4t6MH8d17ViWHyMyxmH3YJH9KFbNvZSjXFUwTUwYBRMeZxsZgkGTybtEZPDuAnWWL
         WOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365854; x=1715970654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Or2cO1AFvNBZUQMsCspyrUBDKduERhim98CgiK0M+DM=;
        b=P+gALhGRxGkXnrq50LDgwrC1rdU+nP/nGZycFFmJE828oWCJv7jNBSDeWXjhPJtCxR
         RfeTfVgecI7A+9QdRboqxmxG7l0sSms7FomoNsEPJz2oXrxYT2Bcoe+YKjw8XqczISb4
         Binb/+lIjaDOZ6vEX9wWyNUcZnSqs3PBaADCULbf6ePfjH9ElYzdlu1ybZtUOE38qTv0
         CKMZb6vzLjaHodEdTNpOM2gDJouIcXcqhlEiKQFqdPHm6FnYHWlDqfgmQm9/V9dQ4iAa
         AqRokdV9G1H+nbiasMOOTiytGphl1jeCsyCE/sko4Az7DCi0gaF+9gh9WB8Ct1Jt7649
         bjzw==
X-Forwarded-Encrypted: i=1; AJvYcCUWVFg2uXJdZbhcV+T0PIRRqCly+m3N6sX2mrEj4HInPkUs5v8kesVDeGRebbhNC26bZViqx+RltUYNrlMmQcsFLA9ZkdftVt4MFpgv
X-Gm-Message-State: AOJu0YyX8Bt7m7iAauznZHOTFfEsCZH3QnqAfBAlDh9dz4+nEEYHKWnJ
	F3jp1gUL0g9gp1TGNz5SiWGBpiaiT5u5OUArCmZ62JJnY60cmBMS
X-Google-Smtp-Source: AGHT+IG3sue+L7v/KftWJNdI/q4CYYYZCPmzwCA10+1282QiT9ypKFc1iAx8T5o4vHwGKobv62l7jg==
X-Received: by 2002:a05:6512:3281:b0:51f:72a2:c7f9 with SMTP id 2adb3069b0e04-521e1555c1amr1964417e87.29.1715365853562;
        Fri, 10 May 2024 11:30:53 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce3113sm5994081fa.36.2024.05.10.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 11:30:53 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Nikita Kiryushin <kiryushin@ancud.ru>,
	linke li <lilinke99@qq.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [GIT PULL] RCU changes for v6.10
Date: Fri, 10 May 2024 20:30:49 +0200
Message-Id: <20240510183049.312477-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the latest RCU git tree from:

https://github.com/urezki/linux.git tags/rcu.next.v6.10

# HEAD: 64619b283bb35b12a96129e82b40304f7e5551b7:

Merge branches 'fixes.2024.04.15a', 'misc.2024.04.12a', 'rcu-sync-normal-improve.2024.04.15a', 'rcu-tasks.2024.04.15a' and 'rcutorture.2024.04.15a' into rcu-merge.2024.04.15a

fixes.2024.04.15a: RCU fixes
misc.2024.04.12a: Miscellaneous fixes
rcu-sync-normal-improve.2024.04.15a: Improving synchronize_rcu() call
rcu-tasks.2024.04.15a: Tasks RCU updates
rcutorture.2024.04.15a: Torture-test updates

One merge conflicts was detected by linux-next:

* https://lore.kernel.org/linux-kernel/20240424134551.44531979@canb.auug.org.au/

The conflict resolution from linux-next look good to me, plus I make
my own resolutions at branch merge/rcu.2024.04.30a for your reference.

----------------------------------------------------------------

RCU pull request for v6.10

This pull request contains the following branches:

fixes.2024.04.15a: Fix a lockdep complain for lazy-preemptible kernel,
remove redundant BH disable for TINY_RCU, remove redundant READ_ONCE()
in tree.c, fix false positives KCSAN splat and fix buffer overflow in
the print_cpu_stall_info().

misc.2024.04.12a: Misc updates related to bpf, tracing and update the
MAINTAINERS file.

rcu-sync-normal-improve.2024.04.15a: An improvement of a normal
synchronize_rcu() call in terms of latency. It maintains a separate
track for sync. users only. This approach bypasses per-cpu nocb-lists
thus sync-users do not depend on nocb-list length and how fast regular
callbacks are processed. This is controlled by a default-off runtime
option. See /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
parameter.

rcu-tasks.2024.04.15a: RCU tasks, switch tasks RCU grace periods to
sleep at TASK_IDLE priority, fix some comments, add some diagnostic
warning to the exit_tasks_rcu_start() and fix a buffer overflow in
the show_rcu_tasks_trace_gp_kthread().

rcutorture.2024.04.15a: Functionality improvement for better usability
and information of the tests, bug fixes, code cleanup and documention
update.

----------------------------------------------------------------

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
 include/linux/rcupdate.h                              |   20 +++++-
 kernel/rcu/Kconfig                                    |    6 +-
 kernel/rcu/rcutorture.c                               |   81 +++++++++++++++------------
 kernel/rcu/tasks.h                                    |   38 +++++++++++-
 kernel/rcu/tiny.c                                     |    2
 kernel/rcu/tree.c                                     |  408 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 kernel/rcu/tree.h                                     |   10 ++-
 kernel/rcu/tree_stall.h                               |    9 ++-
 tools/testing/selftests/rcutorture/bin/torture.sh     |    4 -
 38 files changed, 666 insertions(+), 140 deletions(-)
