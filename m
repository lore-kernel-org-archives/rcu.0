Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84331FFC62;
	Sun, 23 Mar 2025 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696489; cv=none; b=h8WLoonUbYudPdhPjt/0H13zAU9vkz6qjgPhHtQ4VQ0UycjoS9BOMwfNLd3C0TnJKUCV5leh3xyBFZ2JOgyX00sa4ydWLD4863n8B3KKCW7suumD7yeiiOSzs915MPxpxP8druejXBwQHf5foAvpTvSSBcf2pc21YR9ZtsTIO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696489; c=relaxed/simple;
	bh=fQ5Z3NSNCm3aGSYH+FftqQueFBJPG0SOnK6uQ2AsbYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l59eZcaEX4KfDG+pgVYRendrcrh9r50XHkSI6K+JEDLWlz5yJuz65uPbFLoSZLrOhqc6G7z+2yCDhKMNNSKCHy7ga3g7OVtIXzn3WppdGgm23jrhjPB15UQZY5SmlMAthriZpLaZD90NotciUJzKm/uY1i3HzI5EpuMkokQoW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUmsIPCx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUmsIPCx"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so26890776d6.2;
        Sat, 22 Mar 2025 19:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742696487; x=1743301287; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1dgETDWRkmBFgVmFnp9kqvNBTqgAU/LjYpNxSto7Q5Q=;
        b=JUmsIPCx9kXQL0XAvqizJe59DiOuuHNRxbDndT7Mmbt5rgeiJaaNiptFYoxQyDHsQ+
         zbVZzWy/pQB/qxKwSJps6qK4ghszaBk0AquN6Tuu+lhsPut56slQjyvYGG7KJX3jIrgB
         enYSjlOqC41HvbdsdfWjxH0wiY9rns8Hv3geT9k+kpEaKP/Icc8XhTOuGIfTnS/vyRpC
         SZo6mBh4RXku3la32HGmReCAOgfKi33+dOE7520qPeoROQQbYEE0TNS6WShgofX2SXnE
         93A1thnvoy2Y+eU2KuRId771L5RCeumkop2TKigJ/F7bnDIKlNRrrHAL1ZsjM8V/MW4L
         IKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742696487; x=1743301287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dgETDWRkmBFgVmFnp9kqvNBTqgAU/LjYpNxSto7Q5Q=;
        b=FAiPNT2IURvKDADLlbivq8SoL3MUtZsBHZGDDlp+ozBWJSztNSC94iqRN37PGanr98
         xPWbf6ZtkjJZMejwcj/JdnequmQoT7F9rCYwPDe4S2NOVUqAUZ02zTYKmL67CUT+S7p1
         O3V3M6bZvlohrdikMbU+sYI46MN51iq1UntKMxojQdlFzlJzvGgZj/z1RJ11PB4XS5Dx
         KouHCZNTtVpzbatjHa42CAw/MdoGq2yH2al5/jeRQLwGqVhMPvTxqNFFkmHsf9cjTkSA
         aN5PdpebZTWaccG3hbRDrp0TEsFkwLEbH5JPFysTqJN4Sy5vuqjkBIADZwCpH3wmFTVH
         PCpg==
X-Forwarded-Encrypted: i=1; AJvYcCU5vCvyEoqwOY5Xxg1X8TcnC+NkDtoQd15b7eoMoVNIU16ycT+kXnQkcZFt4RJSw3LD1PL5@vger.kernel.org, AJvYcCX29QHyowrRJEtzY5zLSCPr6RJzFwIHawJEosvigQNbJ0etAdaL6oZYkkSjUuPzJflPTCOASZ+ofa9dvsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy954KED/+4swrtQ58wM3xHq1MASnSLMojNFQofJcnIdSn6/06f
	Koe9RdbubuJL4pRuBTvkog1SBVQSs7zYB1KGrkIgH2+Id6bMJ+7G
X-Gm-Gg: ASbGnct6iy+dbf3HxrybMp2m1ncVDLZP79di+bFf3+Gay4aTDzeLLuNm3heV0kj+498
	7HuyZZowQNTfdsOan3uf7xc2U0CMMwJ120IKPhsp14inVnbjXgW0aO8jlRP79wgHbjOktZ7nH6D
	RhlUwtqdDw9mjlOM6BZdQDj2lYpjc/ai2MoSLXtXut4Til6LZ8wScq6jqDI61RUDTBQbLyfYa03
	uElluRxSflcSttcqAHGm4br3Pk5GuZu22Kn7dmbZtRPmD3h/gvnV+IPKycf3+31eZBY6wo1jwbD
	wJ++Uj6gz1XB7xXz3zI1piExH5TRQ/dGQaBvoitojl6PsylsOD1dcHoR4QAZ1nBhtmKpVxipx1v
	CjwZaxuox3tDCEFUmd8nugk3fZhBPG20ACro=
