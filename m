Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0C10A1F;
	Sat, 26 Jul 2025 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753497974; cv=none; b=KfBCarzC/OLw0+O1F1EnQK3c8ru7MVhIqE+ERlKlL794PiG0l9jL3zINVwzR3TnVnDRVXoCg21kUX+2JTLDI4SKIA/navj+XQAcmdNAmm+5t8oijuBP0c9mEAGYsco0yCpUd8h3EnZp5WjmHvHYTrlhwFYbWXKUgPov4IL3ExdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753497974; c=relaxed/simple;
	bh=Nfkk8YoHU5zbCSE3zfMLyNKb+yciYmAnYZ3+Gz9hfvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pMi76iDpHMfHjoaAbfMiCLEl/FIuev6q1u7iArcr8CVn4UZ/fGEyxxSaddd8anCQUSUSGsOmBafcKmBAPuJBqcefoq042k7IRUN4cPnFM/0RlNLrOUkjnLkQh5tzGD/fowEoBCFOr37mbJBZkq+evI500/94xKmRecz2ot/4Hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gflMb3HV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gflMb3HV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20C8C4CEE7;
	Sat, 26 Jul 2025 02:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753497974;
	bh=Nfkk8YoHU5zbCSE3zfMLyNKb+yciYmAnYZ3+Gz9hfvg=;
	h=Date:From:To:Cc:Subject:From;
	b=gflMb3HVzZGj4rQLQFv/z1izpHT25agKqOKslu7OO9IhNLja4O+/D0ooZmdZGfdOi
	 HM7XeBUeKSHw5W38ryRoijcEgkGRNx2toVJM2KU4qklEjyHNNreWL2S8MXVcAteOm0
	 fgOCYroPn2Btlhtp+232+erHOJELglM4zsXiiWBDo/chNpuwaeZbZTDwrpK1D4nOEn
	 fuVlQm9naxR/DTT6hemYT8DpzswbHZlgaBMmBQKYP/bM3tV6D91osQ3g0Gz16Si7ob
	 pgGyZl2Qg9K/YMtI2Wa/QE+mTo3l1Sh4IrdOMt30dc4CbISdaoh0yFUeuG6P7ifx0a
	 nlQWgS9BET0zg==
Date: Sat, 26 Jul 2025 08:16:05 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: torvalds@linux-foundation.org
Cc: paulmck@kernel.org, joelagnelf@nvidia.com, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rcu@vger.kernel.org, Tze-nan.Wu@mediatek.com,
	a.sadovnikov@ispras.ru
Subject: [GIT PULL] RCU changes for v6.17
Message-ID: <20250726024605.GA17131@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

When the merge window opens, please pull this RCU update.

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.17

for you to fetch changes up to cc1d1365f0f414f6522378867baa997642a7e6b2:

  Merge branches 'rcu-exp.23.07.2025', 'rcu.22.07.2025', 'torture-scripts.16.07.2025', 'srcu.19.07.2025', 'rcu.nocb.18.07.2025' and 'refscale.07.07.2025' into rcu.merge.23.07.2025 (2025-07-23 21:42:20 +0530)

Please note that below patch, which was initially picked for RCU next
testing has been removed, as it gave false positives with RCU torture
test. 

https://lore.kernel.org/rcu/20250429134304.3824863-6-frederic@kernel.org/

----------------------------------------------------------------
RCU pull request for v6.17

This pull request contains the following branches:

rcu-exp.23.07.2025

  - Protect against early RCU exp quiescent state reporting during exp
    grace period initialization.

  - Remove superfluous barrier in task unblock path.

  - Remove the CPU online quiescent state report optimization, which is
    error prone for certain scenarios.

  - Add warning for unexpected pending requested expedited quiescent
    state on dying CPU.

rcu.22.07.2025

  - Robustify rcu_is_cpu_rrupt_from_idle() by using more accurate
    indicators of the actual context tracking state of a CPU.

  - Handle ->defer_qs_iw_pending field data race.

  - Enable rcu_normal_wake_from_gp by default on systems with <= 16 CPUs.

  - Fix lockup in rcu_read_unlock() due to recursive irq_exit() calls.

  - Refactor expedited handling condition in rcu_read_unlock_special().

  - Documentation updates for hotplug and GP init scan ordering,
    separation of rcu_state and rnp's gp_seq states, quiescent state
    reporting for offline CPUs.

torture-scripts.16.07.2025

  - Cleanup and improve scripts : remove superfluous warnings for disabled
    tests; better handling of kvm.sh --kconfig arg; suppress some confusing
    diagnostics; tolerate bad kvm.sh args; add new diagnostic for build
    output; fail allmodconfig testing on warnings.

  - Include RCU_TORTURE_TEST_CHK_RDR_STATE config for KCSAN kernels.

  - Disable default RCU-tasks and clocksource-wdog testing on arm64.

  - Add EXPERT Kconfig option for arm64 KCSAN runs.

  - Remove SRCU-lite testing.

rcutorture.16.07.2025

  - Start torture writer threads creation after reader threads to handle
    race in SRCU-P scenario.

  - Add SRCU down_read()/up_read() test.

  - Add diagnostics for delayed SRCU up_read(), unmatched up_read(), print
    number of up/down readers and the number of such readers which
    migrated to other CPU.

  - Ignore certain unsupported configurations for trivial RCU test.

  - Fix splats in RT kernels due to inaccurate checks for BH-disabled
    context.

  - Enable checks and logs to capture intentionally exercised unexpected
    scenarios (too short readers) for BUSTED test.

  - Remove SRCU-lite testing.

