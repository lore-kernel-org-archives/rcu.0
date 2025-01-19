Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA318C31;
	Sun, 19 Jan 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737329916; cv=none; b=aYfGI3sS72o3EQ1nTdZ3G1o8bD+RqFSl7M8EuGEz2hC8Ano7O/Bxu10oInGcoh/WyZUE1ay2/KnTahdrkcnxDB4L7qJM3wazfy2N/Zq8v2eo/taIUgkXBbW5OA4ucX9lvvtKWgfpCrbEUk1CAlY6inm5jgncHNvTJw28mvX45kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737329916; c=relaxed/simple;
	bh=4SZCGWD8nOYqgjCkOpU0tHUtIEPHcPgtIwlvmPjQo/4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aVZNIbUjnloXXQLREv96KiT286k2VwGI4lUZINwZSBKKNg2VAdloNh/evlhcsQ+u4Eh7HdtKAszM0kcjZ4G5HLOZrcOqQi6/F4ftDWVGMdcIQMgnBtzlodOchoGHZDxawoDnbQMuKT3h0XxPHhlrz7YlNhtTWM8v9+tYVEVf6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHGFj6rX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHGFj6rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B28C4CED6;
	Sun, 19 Jan 2025 23:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737329915;
	bh=4SZCGWD8nOYqgjCkOpU0tHUtIEPHcPgtIwlvmPjQo/4=;
	h=Date:From:To:Cc:Subject:From;
	b=KHGFj6rX9AFzWRWCaq5OpMJNTA9/FA0YAJXIFoNd6i4h9SZQtNcjSCuPd3u6kY+zT
	 XHaDcDBR9kV1Ql6UOHHR/Ipy9f6YI/ic52ZAeR6kg1nYZv0thdQoXFDrm1KrKHwEpB
	 TruxqFCxQlAWCjDoq31g45p/1sMX4OO/RczNFhg4L+i8oRKt1N+MkTWqBhhTNsmx7y
	 CdIlY5F7HjunQQF2OG5Mfx8BJplJQStHkUh+0IUnfI9+lphXacqURILzkI7B9gdtSY
	 BT2xBqe8ig70/KDBBS5nM+nN4vA42Is8oQaPyXnpRL0hbd0jjosFs4GOaEIGT/CS/7
	 BX+DLengH+xXQ==
Date: Mon, 20 Jan 2025 00:38:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	Michal Hocko <mhocko@suse.com>
Subject: [GIT PULL] kthread updates for v6.14
Message-ID: <Z42M-Zqd3kBNCfgz@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A pull request from me on the topic of kthreads may appear out of
the blue but this "subsystem" has no official maintainer and nobody
loudly volunteered to take these changes. Therefore I'm carrying
these myself.

Thanks.

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/kthread-for-6.14-rc1

for you to fetch changes up to d8b4bf4ea04dd96fe43f6010c614149aba4c9b91:

  kthread: modify kernel-doc function name to match code (2025-01-13 11:33:26 +0100)

----------------------------------------------------------------
Kthreads affinity follow either of 4 existing different patterns:

1) Per-CPU kthreads must stay affine to a single CPU and never execute
   relevant code on any other CPU. This is currently handled by smpboot
   code which takes care of CPU-hotplug operations. Affinity here is
   a correctness constraint.

2) Some kthreads _have_ to be affine to a specific set of CPUs and can't
   run anywhere else. The affinity is set through kthread_bind_mask()
   and the subsystem takes care by itself to handle CPU-hotplug
   operations. Affinity here is assumed to be a correctness constraint.

3) Per-node kthreads _prefer_ to be affine to a specific NUMA node. This
   is not a correctness constraint but merely a preference in terms of
   memory locality. kswapd and kcompactd both fall into this category.
   The affinity is set manually like for any other task and CPU-hotplug
   is supposed to be handled by the relevant subsystem so that the task
   is properly reaffined whenever a given CPU from the node comes up.
   Also care should be taken so that the node affinity doesn't cross
   isolated (nohz_full) cpumask boundaries.

4) Similar to the previous point except kthreads have a _preferred_
   affinity different than a node. Both RCU boost kthreads and RCU
   exp kworkers fall into this category as they refer to "RCU nodes"
   from a distinctly distributed tree.

Currently the preferred affinity patterns (3 and 4) have at least 4
identified users, with more or less success when it comes to handle
CPU-hotplug operations and CPU isolation. Each of which do it in its own
ad-hoc way.

This is an infrastructure proposal to handle this with the following API
changes:

