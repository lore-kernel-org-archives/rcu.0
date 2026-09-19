Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0113101D8;
	Sat, 19 Sep 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778114; cv=none; b=gljAUyYPaYOaxtXS12pgHz5ntV08g5RvbdEq2epHKs585kQEhW/Fqmx7SZjzios3ubMzzG52LCheuCQBH2ZLf8ApkAZNZP9lbHmlGWCKinGhY044KLOIcVySnUryZxZ8RxRM5f4bFxTeroJrjUggTdjCfvuxazhqP8z4unWVCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778114; c=relaxed/simple;
	bh=vWIvb4XF8mr7GwYptM6XwG0sBqSghzqv1F+qPzxE+ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m7s4fe32pqppwy1Z3Jfg6KNZrwT9n71URvWhSD1WYEQd1CTNR92mCZbrNz1hS9NdLw7b0R/UrBXgAqCN/bZSRpvUrquL6CtS4RA0VD8hS0Cw3N8uI3JJwoc5LJ2FvfFsgygCZwBLqXZhST8eksjap3OE3I1JmkIXOFasaGA97NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHtVVtxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHtVVtxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05171F000FF;
	Sat, 19 Sep 2026 00:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778105;
	bh=txfbQ6G1UbZFdrauIIgcWgHl7qpwJAF/s8HYGpLGWWo=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=BHtVVtxCnCIMQuJFu0QdADBmx2/5fl+UcMYRq27dOt2tFQxX1/6Ig5N3mfU3xhI4s
	 8U60OUE100kNbTufclu7I6gTeHtt85M2B9JMvxvsybvr85wTVENzlUZQwUobH0NRSl
	 DT5jFXdYE8z4qEoGn+rfX4VAeH74WwWf9Vopj1lIllH4+0OrZgOVMjpID3u+JYP14M
	 jfpnfhdxEQjI0JjLNzSiQijBjfsgo/RsKjqtykLKI407G8QNMmAg6BKcXdv9qs9km2
	 PO2WPlCl8cuPv4hKatPzdlLvZCJCg/rbnwNrUDeFN0YN1Oucyg9s9r/Q8qYU78lKtH
	 wlAGzwVmA77UA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73B00CE1775; Fri, 18 Sep 2026 17:35:05 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:35:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/19] Add atomic SRCU
Message-ID: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
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

This series adds an atomic SRCU and some additional adjustments:

1.	Make a Tiny SRCU grace period imply an RCU grace period.

2.	Suppress srcu_advance_state() mutex_lock in atomic.

3.	Suppress to-big transition for atomic SRCU.

4.	Add an atomic Tree SRCU.

5.	Add an atomic Tiny SRCU.

6.	Add support for testing synchronize_srcu_atomic().

7.	Disable preemption across synchronize_srcu_atomic().

8.	Use IRQ_WORK_INIT_HARD for srcu's irq_work, courtesy of Sebastian
	Andrzej Siewior.

9.	Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct(),
	courtesy of Sunho Park.

10.	Warn if Tiny SRCU readers are preempted.

11.	Explicitly note DEFINE_SRCU() needs for srcu_barrier().

12.	Add atomic-SRCU support to torture.sh, courtesy of Kunwu Chan.

13.	Add reader-free fastpath to synchronize_srcu_atomic(), courtesy
	of Kunwu Chan.

14.	Skip callback scheduling for atomic SRCU grace periods, courtesy
	of Kunwu Chan.

15.	Remove srcu_barrier() sleep for atomic SRCU, courtesy of Kunwu
	Chan.

16.	Restrict atomic-SRCU non_block annotation to task context,
	courtesy of Kunwu Chan.

17.	Make init_srcu_struct_atomic() prevent transition to big,
	courtesy of Kunwu Chan.

18.	Don't transition atomic SRCU to big in srcu_gp_end(), courtesy
	of Kunwu Chan.

19.	Skip torture to-big transition for atomic SRCU, courtesy of
	Kunwu Chan.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h                              |   81 +++++
 b/include/linux/srcutiny.h                          |    6 
 b/include/linux/srcutree.h                          |    9 
 b/kernel/rcu/rcutorture.c                           |   46 ++-
 b/kernel/rcu/srcutiny.c                             |    2 
 b/kernel/rcu/srcutree.c                             |   23 +
 b/tools/testing/selftests/rcutorture/bin/torture.sh |   24 +
 include/linux/srcu.h                                |   10 
 include/linux/srcutree.h                            |    6 
 kernel/rcu/srcutiny.c                               |   87 ++++++
 kernel/rcu/srcutree.c                               |  285 +++++++++++++++++---
 11 files changed, 511 insertions(+), 68 deletions(-)
