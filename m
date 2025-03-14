Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267E202C39;
	Fri, 14 Mar 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963019; cv=none; b=C+BAFMAy7DIDPgU0vu3d8gZmsIyqmOyJZhWa0LdEV9tk80+8kx5IzkqlP0FWSzD0UhR7YhrlgyH/fRiUmUgBDh2V3L6sLh3EoVsVwPRiTu5jB07KNPgj8xF8Q9mOPSZNns8FCUK2C3toMx1AFKdLeyEacrI+MmUFq6K1EhBpeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963019; c=relaxed/simple;
	bh=2ceJ30Ucuu3ZC70dVdSYC3nnStxus6Nf7//XhyNn4Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxK0zyu3KASDR9o+a/q3tg/iok4liLqd/Lpzk0ZuSvn2/mTqLZ5gYkBOR1y37BBUFnaFfkaaLrxVR29K7yqBHnzU7+OGVK7dwzBykPoNJm1jkb2gZmN8dt5MGu+rjli+eydYlhcCxNLOfiUMZfBiL9Jjs61uoV6ZTY+PRKfA0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWtqe7zt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWtqe7zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7B4C4CEE3;
	Fri, 14 Mar 2025 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963018;
	bh=2ceJ30Ucuu3ZC70dVdSYC3nnStxus6Nf7//XhyNn4Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWtqe7zt+TPZpSTxH32/i2bCY2dI0v/Af0iJyYd6LxWsiwwQi95ebYjvjKHIAN9zs
	 3IR4p1FLOfqPO0oEAX0ZsJVx8uBEz1wYVN6vroXW7cMk/qppLTTazTIcJpMqOLgNRi
	 pNZhggIjVI1HffilAmypbqfGwGC7flXrQr3SrG4V7fpRBFkR23qIijjyjreWVS3ds6
	 b+Q4p4DfsQWoT1n69KCrn3mUL44BS4zk4t8uM5qDpEX5SfnFFPG5jIpvRWXVMaPQ44
	 PBDrqACIX5JEMrE3roCfH4RNwb5ep0qc8KDVs0H1ae7ee0yptp+mmLK8qFBbppLvtm
	 V4lYk/tyUzr3Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 4/5] rcu/exp: Warn on QS requested on dying CPU
Date: Fri, 14 Mar 2025 15:36:41 +0100
Message-ID: <20250314143642.72554-5-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314143642.72554-1-frederic@kernel.org>
References: <20250314143642.72554-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not possible to send an IPI to a dying CPU that has passed the
CPUHP_TEARDOWN_CPU stage. Remaining unhandled IPIs are handled later at
CPUHP_AP_SMPCFD_DYING stage by stop machine. This is the last
opportunity for RCU exp handler to request an expedited quiescent state.
And the upcoming final context switch between stop machine and idle must
have reported the requested context switch.

Therefore, it should not be possible to observe a pending requested
expedited quiescent state when RCU finally stops watching the outgoing
CPU. Once IPIs aren't possible anymore, the QS for the target CPU will
be reported on its behalf by the RCU exp kworker.

Provide an assertion to verify those expectations.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3fe68057d8b4..79dced5fb72e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4321,6 +4321,12 @@ void rcutree_report_cpu_dead(void)
 	 * may introduce a new READ-side while it is actually off the QS masks.
 	 */
 	lockdep_assert_irqs_disabled();
+	/*
+	 * CPUHP_AP_SMPCFD_DYING was the last call for rcu_exp_handler() execution.
+	 * The requested QS must have been reported on the last context switch
+	 * from stop machine to idle.
+	 */
+	WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
-- 
2.48.1