_ kthread_create_on_node() automatically affines the created kthread to
  its target node unless it has been set as per-cpu or bound with
  kthread_bind[_mask]() before the first wake-up.

- kthread_affine_preferred() is a new function that can be called right
  after kthread_create_on_node() to specify a preferred affinity
  different than the specified node.

When the preferred affinity can't be applied because the possible
targets are offline or isolated (nohz_full), the kthread is affine
to the housekeeping CPUs (which means to all online CPUs most of the
time or only the non-nohz_full CPUs when nohz_full= is set).

kswapd, kcompactd, RCU boost kthreads and RCU exp kworkers have been
converted, along with a few old drivers.

Summary of the changes:

* Consolidate a bunch of ad-hoc implementations of kthread_run_on_cpu()

* Introduce task_cpu_fallback_mask() that defines the default last
  resort affinity of a task to become nohz_full aware

* Add some correctness check to ensure kthread_bind() is always called
  before the first kthread wake up.

* Default affine kthread to its preferred node.

* Convert kswapd / kcompactd and remove their halfway working ad-hoc
  affinity implementation

* Implement kthreads preferred affinity

* Unify kthread worker and kthread API's style

* Convert RCU kthreads to the new API and remove the ad-hoc affinity
  implementation.

----------------------------------------------------------------

Frederic Weisbecker (15):
      arm/bL_switcher: Use kthread_run_on_cpu()
      soc/qman: test: Use kthread_run_on_cpu()
      kallsyms: Use kthread_run_on_cpu()
      lib: test_objpool: Use kthread_run_on_cpu()
      arm64: Exclude nohz_full CPUs from 32bits el0 support
      sched,arm64: Handle CPU isolation on last resort fallback rq selection
      kthread: Make sure kthread hasn't started while binding it
      kthread: Default affine kthread to its preferred NUMA node
      mm: Create/affine kcompactd to its preferred node
      mm: Create/affine kswapd to its preferred node
      kthread: Implement preferred affinity
      rcu: Use kthread preferred affinity for RCU boost
      kthread: Unify kthread_create_on_cpu() and kthread_create_worker_on_cpu() automatic format
      treewide: Introduce kthread_run_worker[_on_cpu]()
      rcu: Use kthread preferred affinity for RCU exp kworkers

Randy Dunlap (1):
      kthread: modify kernel-doc function name to match code

 Documentation/arch/arm64/asymmetric-32bit.rst      |   8 +
 arch/arm/common/bL_switcher.c                      |  10 +-
 arch/arm64/include/asm/cpufeature.h                |   1 +
 arch/arm64/include/asm/mmu_context.h               |  14 +-
 arch/arm64/kernel/cpufeature.c                     |  15 +-
 arch/x86/kvm/i8254.c                               |   2 +-
 crypto/crypto_engine.c                             |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   2 +-
 drivers/gpu/drm/drm_vblank_work.c                  |   2 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |   2 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |   2 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |   2 +-
 drivers/gpu/drm/i915/gt/selftest_slpc.c            |   2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      |   8 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c       |   2 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   2 +-
 drivers/gpu/drm/msm/msm_kms.c                      |   2 +-
 .../media/platform/chips-media/wave5/wave5-vpu.c   |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   2 +-
 drivers/platform/chrome/cros_ec_spi.c              |   2 +-
 drivers/ptp/ptp_clock.c                            |   2 +-
 drivers/soc/fsl/qbman/qman_test_stash.c            |   6 +-
 drivers/spi/spi.c                                  |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   2 +-
 drivers/watchdog/watchdog_dev.c                    |   2 +-
 fs/erofs/zdata.c                                   |   2 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/kthread.h                            |  56 +++++-
 include/linux/mmu_context.h                        |   1 +
 kernel/kallsyms_selftest.c                         |   4 +-
 kernel/kthread.c                                   | 203 ++++++++++++++++++---
 kernel/rcu/tree.c                                  |  94 ++--------
 kernel/rcu/tree_plugin.h                           |  11 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/ext.c                                 |   2 +-
 kernel/workqueue.c                                 |   2 +-
 lib/test_objpool.c                                 |  19 +-
 mm/compaction.c                                    |  43 +----
 mm/vmscan.c                                        |   8 +-
 net/dsa/tag_ksz.c                                  |   2 +-
 net/dsa/tag_ocelot_8021q.c                         |   2 +-
 net/dsa/tag_sja1105.c                              |   2 +-
 47 files changed, 341 insertions(+), 221 deletions(-)