X-Google-Smtp-Source: AGHT+IEY/nOy/4Cmx8ig9IgFuv7woYs7hKFIIKiZGzj4NIrbYRzarAmgeaP0LCXRXV0HznrSr/z2sw==
X-Received: by 2002:a05:6214:194b:b0:6e6:6103:f708 with SMTP id 6a1803df08f44-6eb3f34b97cmr130574206d6.38.1742696486435;
        Sat, 22 Mar 2025 19:21:26 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0f405sm27756146d6.20.2025.03.22.19.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 19:21:25 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id A02CD1200043;
	Sat, 22 Mar 2025 22:21:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 22 Mar 2025 22:21:25 -0400
X-ME-Sender: <xms:JXDfZzjbFYj0HtszGcL9KVeAgIfoyr0Mi_yZwxVh9ufqqpohNo9B1A>
    <xme:JXDfZwDD2INI6EMUabBofJ0ZlP1PLzwjQGpwT1I3BuWI1JBPeFBt9BL34XHm3dqGv
    Y9roW9lChrl-nni-w>
X-ME-Received: <xmr:JXDfZzFf3Z0UCqZSUxRVtsu9TmEV0iGFpX7yVoroq921ELAfU_TD7x6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeltdefueegfefhuedtheefvdelhfeftedvhfdt
    veelueegtdejjedvieettedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrh
    hitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigr
    hieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnh
    guvghsrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgt
    uhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JXDfZwT61p6r8pRS_eZYH9aR01mgKYck12MuiQ6KVnJnINVrs3gT5g>
    <xmx:JXDfZwzQG_Z6DCtCBr_IAzxpJm3vIMPcoDzf2rr3v36Q-Bt8F4_qQw>
    <xmx:JXDfZ275uHoLANQD6h8Y9gVgaN32Kk6VRRFjXpmEtx1mJmnbXy0gGw>
    <xmx:JXDfZ1yZ4DgnvRY_05Amrs15KafMJAW2RHPkMwol02dexU4iuUqYYA>
    <xmx:JXDfZwjB6jKNlSZXmWHYzjcu8ZYqU2-9VyqwgTQz6bxjsnY7xTEnVdTh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Mar 2025 22:21:25 -0400 (EDT)
Date: Sat, 22 Mar 2025 19:21:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [GIT PULL] RCU changes for v6.15
Message-ID: <Z99wJFZC1XlvA4vC@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

When the merge window opens, please pull the RCU update:

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-next-v6.15

for you to fetch changes up to 467c890f2d1ad6de9fd1dbd196fdc8f3ee63190a:

  Merge branches 'docs.2025.02.04a', 'lazypreempt.2025.03.04a', 'misc.2025.03.04a', 'srcu.2025.02.05a' and 'torture.2025.02.05a' (2025-03-04 18:47:32 -0800)


There is a small conflict with slab tree:

	https://lore.kernel.org/all/20250212150941.5e4fa1c9@canb.auug.org.au/

and Stephen's resolution looks good to me. I also made an example of my own resolution
at:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git merge/rcu-vs-slab.2025.03.21a

Regards,
Boqun

----------------------------------------------------------------
RCU pull request for v6.15

This pull request contains the following branches:

docs.2025.02.04a:
 - Add broken-timing possibility to stallwarn.rst.
 - Improve discussion of this_cpu_ptr(), add raw_cpu_ptr().
 - Document self-propagating callbacks.
 - Point call_srcu() to call_rcu() for detailed memory ordering.
 - Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header.
 - Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text.
 - Remove references to old grace-period-wait primitives.

srcu.2025.02.05a:
 - Introduce srcu_read_{un,}lock_fast(), which is similar to
   srcu_read_{un,}lock_lite(): avoid smp_mb()s in lock and unlock at the
   cost of calling synchronize_rcu() in synchronize_srcu(). Moreover, by
   returning the percpu offset of the counter at srcu_read_lock_fast()
   time, srcu_read_unlock_fast() can save extra pointer dereferencing,
   which makes it faster than srcu_read_{un,}lock_lite().
   srcu_read_{un,}lock_fast() are intended to replace
   rcu_read_{un,}lock_trace() if possible.

