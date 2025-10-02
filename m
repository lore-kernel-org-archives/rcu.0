Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34719245006;
	Thu,  2 Oct 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421732; cv=none; b=WY07cqnfov/ScfDxgelvK3SWI83YjNWMUV0HYgjX4Xlpfeu0CcT40K1VUmY8oZGIw+xl5SOBV36+fSH8j4FGIPnply2YDqxyznNFy6OpQhFLxAaOxDBg2amTl4IOIy7tN2Ur/XjBJLIk5bSofXt3Rzd+QyjXOCgaDkhFEeVNELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421732; c=relaxed/simple;
	bh=buMaABYKeuu7EzStngN7lRoHldJv3zzZqBJVbXiTgh4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mAk4R1NSPOeF7q5oGc1hbJYqnlfTELRCwO1oGIeetULD+6AqWXARVhU2hw/VwssXL3Hibv6KjcXRHRGpaaqZxr73Qjdry7bWe2BdS0s7+fMIqfJbqFi8z8CqP5ZFwVx6HVtUk+CF6HHIlWvPfYjSv3Zjiu31dOeaUwB5aP2sqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVAzF5Rv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVAzF5Rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988E0C4CEF9;
	Thu,  2 Oct 2025 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759421731;
	bh=buMaABYKeuu7EzStngN7lRoHldJv3zzZqBJVbXiTgh4=;
	h=Date:From:To:Subject:Reply-To:From;
	b=lVAzF5RvhCqNZ/Pe69dP110soGl9guHPtde4ge1OG06E/BhEi/g9e1ujuCHprmt4z
	 qqMgD46GVy82R8YtbpP95SrW30adxBMY1lavLIJkdkLdK6vXPNsy6UNTuaR5W2akbG
	 RGONQK5fOIJtznBNCNa93DhiHXqQUAcjEHBXVBz2b+4ONNrGlNjiGbyucfELOVa2be
	 N4EFYRpMrUI+e/FatgCDYPDFjDCtDcFuPO1cl6jTbdjltTZF4y3w9gQvSTKQXFIn61
	 OKssn4VSCxxtGk2d0iMJGWG0KVeOxbFBcxjbdelDolnVmJeuFL7/lconHbVQovChH/
	 Xt1NO7OFN4DSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3D4C7CE0F80; Thu,  2 Oct 2025 09:15:29 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:15:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org, -c@paulmck-thinkpad-p17-gen-1,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rcu@vger.kernel.org
Subject: [GIT PULL] RCU changes for v6.18
Message-ID: <54b61526-1b94-4dd5-a339-27ba75fb52f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Please pull this RCU update into the v6.18 merge window:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux tags/rcu.2025.09.26a
  # HEAD: 1d289fc5691c7a970a285bc53292bac9e37c89a6: Merge branch 'torture.2025.08.14a' into HEAD (2025-09-23 02:10:51 -0700)

----------------------------------------------------------------
RCU pull request for v6.18

This pull request contains the following branches, non-octopus merged:

Documentation updates:

  - Update whatisRCU.rst and checklist.rst for recent RCU API additions.

  - Fix RCU documentation formatting and typos.

  - Replace dead Ottawa Linux Symposium links in RTFP.txt.

Miscellaneous RCU updates:

  - Document that rcu_barrier() hurries RCU_LAZY callbacks.

  - Remove redundant interrupt disabling from
    rcu_preempt_deferred_qs_handler().

  - Move list_for_each_rcu from list.h to rculist.h, and adjust the
    include directive in kernel/cgroup/dmem.c accordingly.

  - Make initial set of changes to accommodate upcoming system_percpu_wq
    changes.

SRCU updates:

  - Create an srcu_read_lock_fast_notrace() for eventual use in tracing,
    including adding guards.

  - Document the reliance on per-CPU operations as implicit RCU readers
    in __srcu_read_{,un}lock_fast().

  - Document the srcu_flip() function's memory-barrier D's relationship
    to SRCU-fast readers.

  - Remove a redundant preempt_disable() and preempt_enable() pair from
    srcu_gp_start_if_needed().

