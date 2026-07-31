Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3A2D060D;
	Fri, 31 Jul 2026 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459448; cv=none; b=EAHUwcMmwaYn86yjDQ4WVHBkPDfitJ2o6U3XMq3xgq1TXpiCCGjfTAal96FuHNcdOeAMUNMZxCh7tN65vyE4QrJHs21e0mYr7c2R1Kd3mCLuGah5fZyAOZVUt/Q1IobqXN0lJOIVanUIa/5iAvwgZbIjuIyuVZx7my6E2m7AEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459448; c=relaxed/simple;
	bh=pzwGbimlaQbePhTgIOZiCBAE9+8ggB69QEJhW+lMzBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HphH7xBMPrXhzsWBs1vkjGczWW7+Pj5tyq66YNp5m9CyqkYGmPsw2/er6L+mscgi7/hzyYKnIeBnNyjupCOhCawyfT+emOMlDzdkIHZYiejZI2i4rm9aLi6COWzPiyb8bCUQ6VRjZCtC2iDJxFUrrzIRwNCA1bGtf/38Fh+QtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhZVnfCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhZVnfCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC951F00A3A;
	Fri, 31 Jul 2026 00:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459447;
	bh=bHXOsBuveONZJn2Jb+075EEHyCPrPcSneGeBFQRy5Gg=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=hhZVnfCZVmHDV4qqEtP7OrrVIXDdiqz/IYoMtGQbYP62RSjmHPv218FV9RGiEa3+s
	 m4gZdtTohuVRV9rbpV7xXJsOZ23OPybm0iftpSLNv9YTdTewhKl155hXaceL0kU5u1
	 6tLp4gyMEIyylEHzThMB1vkx2mg7lR63iAz7hCMCzsdsARCHK1idA63T27EN8OWY3b
	 rnjZTsMwL+fr3k++2y/Nuj6GKNT2BoxhMrDhwYPAuitLgodMd+uQ7wSxKThodaHaKv
	 ECseiZNF50uSQefusixQH3POzNVYb4UWdd3Jp42WRuSqdhcfL56yNMv+/cYEQUJYqO
	 Fd9ecNQJXcQ0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B603DCE0F69; Thu, 30 Jul 2026 17:57:26 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:57:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/12] Expediting normal RCU callbacks
Message-ID: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
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

This series advances normal RCU callbacks when an expedited RCU grace
period elapses, thus reducing memory-reclamation latency.  This allows
synchronize_rcu_expedited() to be used to speed up reclamation of
RCU-protected memory.  The series is as follows:

1.	Remove unused rdp parameter from trace_rcu_this_gp(), courtesy
	of Joel Fernandes.

2.	Rename struct rcu_gp_oldstate to rcu_gp_seq, courtesy of
	Puranjay Mohan.

3.	Add SRCU and Tasks RCU wrapper functions, courtesy of Puranjay
	Mohan.

4.	Factor out rcu_segcblist_advance_compact() helper, courtesy of
	Puranjay Mohan.

5.	Track segment grace periods with struct rcu_gp_seq, courtesy of
	Puranjay Mohan.

6.	Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited
	GPs, courtesy of Puranjay Mohan.

7.	Enable RCU callbacks to benefit from expedited grace periods,
	courtesy of Puranjay Mohan.

8.	Update comments for gp_seq and expedited GP tracking, courtesy
	of Puranjay Mohan.

9.	Wake NOCB rcuog kthreads on expedited grace period completion,
	courtesy of Puranjay Mohan.

10.	Detect expedited grace period completion in rcu_pending(),
	courtesy of Puranjay Mohan.

11.	Advance callbacks for expedited GP completion in rcu_core(),
	courtesy of Puranjay Mohan.

12.	Add concurrent expedited GP threads for callback scaling tests,
	courtesy of Puranjay Mohan.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcu_segcblist.h |    2 
 b/include/linux/rcupdate.h      |   13 ++-
 b/include/linux/rcupdate_wait.h |    2 
 b/include/linux/rcutiny.h       |   36 +++-----
 b/include/linux/rcutree.h       |   29 ++----
 b/include/trace/events/rcu.h    |    5 -
 b/kernel/rcu/rcu.h              |   13 ++-
 b/kernel/rcu/rcu_segcblist.c    |   10 ++
 b/kernel/rcu/rcu_segcblist.h    |    2 
 b/kernel/rcu/rcuscale.c         |   84 +++++++++++++++++++
 b/kernel/rcu/rcutorture.c       |   30 +++----
 b/kernel/rcu/srcutree.c         |   14 +--
 b/kernel/rcu/tasks.h            |    8 -
 b/kernel/rcu/tiny.c             |    4 
 b/kernel/rcu/tree.c             |   23 ++---
 b/kernel/rcu/tree.h             |    3 
 b/kernel/rcu/tree_exp.h         |   18 ++--
 b/kernel/rcu/tree_nocb.h        |    4 
 b/mm/slab_common.c              |    6 -
 include/linux/rcu_segcblist.h   |   14 +--
 kernel/rcu/rcu_segcblist.c      |  147 ++++++++++++++++++++++------------
 kernel/rcu/rcu_segcblist.h      |    8 -
 kernel/rcu/tree.c               |  171 +++++++++++++++++++++++++---------------
 kernel/rcu/tree_exp.h           |    2 
 kernel/rcu/tree_nocb.h          |  138 ++++++++++++++++++++++++--------
 25 files changed, 528 insertions(+), 258 deletions(-)
