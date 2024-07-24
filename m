Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AC15ADA4
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832282; cv=none; b=nL2hbTiJkbhIp+FqayeiMsg9Crpn5yzkiBU+0MwpAG2tJT6daPzr1nh93IDau7b6GztvtuqWLE7XtQWuUVlbYgYIPwhc+yDM/faKScdPdrBXpnKybAt7Uw1JI5rYqPfbJSt5EmKKIoKLH2xu00UrX9r80C9q5hIQIxrmwZHz21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832282; c=relaxed/simple;
	bh=bftM571UBpe9UzDZ1miwcvi5B1gsqLUgO8ciVhuBRKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRfeXjCZHdwTJpUgeunl1fQ42Q1lxRkPGOIiEtYKpyQZ2Pg5yXfvc14eC0C5ZyKPI53fTUsLO+BfRotShvPV4UwAEBkuERbbaczqx+zg1IuKGEji0wdm3ChcSeJIxr3LoSUIXFofYxyYBvLGj6PvnHKWBoVPEacmQy6CHtJAZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8MRV0fp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8MRV0fp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kPB12XYpqI/lgHwXqIgYprYEWNuhOdc3Lz3vHn+WVc4=;
	b=b8MRV0fprsjLhJae1wOe+sWafdS6vpaXrHCKBOF9+zZU0Czn8AJ76YtRulCSlLNH/gksWR
	5QkolmkpROOAvSp9HamMWGGjgkEPcDFqjF6lXHjPfJN2SMhYgWovlfenMXxZxGJHLX4KQx
	lr3Xcy3pWygelUkjLZMgu2AwFcuIkk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-SsuOV9BoObeRMU8Zi219jQ-1; Wed,
 24 Jul 2024 10:44:37 -0400
X-MC-Unique: SsuOV9BoObeRMU8Zi219jQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CFDB1955D4D;
	Wed, 24 Jul 2024 14:44:34 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA7801955F40;
	Wed, 24 Jul 2024 14:44:29 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3 00/25] context_tracking, rcu: Spring cleaning of dynticks references
Date: Wed, 24 Jul 2024 16:43:00 +0200
Message-ID: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Git info
========

The series is based on rcu/next at:
f395ae346be5 ("Merge branches 'doc.2024.06.06a', 'fixes.2024.06.06a', 'mb.2024.06.03a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a' and 'rcutorture.2024.06.06a' into HEAD")

It's also available as a git tree at:
https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v3-rcu-v3


Series description
==================

I've done one patch per renaming for my own sanity, a lot of these probably
deserve to be squashed together (e.g. all of the nmi_nesting into one).

At the end of the renaming exercise, the remaining RCU references to "dyntick"
are:
- Comments in core RCU code:
  kernel/rcu/:
  tree.h:208:8:	/* 3) dynticks interface. */
  tree.h:209:46:	int  watching_snap;		/* Per-GP tracking for dynticks. */
  tree_nocb.h:55:19: * about entering dyntick-idle mode.
  tree_plugin.h:873:4: * dyntick-idle quiescent state visible to other CPUs, which will in
  Kconfig:11:4:	# Dynticks-idle tracking
  tree.c:358:56: * We inform the RCU core by emulating a zero-duration dyntick-idle period.
  tree.c:773:10: * is in dynticks idle mode, which is an extended quiescent state.
  tree.c:793:54: * by virtue of being in or having passed through an dynticks idle state since
  tree.c:808:44:	 * If the CPU passed through or entered a dynticks idle phase with
  tree.c:1986:14:		/* Collect dyntick-idle snapshots. */
  tree.c:1989:13:		/* Handle dyntick-idle and offline CPUs. */
  tree.c:2683:54: * Otherwise, invoke the specified function to check dyntick state for
  tree.c:2743:16: * CPUs are in dyntick-idle mode.


- Stale documentation in RCU/Design/Data-Structures/Data-Structures.rst
  referencing fields that have been moved out of RCU after
  904e600e60f4 ("rcu/context_tracking: Move dynticks_nesting to context tracking")