Torture-test updates:

  - Fix jitter.sh spin time so that it actually varies as advertised.
    It is still quite coarse-grained, but at least it does now vary.

  - Update torture.sh help text to include the not-so-new --do-normal
    parameter, which permits (for example) testing KCSAN kernels without
    doing non-debug kernels.

  - Fix a number of false-positive diagnostics that were being triggered
    by rcutorture starting before boot completed.  Running multiple
    near-CPU-bound rcutorture processes when there is only the boot CPU
    is after all a bit excessive.

  - Substitute kcalloc() for kzalloc().

  - Remove a redundant kfree() and NULL out kfree()ed objects.

----------------------------------------------------------------
Akira Yokosawa (1):
      rcu: docs: Requirements.rst: Abide by conventions of kernel documentation

Andy Shevchenko (1):
      rculist: move list_for_each_rcu() to where it belongs

Bagas Sanjaya (3):
      Documentation: RCU: Wrap kvm-remote.sh rerun snippet in literal code block
      Documentation: RCU: Reduce toctree depth
      Documentation: RCU: Retitle toctree index

Kaushlendra Kumar (2):
      refperf: Remove redundant kfree() after torture_stop_kthread()
      refperf: Set reader_tasks to NULL after kfree()

Marco Crivellari (3):
      rcu: replace use of system_wq with system_percpu_wq
      rcu: WQ_PERCPU added to alloc_workqueue users
      rcu: WQ_UNBOUND added to sync_wq workqueue

Nikil Paul S (1):
      docs: rcu: Replace multiple dead OLS links in RTFP.txt

Paul E. McKenney (20):
      rcu: Document that rcu_barrier() hurries lazy callbacks
      srcu: Move rcu_is_watching() checks to srcu_read_{,un}lock_fast()
      srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
      srcu: Add guards for notrace variants of SRCU-fast readers
      rcutorture: Fix jitter.sh spin time
      torture: Add --do-normal parameter to torture.sh help text
      torture: Announce kernel boot status at torture-test startup
      rcutorture: Suppress "Writer stall state" reports during boot
      rcutorture: Delay rcutorture readers and writers until boot completes
      torture: Delay CPU-hotplug operations until boot completes
      rcutorture: Delay forward-progress testing until boot completes
      doc: Update whatisRCU.rst for recent RCU API additions
      doc: Add RCU guards to checklist.rst
      doc: Fix typo in RCU's torture.rst documentation
      Merge branch 'doc.2025.08.20a' into HEAD
      srcu: Document __srcu_read_{,un}lock_fast() implicit RCU readers
      srcu: Document srcu_flip() memory-barrier D relation to SRCU-fast
      Merge branch 'rcu.2025.09.23a' into HEAD
      Merge branch 'srcu-next.2025.08.21a' into HEAD
      Merge branch 'torture.2025.08.14a' into HEAD

Qianfeng Rong (2):
      rcutorture: Use kcalloc() instead of kzalloc()
      refscale: Use kcalloc() instead of kzalloc()

Zqiang (2):
      rcu: Remove local_irq_save/restore() in rcu_preempt_deferred_qs_handler()
      srcu/tiny: Remove preempt_disable/enable() in srcu_gp_start_if_needed()

 .../RCU/Design/Requirements/Requirements.rst       |  52 ++++---
 Documentation/RCU/RTFP.txt                         |   6 +-
 Documentation/RCU/checklist.rst                    |  27 ++--
 Documentation/RCU/index.rst                        |   6 +-
 Documentation/RCU/torture.rst                      |   4 +-
 Documentation/RCU/whatisRCU.rst                    | 150 ++++++++++++++++-----
 include/linux/list.h                               |  10 --
 include/linux/rculist.h                            |  10 ++
 include/linux/srcu.h                               |  34 +++++
 include/linux/srcutree.h                           |  49 ++++---
 kernel/cgroup/dmem.c                               |   1 +
 kernel/rcu/rcutorture.c                            |  27 +++-
 kernel/rcu/refscale.c                              |   4 +-
 kernel/rcu/srcutiny.c                              |   4 +-
 kernel/rcu/srcutree.c                              |  10 ++
 kernel/rcu/tasks.h                                 |   4 +-
 kernel/rcu/tree.c                                  |   9 +-
 kernel/rcu/tree_plugin.h                           |   5 +-
 kernel/torture.c                                   |   7 +-
 tools/testing/selftests/rcutorture/bin/jitter.sh   |  27 +++-
 tools/testing/selftests/rcutorture/bin/torture.sh  |   1 +
 21 files changed, 317 insertions(+), 130 deletions(-)
