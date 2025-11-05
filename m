Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BD2D3EEE;
	Wed,  5 Nov 2025 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374661; cv=none; b=uZNk0PjFL70ktYAy71uTIoz+qp97yajCZnSgKLGsbxy1DYX2s8lRo/sO8F6GBEzNliFUH1GgKimLnE8tIkX/JwRyz84ncVDlYjlx/H8js4tByns/OoQc6HCsRvDXlF4pwqrJMOCatkqpUll6FtDWXlkYbbauTi4xzCf5pSutWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374661; c=relaxed/simple;
	bh=sxQuvX/WV2W1bappBx9oI1NpveSp6sJBwxr5rH6PSHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g+7Q2t2lNwYjD1NONfTMeUC+ftqd2rfH2mt2eKJjQ8HmXfS6qkl9driKHxQUIiR15lDGROBKwVL6gpMB5xwpq/9Jsl8zlE8kt2Kwx+6btUu718surHEWuhnZJCAsfytcv9wTLVv8xCWzXsWTCAFCAf3XbiWujaWZIO1+ntOPzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZiEwVyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZiEwVyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1793C4CEF5;
	Wed,  5 Nov 2025 20:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374661;
	bh=sxQuvX/WV2W1bappBx9oI1NpveSp6sJBwxr5rH6PSHs=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=eZiEwVyJDTEyCYZxAevGrmcfmMuYYrdwYUHIH+XfO8mjWvZ6o4Mbt53hHFLvUrOZT
	 XiZxA74KrN/Fvsx1PmJjXFOt/hx8f6G0vlBC2owXZWLQL/R9lExCV47bTBW8dJ+D6v
	 T7ApQI0d7oRjfwyHZbGIcuumUDylDFiR0nny1wIHKrsrrI1P1TSieTCYgotbiCVDuk
	 9XFMcdkooAYtZA/RxmkaIXkESNiXLKcySYH39w7l2MgrxNqPBiX/vYdTUs49U5CbaI
	 FwyGGpykJfAjCy59XjiUFH3UBcKIvxmQnHmtOKKfwW8642P/ZoVKalM9VkyVuLIE9h
	 xSZiiDsvdvYdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 058F5CE0B94; Wed,  5 Nov 2025 12:31:00 -0800 (PST)
Date: Wed, 5 Nov 2025 12:31:00 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/16] SRCU updates for v6.19
Message-ID: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series creates an srcu_expedite_current() function that allows
after-the-fact expediting of SRCU grace periods, adds a DEFINE_SRCU_FAST()
that further speeds things up by removing a conditional branch from
srcu_read_lock_fast*(), updates documentation, uses SRCU-fast to guard
event traces in PREEMPT_RT kernel (thus making such kernels safe for
event tracing), adds srcu_read_{,un}lock_fast_updown() functions that are
compatible with srcu_down_read() and srcu_up_read(), but do not permit
use in NMI handlers (to permit further optimization of SRCU-fast readers
by relieving them of the need to deal with irq/softirq/NMI handlers with
unbalanced lock/unlock calls), and optimizes SRCU-fast-updown for large
ARM servers that use LSE.  It is expected that this optimization will be
obsoleted by some arm64 architecture-specific work:

	https://lore.kernel.org/all/aQU7l-qMKJTx4znJ@arm.com/

The patches are as follows:

1.	Permit Tiny SRCU srcu_read_unlock() with interrupts disabled.

2.	Create an srcu_expedite_current() function.

3.	Test srcu_expedite_current().

4.	Create a DEFINE_SRCU_FAST().

5.	Make grace-period determination use ssp->srcu_reader_flavor.

6.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().

7.	Require special srcu_struct define/init for SRCU-fast readers.

8.	Make SRCU-fast readers enforce use of SRCU-fast definition/init.

9.	Update for SRCU-fast definitions and initialization.

10.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.

11.	Mark diagnostic functions as notrace.

12.	Add SRCU_READ_FLAVOR_FAST_UPDOWN CPP macro.

13.	Permit negative kvm.sh --kconfig numberic arguments.

14.	Create an SRCU-fast-updown API.

15.	Optimize SRCU-fast-updown for arm64.

16.	Make srcu{,d}_torture_init() announce the SRCU type.

Changes since v1:

o	Merge addition and testing of SRCU-fast-updown for bisectability.

https://lore.kernel.org/all/082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop/

Many of these patches were previously associated with another series
that re-implemented RCU tasks trace in terms of SRCU-fast.  This work
is being deferred pending resolution of the ARM LSE situation on the one
hand or full debugging of the all-too-clever workaround optimization on
the other.  ;-)

https://lore.kernel.org/all/7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop/

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Requirements/Requirements.rst |   33 +--
 b/Documentation/RCU/checklist.rst                        |   12 -
 b/Documentation/RCU/whatisRCU.rst                        |    3 
 b/include/linux/notifier.h                               |    2 
 b/include/linux/srcu.h                                   |   16 +
 b/include/linux/srcutiny.h                               |    1 
 b/include/linux/srcutree.h                               |    8 
 b/include/linux/tracepoint.h                             |   45 ++--
 b/include/trace/perf.h                                   |    4 
 b/include/trace/trace_events.h                           |    4 
 b/kernel/rcu/rcutorture.c                                |   12 +
 b/kernel/rcu/srcutiny.c                                  |   13 -
 b/kernel/rcu/srcutree.c                                  |   58 +++++
 b/kernel/rcu/tree.c                                      |    2 
 b/kernel/rcu/update.c                                    |    8 
 b/kernel/tracepoint.c                                    |   21 +-
 b/tools/testing/selftests/rcutorture/bin/kvm.sh          |    2 
 include/linux/srcu.h                                     |  133 ++++++++++---
 include/linux/srcutiny.h                                 |   30 ++
 include/linux/srcutree.h                                 |  152 +++++++++++----
 kernel/rcu/rcutorture.c                                  |   84 ++++++--
 kernel/rcu/srcutree.c                                    |   78 +++++++
 22 files changed, 575 insertions(+), 146 deletions(-)
