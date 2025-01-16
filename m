Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308622FDF6;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057945; cv=none; b=r7i4p9/vrSwlhxeBDcTFXD28nlIQwHwo/ZqLsM3ZoMl3ec1g8U8Zh/cZHYrNT6thmcKe+c7NX1lsheM1vqQPrHEHCnpuj+fom79/woGI1aVeMw5QJEeWw0D+egAuUBKmOV5VM2gEJf0p8hJDHgWxse+ZBAjKlAa/7FkBXsG1Nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057945; c=relaxed/simple;
	bh=xMr7OA3HqbZQZeURX+525+rWHcKLudpdVYa2A5sHf0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPw9iG3O6TI1qEjpErOgttmtAnkG3p4Tay2U0c9jx0Y6xdWXj3CxAfyoi4MvduqJbTsyKDWLOHC/NxnyeI4QspSuxJdGx3GVo+2wsOTa+7m/qUflMBDB0tjFuEdAZ6dUlmG4NX1b05A0fUuCdLCmHcvt8oBYwQHwwcy3X55IxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs5l+RAZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs5l+RAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DABC4CEDD;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057945;
	bh=xMr7OA3HqbZQZeURX+525+rWHcKLudpdVYa2A5sHf0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bs5l+RAZopTZpiC8d8/4xfY0KXCLGWWWcFOIqBcdbbxsgh1KKo8yD1m1TzXo0nvvD
	 1ScqVlVqW0YitdL3AM9WWcUm+htiq5CZ+HpISKowRQFa3HKzpxvJ2WCdBh3WczYYq5
	 GQ9jQSg6s62rARYiBNEczUly1KFKOllLGiHT2JQRc9W9ndIavmqlt4uDLQhcCnG1g9
	 t2XOlimUS+e2Dqj1MDQeXdN64ufKai0xaPLgQbUD4eHequWbtEtItc1ZCrECbeE/s7
	 7mkGKy5FlZWT9Nsq2JAaoiWTwNHC+gy4urtT5mGzknQE90fiamXxgOJCFxJ2kniThw
	 +rpRT2RwHHAJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04816CE12BE; Thu, 16 Jan 2025 12:05:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zilin Guan <zilinguan811@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()
Date: Thu, 16 Jan 2025 12:05:40 -0800
Message-Id: <20250116200543.3782539-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
References: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zilin Guan <zilinguan811@gmail.com>

There is one access to the per-CPU rdp->gpwrap field in the
__note_gp_changes() function that does not use READ_ONCE(), but all other
accesses do use READ_ONCE().  When using the 8*TREE03 and CONFIG_NR_CPUS=8
configuration, KCSAN found no data races at that point.  This is because
all calls to __note_gp_changes() hold rnp->lock, which excludes writes
to the rdp->gpwrap fields for all CPUs associated with that same leaf
rcu_node structure.

This commit therefore removes READ_ONCE() from rdp->gpwrap accesses
within the __note_gp_changes() function.

Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 229f427b8c821..e49bcb86b6d3c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1275,7 +1275,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
@@ -1289,7 +1289,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		/*
 		 * If the current grace period is waiting for this CPU,
 		 * set up to detect a quiescent state, otherwise don't
@@ -1304,7 +1304,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
 		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
-	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
+	if (IS_ENABLED(CONFIG_PROVE_RCU) && rdp->gpwrap)
 		WRITE_ONCE(rdp->last_sched_clock, jiffies);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
-- 
2.40.1

