Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E058166F29;
	Fri, 17 Jan 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134687; cv=none; b=EMkxwh8jGc9bqurIud5XF25WSUq2dl2HWpFaPmgyUGnJFsgydX5TsbBHAi/zjYXQpIFrgH8IQXHiazgHVsa920sYTTBS3ypIOWZtwaiJI+vJOLmOgdKiwCt/ZoHokLmmHYtjzxZIlVo/952NvSQ4nVJu1Zb9CvCmgWueZT3xa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134687; c=relaxed/simple;
	bh=vQjjD7FPoYaAO1rCeuGip+ShuzpBMzlvg1IFriProcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pq0IYty60/trC29ZPFEGI02nS/c4S9S8sFOKuQswGPjOas8GgRU2RPv7VdIPpz2zpvlPb6ltXTKp0cxNMTvQb5BMkmPiaG46/yt48NI6+wPDy+N4HIbjD4lUsHVemu8ffOBAqchg2GUdiMKFuy7+MKdv1HR6Xt3We7Ea3+6MbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As0sVt9J; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As0sVt9J"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401e6efffcso2618287e87.3;
        Fri, 17 Jan 2025 09:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737134683; x=1737739483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/H3/XMYSEjWC6PXGCCgpkrZcBA3IHPQi9kADqhE4Gw=;
        b=As0sVt9J+AvLWISuYvQ4Ywf20rasbX73MQh2vCqYa23ZfYnsN7rCBnbY8IeirwsTjI
         xvXNsOonTH7lOy31eCJBJteYQ6tTVAhnGFikVn7QKKs1NRjGXiJIHL2Lqlcvrx5St+H7
         VcLdfAzLrN+6CGQw6Kr/ocvB8lkedrULphHBXI39HjBA8daXabBu3mpEbJfDiABiTH0+
         ZmqjIqvsMYzbC9NGhP1VFBMCmr3AIaCHook8Aq3g1/NFEnO2ZHkg9AqBFOBPCHavZQSG
         5MgdTpYZTBc2Jci3UXKrqTdF31Hf2rb+zKyUH0VRfNxu7pfHcHPdVEiqhrjjxgTXiMJN
         zfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134683; x=1737739483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/H3/XMYSEjWC6PXGCCgpkrZcBA3IHPQi9kADqhE4Gw=;
        b=S087n50OaB5QcwNg4Z2byRfGs76Oki93ygOC5PJMbsi5Ay6uTq4y0bvaTlBWc+/cWa
         El2k0eakgCJyVaA07HJWJEHPOv4/FZfuDlXTqQIdTy2FqjlauIIHOi2opINHCb4JK0BD
         mTAr68DXKlkpTyFitx3NFts21U/g7F6+O64DFc7xk5lFeqjQY2JyZARPK/NYxlTdJWxt
         6Xs6lPvcbY6L2HX7Pll5mRnzo+U+RsTCNxvF61jGI8VTNimC6vX+X4rQ3ATTJ7FFoB+E
         3PImRqnzcUqkJ0vLTKxk6c3D3a7SdhJhh1VsVMLK96qTdOyvxtO2py2ZB36k+osmdiTE
         ySJg==
X-Forwarded-Encrypted: i=1; AJvYcCXcwe6QsUAotSsFDhqi9QAlkwyDVb81DYgalqOMF5yddWF9x30DdisezO29+/i1Ljjvq6RcGAZXA7wMJgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbhTK/DnVjthYbzf8smTxmC8nD4+gjwE4EztX7nnlWeerj7jm
	wfTRxpaCcbSBk8NWrEAQuSGiT+y+BOVEZPhctryPu2Z4rh1Yc/WR
X-Gm-Gg: ASbGncsVv33+PPkSKrpkGFjd58EDoFuKJe1m0z6Ne5TId0p4jTtlu0MJmsi5Gcne3x2
	qWpju9PnosEwhMrGcH53a0OiEubI2u1RFuHvNJsAzSjQWwb846NRiNHj9FTN90ruSkNF6KXG3Yg
	t+ST24UHChNFZcUpxXoy5u/OzEJ0XCx8D/9uKS0/7phdFp3fsVf4xkXStfrvzsTTNr7riym+B5P
	1UATixz6ishe5+R0gzrPOG53znNSzAd/8kr7/grt4V2fUnkKxQV
X-Google-Smtp-Source: AGHT+IFKqKpMjmlUCfnqjw6ESn9IySNQPvOK9OOEbNn0Be48GmX9dVSmJAlEOZUH8D4c9ds3dgNGSA==
X-Received: by 2002:a19:f509:0:b0:540:3550:b0f1 with SMTP id 2adb3069b0e04-5439c22d865mr1034992e87.7.1737134683017;
        Fri, 17 Jan 2025 09:24:43 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af60a4esm435398e87.158.2025.01.17.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:24:42 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Feng Lee <379943137@qq.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [GIT PULL] RCU changes for v6.14
Date: Fri, 17 Jan 2025 18:24:40 +0100
Message-Id: <20250117172440.49319-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the latest RCU git tree from:

git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.14

# HEAD: 4b5c2205526cc1579b840893b98eb7545220f7cf:

Merge branches 'fixes.2024.12.14a', 'rcutorture.2024.12.14a', 'srcu.2024.12.14a' and 'torture-test.2024.12.14a' into rcu-merge.2024.12.14a

fixes.2024.12.14a: RCU fixes
rcutorture.2024.12.14a: Torture-test updates
srcu.2024.12.14a: SRCU updates
torture-test.2024.12.14a: Adding an extra test, fixes

One merge conflicts was detected by linux-next:

* https://lore.kernel.org/lkml/20241220133738.1beae531@canb.auug.org.au/T/

The conflict resolution from linux-next look good to me, plus I make
my own resolutions at branch merge/rcu.2024.12.21a for your reference.

----------------------------------------------------------------

RCU pull request for v6.14

This pull request contains the following branches:

fixes.2024.12.14a: Misc fixes, check if IRQs are disabled in rcu_exp_need_qs(),
    instrument KCSAN exclusive-writer assertions, add extra WARN_ON_ONCE() check,
    set the cpu_no_qs.b.exp under lock, warn if callback enqueued on offline CPU.

rcutorture.2024.12.14a: Torture-test updates, add rcutorture.preempt_duration kernel
    module parameter, make the TREE03 scenario do preemption, improve pooling timeouts
    for rcu_torture_writer(), improve output of "Failure/close-call rcutorture reader
    segments", add some reader-state debugging checks, update doc of polled APIs, add
    extra diagnostics for per-reader-segment preemption.

srcu.2024.12.14a: SRCU updates, improve doc for srcu_read_lock() in terms of return
    value, fix typo in comments, remove redundant GP sequence checks in the
    srcu_funnel_gp_start.

torture-test.2024.12.14a: Add an extra test for sched_clock(), improve testing
    on unresponsive systems.

----------------------------------------------------------------

Feng Lee (1):
  srcu: Remove redundant GP sequence checks in srcu_funnel_gp_start

Frederic Weisbecker (1):
  rcu: Report callbacks enqueued on offline CPU blind spot

Paul E. McKenney (29):
  refscale: Add test for sched_clock()
  torture: Make kvm-remote.sh give up on unresponsive system
  torture: Add dowarn argument to torture_sched_setaffinity()
  rcutorture: Add random real-time preemption
  rcutorture: Make the TREE03 scenario do preemption
  rcutorture: Decorate failing reader segments with CPU ID
  rcutorture: Use finer-grained timeouts for rcu_torture_writer() polling
  rcutorture: Add ->cond_sync_exp_full function to rcu_ops structure
  rcutorture: Check preemption for failing reader
  rcutorture: Decorate failing reader segments with last CPU ID
  rcutorture: Add full read-side contexts to "busted" torture type
  rcutorture: Pretty-print rcutorture reader segments
  rcutorture: Make rcutorture_one_extend() check reader state
  rcutorture: Ignore attempts to test preemption and forward progress
  rcutorture: Add documentation for recent conditional and polled APIs
  rcutorture: Add parameters to control polled/conditional wait interval
  rcutorture: Add preempt_count() to rcutorture_one_extend_check() diagnostics
  rcutorture: Read CPU ID for decoration protected by both reader types
  rcutorture: Add per-reader-segment preemption diagnostics
  rcutorture: Use symbols for SRCU reader flavors
  rcu: Make rcu_report_exp_cpu_mult() caller acquire lock
  rcu: Move rcu_report_exp_rdp() setting of ->cpu_no_qs.b.exp under lock
  rcu: Replace open-coded rcu_exp_need_qs() from rcu_exp_handler() with call
  rcu: Make preemptible rcu_exp_handler() check idempotency
  rcu: Add KCSAN exclusive-writer assertions for rdp->cpu_no_qs.b.exp
  rcu: Add lockdep_assert_irqs_disabled() to rcu_exp_need_qs()
  MAINTAINERS: Update RCU git tree
  srcu: Guarantee non-negative return value from srcu_read_lock()
  srcu: Fix typo s/srcu_check_read_flavor()/__srcu_check_read_flavor()/

 Documentation/admin-guide/kernel-parameters.txt                |   74 ++++++++++++++++++++
 MAINTAINERS                                                    |   10 +-
 Makefile                                                       |    2
 arch/x86/kernel/cpu/amd.c                                      |    2
 include/linux/rcupdate_wait.h                                  |   11 +++
 include/linux/srcu.h                                           |   15 ++--
 include/linux/srcutree.h                                       |    2
 include/linux/torture.h                                        |    2
 kernel/bpf/lpm_trie.c                                          |   44 +++++-------
 kernel/locking/locktorture.c                                   |    6 -
 kernel/rcu/Kconfig.debug                                       |   15 ++++
 kernel/rcu/rcutorture.c                                        |    2
 kernel/rcu/refscale.c                                          |   40 ++++++++++-
 kernel/rcu/srcutree.c                                          |    3
 kernel/rcu/tree.c                                              |    3
 kernel/rcu/tree_exp.h                                          |   20 +++--
 kernel/rcu/tree_plugin.h                                       |    1
 kernel/rcu/update.c                                            |    4 -
 scripts/mod/modpost.c                                          |    2
 scripts/package/install-extmod-build                           |    4 -
 tools/testing/selftests/bpf/.gitignore                         |    1
 tools/testing/selftests/bpf/Makefile                           |    2
 tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c |   10 --
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh           |   25 +++++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot     |    1
 include/linux/srcu.h                                           |   21 +++--
 include/linux/srcutree.h                                       |    8 --
 kernel/bpf/lpm_trie.c                                          |   87 +++++++++++++++---------
 kernel/rcu/Kconfig.debug                                       |   16 ++++
 kernel/rcu/rcutorture.c                                        |  279 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 kernel/rcu/srcutree.c                                          |    5 -
 kernel/rcu/tree_exp.h                                          |  128 ++++++++++++++++++++++-------------
 kernel/rcu/tree_plugin.h                                       |    1
 tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c |  395 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 37 files changed, 1033 insertions(+), 235 deletions(-)
