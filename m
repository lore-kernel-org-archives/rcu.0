Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3D129E94;
	Wed, 15 May 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777630; cv=none; b=hdZVnz4m72XBGr+kYTVJeC62+hk7BCRti17glPgJmgL1O9CgssekZSahaxxonZP3QRRUdMxdKb6tTVoHWPaBYVu4AJT3tQGlZQDu4u1AO+pgr5SuEeu9t7zMzlyNvDv/1/sfwuucilOVqGZMVqARuHx8PKzXzlgWSw5TKVLN+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777630; c=relaxed/simple;
	bh=ZmJO5xL9+txZPsu8NViNS/0QQGVmcC4U2pZPeVVIfOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxWDE2zAN92O2FSQAwSGTXPTKqOsrBsBpKdQXVZ9CEOsxew4zag0rmTN6fO9P/9JJpAFx+cpsJTgA0Q1AMMkcxxEDqQg9fMu0SvZ6vDOqZvKZMG1aikLUKvLkhnXceyxxdcJYS9dMgAMbBojS9WSEVC+3ho9ehrBIswet7U0mkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGVsu+3a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGVsu+3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55B4C32786;
	Wed, 15 May 2024 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715777629;
	bh=ZmJO5xL9+txZPsu8NViNS/0QQGVmcC4U2pZPeVVIfOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGVsu+3aCsyIiOIlpkiLdzOCbGYk+LDkdxQARmQngQjluzIT1ZYkSkojMP/KrlHNi
	 ednrGvwKygBLy6+AAo0p+q0a5cIo6yr19B8aUa7b5WTohhobDRxa/HKdDWhCdH2J/y
	 W+4kNqnCVb+qhRReQbnrQb+sgKaqz4JknqWHSODNdpFWMnm2B7vmMJ2YecUfrapFyX
	 3fwqs28mthSsiytsrBtGGsBcEOXGDRw3dc+MogW/UNNGgJQ9vZLrHUfen5P6MFI2Kd
	 yWT3Kh+IbQ/v0C5CbxygM/taJdJgy2XNt6HP/OK/W9CdzknjbMdoTpx2yhoTHTh7O9
	 Stl2xck+TGX3A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 5/6] rcu: Remove full memory barrier on RCU stall printout
Date: Wed, 15 May 2024 14:53:31 +0200
Message-ID: <20240515125332.9306-6-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515125332.9306-1-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU stall printout fetches the EQS state of a CPU with a preceding full
memory barrier. However there is nothing to order this read against at
this debugging stage. It is inherently racy when performed remotely.

Do a plain read instead.

This was the last user of rcu_dynticks_snap().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c       | 10 ----------
 kernel/rcu/tree_stall.h |  4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 02f6f3483482..04dde7473613 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -299,16 +299,6 @@ static void rcu_dynticks_eqs_online(void)
 	ct_state_inc(RCU_DYNTICKS_IDX);
 }
 
-/*
- * Snapshot the ->dynticks counter with full ordering so as to allow
- * stable comparison of this counter with past and future snapshots.
- */
-static int rcu_dynticks_snap(int cpu)
-{
-	smp_mb();  // Fundamental RCU ordering guarantee.
-	return ct_dynticks_cpu_acquire(cpu);
-}
-
 /*
  * Return true if the snapshot returned from rcu_dynticks_snap()
  * indicates that RCU is in an extended quiescent state.
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 460efecd077b..4b0e9d7c4c68 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
+			rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		// Print signed value, as negative values indicate a probable bug.
@@ -515,7 +515,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       rcu_dynticks_snap(cpu) & 0xffff,
+	       ct_dynticks_cpu(cpu) & 0xffff,
 	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.44.0

