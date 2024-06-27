Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D814E2F0;
	Thu, 27 Jun 2024 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487960; cv=none; b=H7bpQCIQ1oIr0vjwLZsT0XyEcYsOk0uYWaE5rYLM5OlcdD9JR5hjvE4Z4/F4PztKH4osf/m2f4VW5XlNsxdo76hkA7tKm+GRRHvp3lwUVrTvdXGvSVt2M9p/UkD890ZvNpaR+kPN482LkrOPj39VBq18/EjFPjCuy+M5XTM47/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487960; c=relaxed/simple;
	bh=+OWvDyEAjOJEtaF0XfV1bIbidjX9/4pe6n3R8+6xKAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYhSPkaef8z93FymsmpludAqzF9arqKzMzFfrlwRfuNurWWgTCBrcwGy1yohbLyFv7Xk/Yjb6y/iM8pGxKDvBO+acb2i8rJXtA7ZEG1qrBYdFMsMEpyyhtlkcMCQLgnWzkWmN7KP6FihyomWv70HmJmfnj+SwLrANDu44pt1VU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcAgABDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcAgABDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48681C2BBFC;
	Thu, 27 Jun 2024 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719487959;
	bh=+OWvDyEAjOJEtaF0XfV1bIbidjX9/4pe6n3R8+6xKAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcAgABDisu2CeFuWzt2UeC09J/nTODipIopGgk7RZD4sY6ZAScZ1KJV+/1vDWzmQ5
	 OlAdxC7XUpwqyFDSLXwvDBCEuQ/WDe2mWXiKGWbWTkyZxYfbtz/mYL0oGe3cSNVpU2
	 1gI6I7R8dIjd2+3pBu+zQB5hc7ifH1lcB/wIkOPz19oRcRjHdCoDa2ndMna3i0QFM5
	 k9IASaJQ1lKnVWLv5rOXS3LITuAEy+rOZJjIvNgptSTcVzHR8Ia8q7vJOmfbETqIL8
	 C/Hc2xHJR6200PPNz7v0M1+EidlfnprVYX5kvoP/sKahCNqix1yUtmN+29spWhb2oZ
	 iNv0BwEPGlfsg==
Date: Thu, 27 Jun 2024 13:32:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: [PATCH rcu 2/6 v2] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
Message-ID: <Zn1N1IJNsAOEPgdF@pavilion.home>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604222652.2370998-2-paulmck@kernel.org>

When the grace period kthread checks the extended quiescent state
counter of a CPU, full ordering is necessary to ensure that either:

* If the GP kthread observes the remote target in an extended quiescent
  state, then that target must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it exits that extended quiescent state.

or:

* If the GP kthread observes the remote target NOT in an extended
  quiescent state, then the target further entering in an extended
  quiescent state must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it enters that extended quiescent state.

This ordering is enforced through a full memory barrier placed right
before taking the first EQS snapshot. However this is superfluous
because the snapshot is taken while holding the target's rnp lock which
provides the necessary ordering through its chain of
smp_mb__after_unlock_lock().

Remove the needless explicit barrier before the snapshot and put a
comment about the implicit barrier newly relied upon here.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst    |  6 +++---
 kernel/rcu/tree.c                                   | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 5750f125361b..728b1e690c64 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -149,9 +149,9 @@ This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
-The grace-period kthread invokes ``rcu_dynticks_snap()`` and
-``rcu_dynticks_in_eqs_since()`` (both of which invoke
-an ``atomic_add_return()`` of zero) to detect idle CPUs.
+The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
+(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
+(both of which rely on acquire semantics) to detect idle CPUs.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b7d943e98a9a..da5718da280d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -777,7 +777,18 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
+	/*
+	 * Full ordering between remote CPU's post idle accesses and updater's
+	 * accesses prior to current GP (and also the started GP sequence number)
+	 * is enforced by rcu_seq_start() implicit barrier and even further by
+	 * smp_mb__after_unlock_lock() barriers chained all the way throughout the
+	 * rnp locking tree since rcu_gp_init() and up to the current leaf rnp
+	 * locking.
+	 *
+	 * Ordering between remote CPU's pre idle accesses and post grace period
+	 * updater's accesses is enforced by the below acquire semantic.
+	 */
+	rdp->dynticks_snap = ct_dynticks_cpu_acquire(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
-- 
2.45.2

