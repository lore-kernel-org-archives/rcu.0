Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA35205ABF;
	Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375105; cv=none; b=Nz8l4DxWJcoo0CLNsgS6Lli8K6obteqoOp6tzyJXT6rWiVjPopK5aIesM7e7/2+wieoBk3Tb/EAjanwdEXOaKRp/7qC8lPJBn+MvhnP8UcZsLftJSrM4efcClB/F2TDkio19QC+16QLg4kygGBGyfrLKSTZh5rBPGbpCqoptQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375105; c=relaxed/simple;
	bh=QYsZv/IYpEobJEvqATWqh2kv3A3XK8nogTl6lynsHwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQjJqn8VaTV8ppRfK5v2ikB7DO7fPopeEYAj0oqWtxcuaG5jaFWb5jPZIrFSs9Wza+QzAFYShaui6lX6jkfzjZBGxc1cOLRC4CGqrQo03+k+ytaVLUAmnk+XCOXGUn+wnyuOAiNse/BcSYvRUxGqIwQACnx9rhr3d5H2m9Xr4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9ideWVA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9ideWVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C38C4CECF;
	Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731375105;
	bh=QYsZv/IYpEobJEvqATWqh2kv3A3XK8nogTl6lynsHwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9ideWVAj+QEnCQikWVK34pz64e5HcUo6BtxwdLYSyJtzRmhsUVzYIpfLMzIMpKEd
	 ismKT27ypW2PcYJ2haLLculposdkCpbQwLC4f4YNU4xgiakTZzEIzpxwlbXomSGyMS
	 L250Ou/S4sPg181Ilq9unzDkXdP9pfubI5C/X3t9tSpiFRzgaS2H4eYTHwueW7xS7y
	 7jIM/LWlrLLKFwJfQ4k/kadj8ws4B0UIK7yNZ+AqVw07N/u3vZsu4PUCxtWFkRG2PV
	 L2rw6T3poEURM20YT0R/L3But/LWfmri9rw/Hdt+6bKyW3SXQqpDHVCwv9HxU+8WtW
	 Z70N2DMBZLHJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BD0CACE0BC4; Mon, 11 Nov 2024 17:31:44 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	frederic@kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH rcu 2/3] srcu: Check for srcu_read_lock_lite() across all CPUs
Date: Mon, 11 Nov 2024 17:31:42 -0800
Message-Id: <20241112013143.1926484-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
References: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If srcu_read_lock_lite() is used on a given srcu_struct structure, then
the grace-period processing must to synchronize_rcu() instead of smp_mb()
between the scans of the ->srcu_unlock_count[] and ->srcu_lock_count[]
counters.  Currently, it does that by testing the SRCU_READ_FLAVOR_LITE
bit of the ->srcu_reader_flavor mask, which works well.  But only if
the CPU running that srcu_struct structure's grace period has previously
executed srcu_read_lock_lite(), which might not be the case, especially
just after that srcu_struct structure has been created and initialized.

This commit therefore updates the srcu_readers_unlock_idx() function
to OR together the ->srcu_reader_flavor masks from all CPUs, and
then make the srcu_readers_active_idx_check() function that test the
SRCU_READ_FLAVOR_LITE bit in the resulting mask.

Note that the srcu_readers_unlock_idx() function is already scanning all
the CPUs to sum up the ->srcu_unlock_count[] fields and that this is on
the grace-period slow path, hence no concerns about the small amount of
extra work.

Reported-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Closes: https://lore.kernel.org/all/d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com/
Fixes: c0f08d6b5a61 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 70979f294768c..5991381b44383 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -458,7 +458,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
  * Returns approximate total of the readers' ->srcu_unlock_count[] values
  * for the rank of per-CPU counters specified by idx.
  */
-static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
+static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, unsigned long *rdm)
 {
 	int cpu;
 	unsigned long mask = 0;
@@ -468,11 +468,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
 		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
-		if (IS_ENABLED(CONFIG_PROVE_RCU))
-			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
+		mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
 		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
+	*rdm = mask;
 	return sum;
 }
 
@@ -482,10 +482,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
  */
 static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 {
-	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
+	unsigned long rdm;
 	unsigned long unlocks;
 
-	unlocks = srcu_readers_unlock_idx(ssp, idx);
+	unlocks = srcu_readers_unlock_idx(ssp, idx, &rdm);
+	bool did_gp = !!(rdm & SRCU_READ_FLAVOR_LITE);
 
 	/*
 	 * Make sure that a lock is always counted if the corresponding
-- 
2.40.1