srcu.19.07.2025

  - Expedite SRCU-fast grace periods.

  - Remove SRCU-lite implementation.

  - Add guards for SRCU-fast readers.

rcu.nocb.18.07.2025

  - Dump NOCB group leader state on stall detection.

  - Robustify nocb_cb_kthread pointer accesses.

  - Fix delayed execution of hurry callbacks when LAZY_RCU is enabled.

refscale.07.07.2025

  - Fix multiplication overflow in "loops" and "nreaders" calculations.

----------------------------------------------------------------
Artem Sadovnikov (1):
      refscale: Check that nreaders and loops multiplication doesn't overflow

Frederic Weisbecker (6):
      rcu/exp: Protect against early QS report
      rcu: Robustify rcu_is_cpu_rrupt_from_idle()
      rcu/nocb: Dump gp state even if rdp gp itself is not offloaded
      rcu/exp: Remove confusing needless full barrier on task unblock
      rcu/exp: Remove needless CPU up quiescent state report
      rcu/exp: Warn on QS requested on dying CPU

Joel Fernandes (5):
      rcu: Fix rcu_read_unlock() deadloop due to IRQ work
      rcu: Refactor expedited handling check in rcu_read_unlock_special()
      rcu: Document GP init vs hotplug-scan ordering requirements
      rcu: Document separation of rcu_state and rnp's gp_seq
      rcu: Document concurrent quiescent state reporting for offline CPUs

Neeraj Upadhyay (AMD) (1):
      Merge branches 'rcu-exp.23.07.2025', 'rcu.22.07.2025', 'torture-scripts.16.07.2025', 'srcu.19.07.2025', 'rcu.nocb.18.07.2025' and 'refscale.07.07.2025' into rcu.merge.23.07.2025

Paul E. McKenney (32):
      rcutorture: Print only one rtort_pipe_count splat
      rcutorture: Start rcu_torture_writer() after rcu_torture_reader()
      rcutorture: Make rcutorture_one_extend_check() account for hard IRQs
      rcutorture: Add tests for SRCU up/down reader primitives
      rcutorture: Pull rcu_torture_updown() loop body into new function
      rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
      rcutorture: Check for ->up_read() without matching ->down_read()
      rcutorture: Check for no up/down readers at task level
      rcutorture: Print number of RCU up/down readers and migrations
      rcutorture: Drop redundant "insoftirq" parameters
      rcutorture: Make Trivial RCU ignore onoff_interval and shuffle_interval
      rcutorture: Make BUSTED scenario check and log readers
      torture: Suppress torture.sh "Zero time" messages for disabled tests
      torture: Permit multiple space characters in kvm.sh --kconfig argument
      torture: Make torture.sh KCSAN runs set CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y
      torture: Default --no-rcutasksflavors on arm64
      torture: Default --no-clocksourcewd on arm64
      rcu: Protect ->defer_qs_iw_pending from data race
      torture: Provide EXPERT Kconfig option for arm64 KCSAN torture.sh runs
      torture: Suppress "find" diagnostics from torture.sh --do-none run
      torture: Extract testid.txt generation to separate script
      torture: Add textid.txt file to --do-allmodconfig and --do-rcu-rust runs
      torture: Make torture.sh tolerate runs having bad kvm.sh arguments
      torture: Add "ERROR" diagnostic for testing kernel-build output
      torture: Make torture.sh --allmodconfig testing fail on warnings
      torture: Remove support for SRCU-lite
      rcutorture: Remove SRCU-lite scenarios
      rcutorture: Remove support for SRCU-lite
      srcu: Expedite SRCU-fast grace periods
      srcu: Remove SRCU-lite implementation
      checkpatch: Remove SRCU-lite deprecation
      srcu: Add guards for SRCU-fast readers

Tze-nan Wu (1):
      rcu: Fix delayed execution of hurry callbacks

Uladzislau Rezki (Sony) (2):
      rcu: Enable rcu_normal_wake_from_gp on small systems
      Documentation/kernel-parameters: Update rcu_normal_wake_from_gp doc

Zqiang (2):
      rcutorture: Fix rcutorture_one_extend_check() splat in RT kernels
      rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access

 Documentation/RCU/Design/Data-Structures/Data-Structures.rst |  33 ++++++
 Documentation/RCU/Design/Requirements/Requirements.rst       | 128 +++++++++++++++++++++++
 Documentation/admin-guide/kernel-parameters.txt              |   3 +-
 include/linux/srcu.h                                         |  54 ++--------
 include/linux/srcutiny.h                                     |   3 -
 include/linux/srcutree.h                                     |  38 -------
 kernel/rcu/rcutorture.c                                      | 356 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 kernel/rcu/refscale.c                                        |  42 ++------
 kernel/rcu/srcutree.c                                        |   2 +
 kernel/rcu/tree.c                                            |  80 ++++++++++++---
 kernel/rcu/tree.h                                            |  13 ++-
 kernel/rcu/tree_exp.h                                        |  59 ++---------
 kernel/rcu/tree_nocb.h                                       |  10 +-
 kernel/rcu/tree_plugin.h                                     | 122 ++++++++++++++++++----
 kernel/rcu/tree_stall.h                                      |   3 +-
 scripts/checkpatch.pl                                        |   2 -
 tools/testing/selftests/rcutorture/bin/kvm-build.sh          |   2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh                |  15 +--
 tools/testing/selftests/rcutorture/bin/mktestid.sh           |  29 ++++++
 tools/testing/selftests/rcutorture/bin/torture.sh            |  78 +++++++++++---
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED        |   3 +
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST        |   1 -
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L        |  10 --
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot   |   3 -
 24 files changed, 770 insertions(+), 319 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/mktestid.sh
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
