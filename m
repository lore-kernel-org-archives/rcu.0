Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782030D41D;
	Wed, 24 Jun 2026 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307459; cv=none; b=QpHfwSogEdMUL9946WXMBEVMegjrAT0tuXhvZFt03w8K6J+a3CBRfwT+pJvfFnEEa+2tYcNfHIKpFEmLAwjYPhw6pwcUfoN4PclaxuuzgIUQSQ3mgvO/mY/u+0qOKA++4wGBs8EWUjciOlU7FJ9HhuXqaezFZ/vG8QbNlepkbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307459; c=relaxed/simple;
	bh=7kMZupo7IDv65K43PKtvFd4PikXRf7ru6yI92rzWY80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4CWxgQZUyq+l+cNFooMnI8Ctk/w/oLRlxRYf5+fHWfXIQFZ0fEsfUu7TStsebZHh/2p5K173mwkV9fgnGK/3TOW3G9bOaJZg8fjhjhwCu9XCyuL1g/GRB6wSpevl2lCqAv5AMf24kQxQXufZersaf2ZjCDQnkTQoDsdOh4zL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRaIjndH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRaIjndH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC5D1F000E9;
	Wed, 24 Jun 2026 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307458;
	bh=6vQ3460i7ReL5VpEmvschQ402BTLfWDu49PtCv29XAw=;
	h=From:To:Cc:Subject:Date;
	b=mRaIjndHqsZch8TzXi9wDWIcRfEl985moWQ/rASfHssGvC2Ru/s6RAXHr3ol545Jk
	 y4LftCmMAI1/KZ9Qw5czF+MmetRX6t8O1GqGrogZPQ92Toh0gLTLxhDaeWCK1XBFC7
	 Osw9ax6IrK/Lfm9OcFTNpeswb0mf32UF1vJ2m732ddrEZJICa10z2Ig77AYutqwXia
	 yQrOD2yKmrkL8eIXGf4ekuC6ZkLmthjWIK+Lv4TQkFd+AnxM34GXDy+DDVZjvwMtlk
	 VDhXV5WeW+uHHpX0DsQnlClbKTLKWuI6gx5LYB/jib1iU6ZrJGvpCUDv8XjHhyNnfT
	 H/qeJCX2TbB8g==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 00/11] RCU: Enable callbacks to benefit from expedited grace periods
Date: Wed, 24 Jun 2026 06:23:42 -0700
Message-ID: <20260624132356.516959-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets call_rcu() callbacks be reclaimed as soon as either a
normal or an expedited grace period that covers them has elapsed, rather
than always waiting for a normal grace period.

Motivation
==========
Today there is an asymmetry: synchronize_rcu_expedited() callers get fast
reclaim, but call_rcu() callers never benefit from those same expedited
grace periods, even though an expedited GP proves exactly the same thing
as a normal one -- all pre-existing readers are done.  When expedited GPs
are running on the system (driven by other subsystems), call_rcu()
callbacks that could already be freed instead sit in RCU_WAIT_TAIL until
the next normal GP.  This series treats a grace period as a grace period
regardless of how it was driven, so memory is reclaimed sooner.

Design
======
Callback segments now record both the normal and expedited grace-period
sequence in struct rcu_gp_seq, and rcu_segcblist_advance() releases a
segment as soon as poll_state_synchronize_rcu_full() reports that either
has completed.  Three notification paths are taught about expedited
completion so the advance actually happens: the NOCB rcuog kthreads,
the rcu_pending() tick gate, and rcu_core().

Changelog:
RFC: https://lore.kernel.org/all/20260417231203.785172-1-puranjay@kernel.org/
Changes in v1:
 - New prep patch 1 renames struct rcu_gp_oldstate to struct rcu_gp_seq
   and its fields rgos_norm/rgos_exp to norm/exp tree-wide (Frederic).
 - The rcu_segcblist segment field stays named gp_seq; only its type
   changes (Frederic).
 - Patch 8 (NOCB wake) is reworked.  v1 woke the wrong waitqueue
   (rdp_gp->nocb_gp_wq via wake_nocb_gp() rather than the leaf
   rnp->nocb_gp_wq[] that an rcuog kthread waiting for a GP sleeps on),
   and the wait condition only checked the normal ->gp_seq.  The rcuog
   grace-period wait now tracks a struct rcu_gp_seq and is released via
   poll_state_synchronize_rcu_full(); rcu_exp_wait_wake() wakes the leaf
   node through the new rcu_nocb_exp_cleanup() (Frederic).
 - rcu_pending() uses a new memory-ordering-free
   poll_state_synchronize_rcu_full_unordered() to avoid memory barriers
   on every tick, leaving the ordering duty to rcu_core() (Frederic).

Still open: Frederic asked whether the first smp_mb() in
poll_state_synchronize_rcu_full() is needed on the callback-advance path
(patch 6).  That path still uses the fully ordered helper; only
rcu_pending() was switched to the unordered variant.  Happy to revisit.

Puranjay Mohan (11):
  rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
  rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
  rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
  rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
  rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited
    GPs
  rcu: Enable RCU callbacks to benefit from expedited grace periods
  rcu: Update comments for gp_seq and expedited GP tracking
  rcu: Wake NOCB rcuog kthreads on expedited grace period completion
  rcu: Detect expedited grace period completion in rcu_pending()
  rcu: Advance callbacks for expedited GP completion in rcu_core()
  rcuscale: Add concurrent expedited GP threads for callback scaling
    tests

 include/linux/rcu_segcblist.h |  16 ++--
 include/linux/rcupdate.h      |  13 ++-
 include/linux/rcupdate_wait.h |   2 +-
 include/linux/rcutiny.h       |  36 ++++-----
 include/linux/rcutree.h       |  29 +++----
 include/trace/events/rcu.h    |   5 +-
 kernel/rcu/rcu.h              |  13 ++-
 kernel/rcu/rcu_segcblist.c    | 139 ++++++++++++++++++++++----------
 kernel/rcu/rcu_segcblist.h    |   8 +-
 kernel/rcu/rcuscale.c         |  84 ++++++++++++++++++-
 kernel/rcu/rcutorture.c       |  30 +++----
 kernel/rcu/srcutree.c         |  14 ++--
 kernel/rcu/tasks.h            |   8 +-
 kernel/rcu/tiny.c             |   4 +-
 kernel/rcu/tree.c             | 147 ++++++++++++++++++++++------------
 kernel/rcu/tree.h             |   3 +-
 kernel/rcu/tree_exp.h         |  20 ++---
 kernel/rcu/tree_nocb.h        | 131 ++++++++++++++++++++++++------
 mm/slab_common.c              |   6 +-
 19 files changed, 496 insertions(+), 212 deletions(-)


base-commit: 709d17a22bfac78765f6cbaec42e15bcd4aa4f08
-- 
2.53.0-Meta

