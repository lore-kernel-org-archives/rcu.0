Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9095366834
	for <rcu@vger.kernel.org>; Tue,  3 Feb 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108078; cv=none; b=B+jgfVtrd/l+iylu15d17v9we4yTjpZLwodXp+hhn9Lh7kTSYTGamaKWXX7X1xEAd5YB5/Ei9RiPtiXi/+sejzv98QRDWYFaHPip0C2408yuWDjWz1IijTDVyZfZHsO6MaCpHNLnJL6YZbcuBJRkAJRhndxpZ1PJXa1ECXVf984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108078; c=relaxed/simple;
	bh=4QhB1DoxyzFd9n3D2jjSJGOE1ikROZ3I+3q60HlQGkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MizexXU2RUI2NiZyEYdNjK2Elz2MV/Zukskjp4lGaRW5yCorBODVOauznr/k1Kz/g7oa99bg8fqywGBMdx5QxHWKPW7xeSfKP8D3mgb3OA+q00qPdGofLc7VLA4MhuYnLnaHYi6kGrY2RcM6SpQ088fF013ZUR5zQbU4OcHQo8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwkhe0tF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwkhe0tF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569F9C4AF0B;
	Tue,  3 Feb 2026 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770108078;
	bh=4QhB1DoxyzFd9n3D2jjSJGOE1ikROZ3I+3q60HlQGkw=;
	h=Date:From:To:Cc:Subject:From;
	b=Cwkhe0tF2jRcCN24iTI0udKrSfkjTl42IdCiXethKpmGHyF53SW7gcaUx1GLz4C5H
	 mGQ/xLp3nG4Qv3Cv+eyeEd0BUvMt25ZHahhDIhObOsaGwb6ghYltUSeeRu8tGYuToO
	 VN8EXgdmmx8THjg80GYVDEdJbJ7MZQQe3azKkatYFB6lPftesaI8DVrCE7GM+Admv+
	 CsS/zqRg6uckS6dW3XC7BCFemf2VGjefOty5JsyCEwPTy05CdKz4iqCFzWieuLtc9g
	 SmK5GbJk1ZchPG+QUJTIGaGM+2MvQ38LkSXvML4ppD2gvhYwndPKwyfxSYxDx6nlwd
	 e2YmzxNypnJFQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 74057F4006C;
	Tue,  3 Feb 2026 03:41:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 03:41:17 -0500
X-ME-Sender: <xms:rbSBaRLzqewE_Z1UwUpsQTZbzZxLHmjR0O8_kWwszdUo6O5c1BlSwA>
    <xme:rbSBaSFg4zImG6OqKvm5T3nE9WJau-8SdMH6gnVT9ANMEdO0sLLdZYY9Vb0x79o3x
    1Yoaqd4S_NYSH3SFP_MWOw4BSs5omvj8hBpkmedGO70J8H1sxTNvg>
X-ME-Received: <xmr:rbSBad_DGbHqLdSNp5A1EAIz6XKYFP-Zzs3eHJyrza5A6EtS0ocxYH0s4_i6IKxMNASvvPZkTTT8CQF_c4lx9EDLC4pAoNFC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeiie
    dvueeitedvudehheejieeftdfhffegtdeiudfhlefhtdetfedutdeuleeileenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvg
    hlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhr
    vgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvh
    hiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:rbSBaSJ2KJPyQkpHbh04w0Gkp2HQntAaA3o2ZLFaEkgasx46kVrJug>
    <xmx:rbSBabvUuy4LWQUt6so_2Wi1MOJQi_HsW0F8y8upTYqLNTHWaA1SLQ>
    <xmx:rbSBaZB8SWUs5ROc_tp1Ioc4b95Gys_SAONJ5MTqDFN2XX7QIGXt1g>
    <xmx:rbSBaTOimU537FiL2mkonWyAyhdO8e1Yj6nQmq8lwFOTTXS1Xshptw>
    <xmx:rbSBaRDjnHDHWamPCAEKROX5Ggf6HAp6iMgs1JnH0gejUhlqy-GQZmTl>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 03:41:16 -0500 (EST)
Date: Tue, 3 Feb 2026 00:41:15 -0800
From: Boqun Feng <boqun@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [GIT PULL] RCU changes for v7.0
Message-ID: <aYG0q5P0_GYhrFws@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Once the merge window opens, please pull the following changes of RCU.

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v7.0

for you to fetch changes up to ed062c41dfda2de8d1712c91e089303dae013bb7:

  Merge branch 'rcu-nocb.20260123a' (2026-01-23 11:15:36 -0800)


(As you may know, I'm switching away from my gmail, so while this
email is by my @kernel.org, all the commits for the PR are signed-off-by
my gmail, JFYI)

Regards,
Boqun

----------------------------------------------------------------
RCU changes for v7.0

RCU Tasks Trace:

Re-implement RCU tasks trace in term of SRCU-fast, not only more than 500 lines
of code are saved because of the reimplementation, a new set of API,
rcu_read_{,un}lock_tasks_trace(), becomes possible as well. Compared to the
previous rcu_read_{,un}lock_trace(), the new API avoid the task_struct accesses
thanks to the SRCU-fast semantics. As a result, the old
rcu_read{,un}lock_trace() API is now deprecated.

RCU Torture Test:

- Multiple improvements on kvm-series.sh (parallel run and progress showing
  metrics)
- Add context checks to rcu_torture_timer().
- Make config2csv.sh properly handle comments in .boot files.
- Include commit discription in testid.txt.

Miscellaneous RCU changes:

- Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early.
- Use suitable gfp_flags for the init_srcu_struct_nodes().
- Fix rcu_read_unlock() deadloop due to softirq.
- Correctly compute probability to invoke ->exp_current() in rcutorture.
- Make expedited RCU CPU stall warnings detect stall-end races.

RCU nocb:

- Remove unnecessary WakeOvfIsDeferred wake path and callback overload
  handling.
- Extract nocb_defer_wakeup_cancel() helper.

----------------------------------------------------------------
Boqun Feng (4):
      Merge branch 'rcu-tasks-trace.20260101a'
      Merge branch 'rcu-torture.20260104a' into rcu-next
      Merge branch 'rcu-misc.20260111a'
      Merge branch 'rcu-nocb.20260123a'

Joel Fernandes (6):
      rcutorture: Prevent concurrent kvm.sh runs on same source tree
      rcutorture: Add --kill-previous option to terminate previous kvm.sh runs
      rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early
      rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
      rcu/nocb: Remove dead callback overload handling
      rcu/nocb: Extract nocb_defer_wakeup_cancel() helper

Paul E. McKenney (17):
      rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast
      context_tracking: Remove rcu_task_trace_heavyweight_{enter,exit}()
      rcu: Clean up after the SRCU-fastification of RCU Tasks Trace
      rcu: Move rcu_tasks_trace_srcu_struct out of #ifdef CONFIG_TASKS_RCU_GENERIC
      rcu: Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs
      rcu: Update Requirements.rst for RCU Tasks Trace
      checkpatch: Deprecate rcu_read_{,un}lock_trace()
      srcu: Create an rcu_tasks_trace_expedite_current() function
      rcutorture: Test rcu_tasks_trace_expedite_current()
      rcutorture: Add context checks to rcu_torture_timer()
      torture: Parallelize kvm-series.sh guest-OS execution
      torture: Make kvm-series.sh give build numbers and totals
      torture: Make kvm-series.sh give run numbers and totals
      torture: Make config2csv.sh properly handle comments in .boot files
      torture: Include commit discription in testid.txt
      rcu: Make expedited RCU CPU stall warnings detect stall-end races
      rcutorture: Correctly compute probability to invoke ->exp_current()

Yao Kai (1):
      rcu: Fix rcu_read_unlock() deadloop due to softirq

Zqiang (1):
      srcu: Use suitable gfp_flags for the init_srcu_struct_nodes()

 .../RCU/Design/Requirements/Requirements.rst       |  12 +-
 Documentation/admin-guide/kernel-parameters.txt    |  15 -
 include/linux/rcupdate.h                           |  31 +-
 include/linux/rcupdate_trace.h                     | 166 ++++-
 include/linux/sched.h                              |   6 +-
 init/init_task.c                                   |   3 -
 kernel/context_tracking.c                          |  20 -
 kernel/fork.c                                      |   3 -
 kernel/rcu/Kconfig                                 |  43 +-
 kernel/rcu/rcu.h                                   |   9 -
 kernel/rcu/rcuscale.c                              |   7 -
 kernel/rcu/rcutorture.c                            |  10 +-
 kernel/rcu/srcutree.c                              |   2 +-
 kernel/rcu/tasks.h                                 | 708 +--------------------
 kernel/rcu/tree.c                                  |  14 +-
 kernel/rcu/tree.h                                  |   5 +-
 kernel/rcu/tree_exp.h                              |   7 +-
 kernel/rcu/tree_nocb.h                             |  80 +--
 kernel/rcu/tree_plugin.h                           |  15 +-
 scripts/checkpatch.pl                              |   4 +-
 tools/testing/selftests/rcutorture/.gitignore      |   1 +
 .../testing/selftests/rcutorture/bin/config2csv.sh |   2 +-
 .../testing/selftests/rcutorture/bin/kvm-series.sh | 184 +++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  40 ++
 tools/testing/selftests/rcutorture/bin/mktestid.sh |   2 +-
 .../selftests/rcutorture/configs/rcu/TRACE01       |   1 -
 .../selftests/rcutorture/configs/rcu/TRACE02       |   1 -
 27 files changed, 459 insertions(+), 932 deletions(-)
