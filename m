Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB585260;
	Fri, 16 Aug 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781175; cv=none; b=B0PwK57BjZ6hf/3DGfL6bEXEgz71Hqo4giFxLsRhaQmMKndTvzWSQLDil0xHuzVju/aNUprPAyE3jFhH7h7WZIJu71cVuPvfLHgVdcF2pUiIXIn21yjgfeb+OrEICc7UEMmBi8uxPbNudVYtwkF73HITOieOFf2xs8XC700cNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781175; c=relaxed/simple;
	bh=s/028LW28I+qDCNzGGYVqaLGBDBEMLt7vSM49+sYWOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZX8CtWfK3u2r+iE1GNhJBW2CHtxHAFiEEQYy4zBmN9SYI149LjYbSMW33jENd7Kjb0Q7czRnG9k5z5rGnM30lcfp0h8dCSY/WAiXnp3JXpGdocNlXXgEe5jQK5WjhDVnSra8yXfwqBYognPPmpPCLsSCk7ea+ddQSEtbD2h2KiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvyZn1Rl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvyZn1Rl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F61C4AF0E;
	Fri, 16 Aug 2024 04:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781174;
	bh=s/028LW28I+qDCNzGGYVqaLGBDBEMLt7vSM49+sYWOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvyZn1RlsXQ4tgOSELTS3t1dLKYvJH+zFc8TLt4lgJC1L5r7lgPAubAsDzJok6a1f
	 L3QLyXzyd0pYNJdcJsLylwU3lWVtKeJST29mT+FNo+CjjlZKZMDwzyRzWW9TXq8zkE
	 kSYrRhGF2jGTFLGPej7+RTdC667jvMlDrQ9A5miUtpIziZnEILLMzKNUlyFcDIy9L0
	 e0/EMl2UQLILp/IXJkIa7iETuwhY7ItvAhRWxiCTc9tiIJFAZhSH4kdNOz3fZgBTwy
	 aU2kb0d2LSDk1biwklFWp3Bw0JumV6BSKxl6GQ3ro0z8GFhriuGy2cUIWLZLXDZoGu
	 4xI+RBUnB232Q==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 21/26] rcu: Rename dyntick_save_progress_counter() into rcu_watching_snap_save()
Date: Fri, 16 Aug 2024 09:32:36 +0530
Message-Id: <20240816040241.17776-21-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg        | 2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg         | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg   | 2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg        | 2 +-
 kernel/rcu/tree.c                                         | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index 423df00c4df9..13956baf748a 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -528,7 +528,7 @@
        font-style="normal"
        y="-8652.5312"
        x="2466.7822"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">rcu_watching_snap_save()</text>
     <text
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
        id="text202-7-2-7-2-0"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index d82a77d03d8c..9de55fbf5be4 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -844,7 +844,7 @@
      font-style="normal"
      y="1547.8876"
      x="4417.6396"
-     xml:space="preserve">dyntick_save_progress_counter()</text>
+     xml:space="preserve">rcu_watching_snap_save()</text>
   <g
      style="fill:none;stroke-width:0.025in"
      transform="translate(6501.9719,-10685.904)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 53e0dc2a2c79..286a098b9c42 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -2974,7 +2974,7 @@
        font-style="normal"
        y="38114.047"
        x="-334.33856"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">rcu_watching_snap_save()</text>
     <g
        style="fill:none;stroke-width:0.025in"
        transform="translate(1749.9916,25880.249)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
index 4fa7506082bf..bab69a15c9c2 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
@@ -516,7 +516,7 @@
        font-style="normal"
        y="-8652.5312"
        x="2466.7822"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">rcu_watching_snap_save()</text>
     <text
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
        id="text202-7-2-7-2-0"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a969d8ddc58e..93039414733a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -776,11 +776,11 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 }
 
 /*
- * Snapshot the specified CPU's dynticks counter so that we can later
+ * Snapshot the specified CPU's RCU_WATCHING counter so that we can later
  * credit them with an implicit quiescent state.  Return 1 if this CPU
  * is in dynticks idle mode, which is an extended quiescent state.
  */
-static int dyntick_save_progress_counter(struct rcu_data *rdp)
+static int rcu_watching_snap_save(struct rcu_data *rdp)
 {
 	/*
 	 * Full ordering between remote CPU's post idle accesses and updater's
@@ -805,7 +805,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 /*
  * Returns positive if the specified CPU has passed through a quiescent state
  * by virtue of being in or having passed through an dynticks idle state since
- * the last call to dyntick_save_progress_counter() for this same CPU, or by
+ * the last call to rcu_watching_snap_save() for this same CPU, or by
  * virtue of having been offline.
  *
  * Returns negative if the specified CPU needs a force resched.
@@ -1995,7 +1995,7 @@ static void rcu_gp_fqs(bool first_time)
 
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
-		force_qs_rnp(dyntick_save_progress_counter);
+		force_qs_rnp(rcu_watching_snap_save);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
 		force_qs_rnp(rcu_implicit_dynticks_qs);
-- 
2.40.1