Testing
=======

Ran through TREE01 and TREE04.

Revisions
=========

v2 -> v3
++++++++

o Collected Reviewed-By
o Rebased onto latest rcu/next

o Made it clear rcu_dynticks_in_eqs_since() is to be used in wait-for-EQS loops
o Slight rename variations following v2 suggestions

Cheers,
Valentin


Valentin Schneider (25):
  treewide: context_tracking: Rename CONTEXT_* into CT_STATE_*
  context_tracking, rcu: Rename RCU_DYNTICKS_IDX into CT_RCU_WATCHING
  context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
  context_tracking, rcu: Rename ct_dynticks_cpu() into
    ct_rcu_watching_cpu()
  context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into
    ct_rcu_watching_cpu_acquire()
  context_tracking, rcu: Rename struct context_tracking
    .dynticks_nesting into .nesting
  context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
  context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into
    ct_nesting_cpu()
  context_tracking, rcu: Rename struct context_tracking
    .dynticks_nmi_nesting into .nmi_nesting
  context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into
    ct_nmi_nesting()
  context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into
    ct_nmi_nesting_cpu()
  context_tracking, rcu: Rename DYNTICK_IRQ_NONIDLE into
    CT_NESTING_IRQ_NONIDLE
  context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
  context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into
    rcu_watching_curr_cpu()
  rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_online()
  rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_snap_in_eqs()
  rcu: Rename rcu_dynticks_in_eqs_since() into
    rcu_watching_snap_stopped_since()
  rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
  rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
  rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
  rcu: Rename dyntick_save_progress_counter() into
    rcu_watching_snap_save()
  rcu: Rename rcu_implicit_dynticks_qs() into rcu_implicit_eqs()
  rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
  rcu: Update stray documentation references to rcu_dynticks_eqs_{enter,
    exit}()
  context_tracking, rcu: Rename rcu_dyntick trace event into
    rcu_watching

 .../Data-Structures/Data-Structures.rst       |  28 ++--
 .../Tree-RCU-Memory-Ordering.rst              |   8 +-
 .../Memory-Ordering/TreeRCU-dyntick.svg       |   8 +-
 .../Design/Memory-Ordering/TreeRCU-gp-fqs.svg |   8 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg |   8 +-
 .../Memory-Ordering/TreeRCU-hotplug.svg       |   4 +-
 arch/Kconfig                                  |   2 +-
 arch/arm64/kernel/entry-common.c              |   2 +-
 arch/powerpc/include/asm/interrupt.h          |   6 +-
 arch/powerpc/kernel/interrupt.c               |   6 +-
 arch/powerpc/kernel/syscall.c                 |   2 +-
 arch/x86/entry/common.c                       |   2 +-
 include/linux/context_tracking.h              |  32 ++--
 include/linux/context_tracking_state.h        |  58 ++++----
 include/linux/entry-common.h                  |   2 +-
 include/linux/rcutiny.h                       |   2 +-
 include/linux/rcutree.h                       |   2 +-
 include/trace/events/rcu.h                    |  18 +--
 kernel/context_tracking.c                     | 140 +++++++++---------
 kernel/entry/common.c                         |   2 +-
 kernel/rcu/rcu.h                              |   4 +-
 kernel/rcu/rcutorture.c                       |   4 +-
 kernel/rcu/tasks.h                            |   2 +-
 kernel/rcu/tree.c                             | 111 +++++++-------
 kernel/rcu/tree.h                             |   4 +-
 kernel/rcu/tree_exp.h                         |   8 +-
 kernel/rcu/tree_nocb.h                        |   2 +-
 kernel/rcu/tree_plugin.h                      |   6 +-
 kernel/rcu/tree_stall.h                       |   6 +-
 kernel/sched/core.c                           |   4 +-
 kernel/stop_machine.c                         |   2 +-
 kernel/trace/trace_osnoise.c                  |   4 +-
 32 files changed, 256 insertions(+), 241 deletions(-)

--
2.43.0