torture.2025.02.05a:
 - Add get_torture_init_jiffies() to return the start time of the test.
 - Add a test_boost_holdoff module parameter to allow delaying boosting
   tests when building rcutorture as built-in.
 - Add grace period sequence number logging at the beginning and end of
   failure/close-call results.
 - Switch to hexadecimal for the expedited grace period sequence number
   in the rcu_exp_grace_period trace point.
 - Make cur_ops->format_gp_seqs take buffer length.
 - Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool.
 - Complain when invalid SRCU reader_flavor is specified.
 - Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing, which forces SRCU
   uses atomics even when percpu ops are NMI safe, and use the Kconfig
   for SRCU lockdep testing.

misc.2025.03.04a:
 - Split rcu_report_exp_cpu_mult() mask parameter and use for tracing.
 - Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes().
 - Fix get_state_synchronize_rcu_full() GP-start detection.
 - Move RCU Tasks self-tests to core_initcall().
 - Print segment lengths in show_rcu_nocb_gp_state().
 - Make RCU watch ct_kernel_exit_state() warning.
 - Flush console log from kernel_power_off().
 - rcutorture: Allow a negative value for nfakewriters.
 - rcu: Update TREE05.boot to test normal synchronize_rcu().
 - rcu: Use _full() API to debug synchronize_rcu().

lazypreempt.2025.03.04a: Make RCU handle PREEMPT_LAZY better:
 - Fix header guard for rcu_all_qs().
 - rcu: Rename PREEMPT_AUTO to PREEMPT_LAZY.
 - Update __cond_resched comment about RCU quiescent states.
 - Handle unstable rdp in rcu_read_unlock_strict().
 - Handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y.
 - osnoise: Provide quiescent states.
 - Adjust rcutorture with possible PREEMPT_RCU=n && PREEMPT_COUNT=y
   combination.
 - Limit PREEMPT_RCU configurations.
 - Make rcutorture senario TREE07 and senario TREE10 use PREEMPT_LAZY=y.

----------------------------------------------------------------
Ankur Arora (7):
      rcu: fix header guard for rcu_all_qs()
      rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
      sched: update __cond_resched comment about RCU quiescent states
      rcu: handle unstable rdp in rcu_read_unlock_strict()
      rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
      osnoise: provide quiescent states
      rcu: limit PREEMPT_RCU configurations

Boqun Feng (2):
      rcutorture: Update ->extendables check for lazy preemption
      Merge branches 'docs.2025.02.04a', 'lazypreempt.2025.03.04a', 'misc.2025.03.04a', 'srcu.2025.02.05a' and 'torture.2025.02.05a'

