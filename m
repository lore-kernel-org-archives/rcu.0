Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584C145A1F;
	Thu, 27 Jun 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488221; cv=none; b=Bcqsp+0HsXbSYydasTcTN5eOlj5OuPLVYtUKVACBqxXgKTCrNxDJ7KRRdW7cN1abf9taNFZECScVS4yVTDBaiIPmNOf3iP1QfER442GfUEP0jEePmAepFfjqWIqhK2h5d+xLorN5ljuKX5TWWx2JYo9G0X5tEf3nybcrgwYPpNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488221; c=relaxed/simple;
	bh=g9+JV0OyTnYbPDCsS7diUampG4fyAenIEqpuHSG0kTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1xHCIGj+5SK4Kd3Uu6d651qSr04L1DNO2tSe2XEM38rXpp2PKt4ORSFV1THmv8n02xFSTaRCWIop0qI5KdEkzhIfY6Da31BqV99Xhbi23xbIH874vjQ6RDo6azdXupWDokPMEqd5WfuH2dRKksRO4ye3OzsIVOaSedhRzbIPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRE+NORz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRE+NORz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE1C2BBFC;
	Thu, 27 Jun 2024 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719488220;
	bh=g9+JV0OyTnYbPDCsS7diUampG4fyAenIEqpuHSG0kTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRE+NORzJtd55ElcYsgfJk8zc1UWhQ1/PwbW5PnXbK10EpPesOdUb2Ll7Rg4AOlM5
	 PVcuXYUnUGzv7euon5DqetSfcqtlSHTzmpcDita8L6upWOL6jK+w8J94zzlNUowGNd
	 e/iHIZdW+OebxCAvrb/l8EArrM8bREJVrMt4YyW0LAB89slDBIOsusqPusOCtaFhf+
	 GyA5w8a1xtnXsIc3egR7VrFL2x6TmDTVriZfVnrjg3em9IMLmQJ466nAUfLgrNR0cg
	 jRu9lM3Dv3+/5Y5wQNBlTmBBX46nHxbST9/1q0qAbZzPSGGrkqoBn0J4k76EINQ/LB
	 oyOaCgdsQkb7A==
Date: Thu, 27 Jun 2024 13:36:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: [PATCH rcu 3/6 v2] rcu/exp: Remove superfluous full memory barrier
 upon first EQS snapshot
Message-ID: <Zn1O2qKaIVOXniYH@pavilion.home>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604222652.2370998-3-paulmck@kernel.org>

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
 kernel/rcu/tree_exp.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8a1d9c8bd9f7..1dbad2442e8d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -357,7 +357,21 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		    !(rnp->qsmaskinitnext & mask)) {
 			mask_ofl_test |= mask;
 		} else {
-			snap = rcu_dynticks_snap(cpu);
+			/*
+			 * Full ordering between remote CPU's post idle accesses
+			 * and updater's accesses prior to current GP (and also
+			 * the started GP sequence number) is enforced by
+			 * rcu_seq_start() implicit barrier, relayed by kworkers
+			 * locking and even further by smp_mb__after_unlock_lock()
+			 * barriers chained all the way throughout the rnp locking
+			 * tree since sync_exp_reset_tree() and up to the current
+			 * leaf rnp locking.
+			 *
+			 * Ordering between remote CPU's pre idle accesses and
+			 * post grace period updater's accesses is enforced by the
+			 * below acquire semantic.
+			 */
+			snap = ct_dynticks_cpu_acquire(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-- 
2.45.2

