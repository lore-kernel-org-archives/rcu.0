Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8917736;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302920; cv=none; b=AKkhqkMo+9d6pDqc3h7PFaU6fJoNAwgumnlgqQwar7f2uyWnZTJEsNxunzkypkv+QIl0rAUqdgtbFjCKeGAPXohUKWrM28QtpkYNHz7tFwmX/YZb9ZKkJK0/06Qxgja7OtadHY3/ggor91ohj4qWvJgwN7bSBOct5oPQO/FRjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302920; c=relaxed/simple;
	bh=b9sPRChOApZiUr0xwL3sxPCf4tYxxEx0JLu49QV5rt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfnDW0dMvrVOXwaRalj2/xy+FQUZWv38EGInfwE+vVonZukxu4TBFO2jCId//yNOYZo1xZ8r/5Z/dgKfhWuYOXeKOmEd2GsUx6y1Oe+ZZ+HEJ72HZQLbYzLIlIG17asjQ9XrjOWHvqb7O0HEUZTxcxJrg96dNoKdbBCJG8g344g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjEht2Ym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjEht2Ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80C1C4CEF6;
	Sat, 16 Aug 2025 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302919;
	bh=b9sPRChOApZiUr0xwL3sxPCf4tYxxEx0JLu49QV5rt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjEht2YmaRzD/jSLcXJmNZHTn2OvZJ9Hoo1sKahpubVyFV4xUel08/lIxDCQ8cR/o
	 m3tyU7DN3yJJ9xpiCwa1ZN+6+0DJOY4SS7Y4+2WmiqcUBw4mWHCfDgBkOPjXSDo+Yr
	 cAGZbj0260gI7BPV+fBB1ELu8kbPcRIBcBtABtdcmXezRmC5WllOIQ6vA52N9MwGjw
	 wUaxxNNcB259odjHCuVYclR5o2OIUSIyFvIpJqKua9s87DGFf0jOMYFEd7waAG4Itz
	 FFohlT8DPE+xMhYyQvAuxXA2pjVR4pAbWrhe/4WIOyIU440W6h3IChv5RbW8GpWLO5
	 1xdiCHfZedwgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1D8D1CE0EA2; Fri, 15 Aug 2025 17:08:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/7] rcutorture: Delay rcutorture readers and writers until boot completes
Date: Fri, 15 Aug 2025 17:08:35 -0700
Message-Id: <20250816000837.2622858-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
References: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcutorture writers and (especially) readers are the biggest CPU
hogs of the bunch, so this commit therefore makes them wait until boot
has completed.

This makes the current setting of the boot_ended local variable dead code,
so while in the area, this commit removes that as well.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 49e048da4f6810..1578d330565752 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1528,7 +1528,7 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
 static int
 rcu_torture_writer(void *arg)
 {
-	bool boot_ended;
+	bool booting_still = false;
 	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
 	unsigned long cookie;
 	struct rcu_gp_oldstate cookie_full;
@@ -1539,6 +1539,7 @@ rcu_torture_writer(void *arg)
 	struct rcu_gp_oldstate gp_snap1_full;
 	int i;
 	int idx;
+	unsigned long j;
 	int oldnice = task_nice(current);
 	struct rcu_gp_oldstate *rgo = NULL;
 	int rgo_size = 0;
@@ -1581,6 +1582,16 @@ rcu_torture_writer(void *arg)
 			rgo_size = cur_ops->poll_active_full;
 	}
 
+	// If the system is still booting, let it finish.
+	j = jiffies;
+	while (!torture_must_stop() && !rcu_inkernel_boot_has_ended()) {
+		booting_still = true;
+		schedule_timeout_interruptible(HZ);
+	}
+	if (booting_still)
+		pr_alert("%s" TORTURE_FLAG " Waited %lu jiffies for boot to complete.\n",
+			 torture_type, jiffies - j);
+
 	do {
 		rcu_torture_writer_state = RTWS_FIXED_DELAY;
 		torture_hrtimeout_us(500, 1000, &rand);
@@ -1769,13 +1780,11 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		boot_ended = rcu_inkernel_boot_has_ended();
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
 		    !atomic_read(&rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
-		    boot_ended &&
 		    time_after(jiffies, stallsdone))
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
@@ -2437,7 +2446,8 @@ rcu_torture_reader(void *arg)
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
-		while (torture_num_online_cpus() < mynumonline && !torture_must_stop())
+		while (!torture_must_stop() &&
+		       (torture_num_online_cpus() < mynumonline || !rcu_inkernel_boot_has_ended()))
 			schedule_timeout_interruptible(HZ / 5);
 		stutter_wait("rcu_torture_reader");
 	} while (!torture_must_stop());
-- 
2.40.1