Paul E. McKenney (47):
      doc: Add broken-timing possibility to stallwarn.rst
      docs: Improve discussion of this_cpu_ptr(), add raw_cpu_ptr()
      rcu: Document self-propagating callbacks
      srcu: Point call_srcu() to call_rcu() for detailed memory ordering
      rcu: Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header
      rcu: Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text
      rcu: Remove references to old grace-period-wait primitives
      rcu: Split rcu_report_exp_cpu_mult() mask parameter and use for tracing
      srcu: Make Tiny SRCU able to operate in preemptible kernels
      srcu: Define SRCU_READ_FLAVOR_ALL in terms of symbols
      srcu: Use ->srcu_gp_seq for rcutorture reader batch
      srcu: Pull ->srcu_{un,}lock_count into a new srcu_ctr structure
      srcu: Make SRCU readers use ->srcu_ctrs for counter selection
      srcu: Make Tree SRCU updates independent of ->srcu_idx
      srcu: Force synchronization for srcu_get_delay()
      srcu: Rename srcu_check_read_flavor_lite() to srcu_check_read_flavor_force()
      srcu: Add SRCU_READ_FLAVOR_SLOWGP to flag need for synchronize_rcu()
      srcu: Pull pointer-to-integer conversion into __srcu_ptr_to_ctr()
      srcu: Pull integer-to-pointer conversion into __srcu_ctr_to_ptr()
      srcu: Move SRCU Tree/Tiny definitions from srcu.h
      srcu: Add SRCU-fast readers
      rcutorture: Add ability to test srcu_read_{,un}lock_fast()
      refscale: Add srcu_read_lock_fast() support using "srcu-fast"
      rcutorture:  Make scenario SRCU-P use srcu_read_lock_fast()
      srcu: Fix srcu_read_unlock_{lite,nmisafe}() kernel-doc
      srcu: Document that srcu_{read_lock,down_read}() can share srcu_struct
      srcu: Add srcu_down_read_fast() and srcu_up_read_fast()
      srcu: Make SRCU-fast also be NMI-safe
      torture: Add get_torture_init_jiffies() for test-start time
      rcutorture: Add a test_boost_holdoff module parameter
      rcutorture: Include grace-period sequence numbers in failure/close-call
      rcutorture: Expand failure/close-call grace-period output
      rcu: Trace expedited grace-period numbers in hexadecimal
      rcutorture: Add ftrace-compatible timestamp to GP# failure/close-call output
      rcutorture: Make cur_ops->format_gp_seqs take buffer length
      rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool
      rcutorture: Complain when invalid SRCU reader_flavor is specified
      srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
      torture: Make SRCU lockdep testing use srcu_read_lock_nmisafe()
      rcu: Fix get_state_synchronize_rcu_full() GP-start detection
      rcu-tasks: Move RCU Tasks self-tests to core_initcall()
      rcu/nocb: Print segment lengths in show_rcu_nocb_gp_state()
      context_tracking: Make RCU watch ct_kernel_exit_state() warning
      Flush console log from kernel_power_off()
      rcutorture: Update rcutorture_one_extend_check() for lazy preemption
      rcutorture: Make scenario TREE10 build CONFIG_PREEMPT_LAZY=y
      rcutorture: Make scenario TREE07 build CONFIG_PREEMPT_LAZY=y

Uladzislau Rezki (Sony) (3):
      rcutorture: Allow a negative value for nfakewriters
      rcu: Update TREE05.boot to test normal synchronize_rcu()
      rcu: Use _full() API to debug synchronize_rcu()

Zilin Guan (1):
      rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()

 Documentation/RCU/rcubarrier.rst                   |   5 +-
 Documentation/RCU/stallwarn.rst                    |   7 +
 Documentation/admin-guide/kernel-parameters.txt    |   5 +
 Documentation/core-api/this_cpu_ops.rst            |  22 ++-
 include/linux/printk.h                             |   6 +
 include/linux/rcupdate.h                           |  25 +--
 include/linux/rcupdate_wait.h                      |   3 +
 include/linux/rcutree.h                            |   2 +-
 include/linux/srcu.h                               | 102 ++++++++--
 include/linux/srcutiny.h                           |  29 ++-
 include/linux/srcutree.h                           |  98 ++++++++--
 include/linux/torture.h                            |   1 +
 include/trace/events/rcu.h                         |   2 +-
 init/main.c                                        |   1 -
 kernel/context_tracking.c                          |   9 +-
 kernel/printk/printk.c                             |   4 +-
 kernel/rcu/Kconfig                                 |  35 +++-
 kernel/rcu/Kconfig.debug                           |  18 +-
 kernel/rcu/rcu.h                                   |  13 +-
 kernel/rcu/rcutorture.c                            | 124 ++++++++++--
 kernel/rcu/refscale.c                              |  32 +++-
 kernel/rcu/srcutiny.c                              |  20 +-
 kernel/rcu/srcutree.c                              | 207 +++++++++++----------
 kernel/rcu/tasks.h                                 |   5 +-
 kernel/rcu/tiny.c                                  |  14 ++
 kernel/rcu/tree.c                                  |  64 +++++--
 kernel/rcu/tree_exp.h                              |   6 +-
 kernel/rcu/tree_nocb.h                             |  20 +-
 kernel/rcu/tree_plugin.h                           |  22 ++-
 kernel/reboot.c                                    |   1 +
 kernel/sched/core.c                                |   4 +-
 kernel/torture.c                                   |  12 ++
 kernel/trace/trace_osnoise.c                       |  32 ++--
 .../selftests/rcutorture/bin/srcu_lockdep.sh       |   2 +-
 .../selftests/rcutorture/configs/rcu/SRCU-P.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TREE05.boot   |   6 +
 .../selftests/rcutorture/configs/rcu/TREE07        |   3 +-
 .../selftests/rcutorture/configs/rcu/TREE10        |   3 +-
 38 files changed, 718 insertions(+), 247 deletions(-)
