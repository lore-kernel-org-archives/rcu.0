Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDC14C5AA;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540014; cv=none; b=SIaUXBEBghiO62S+nhqkoVVKcVxt7g2wjB8IYyJZsDco9/Qufx7yTe+vNCAA0C46vQ3rM6nvHlVdQakZnaH1KpWpMgBb4s+USnF8l3U9f7+jPDJI9qy9xZG2y8ZAMEe2V8Ek5EMGh3+Q/Ef3u8FXoeXW859hXwXjBdWXPcFFtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540014; c=relaxed/simple;
	bh=d/J2eAs8W8ieRKshFNI5ALv15WcIcn5ewASod+OGMGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtXcpDQUcmC4VZvCYJog7jqYxZAyipOUbmT3ubvHyG/hkPPxLmM8klMma6QblUVcOCBATloJad2413RZi2BPvfrnvvEVCgyvYhI30ijNU80r7kRjK4A43EQ71Q6SK0KW4iFSBbeuroCp1PvgtN33/ZbuwkEQR2unEkamLoJZgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9JSUeq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9JSUeq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6781CC4AF0C;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540014;
	bh=d/J2eAs8W8ieRKshFNI5ALv15WcIcn5ewASod+OGMGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9JSUeq9wRJSr8RmfHHb9fWhqMY2YPWhkA8E/eH1+KJVOHnbxiPj1Ek6WIk0V5cpR
	 WNLWhbSEGI4wWoxUeRpeP3/vemriELGexloi1rnC0VFq/IgMxf9BJb8dskLbjBQBaS
	 sitqP6m3kH2MDNL2OE4XaL7wJSUPbovbWFjYhzi205elMvZBnqVgZZ8j0zA4jdr8s2
	 FrZdteoodqUbbQYyJcDGwBBUAdYv9nRPLoSf0Ke0VSA1V1PoLgMaStW7YVmpG1Piiz
	 mcMU3cB8SOQf/0NbOGp0cr3hrFSkUGPkjCotD4z5Hde7nuJne0RqwDbpW5b6LQdUqG
	 vJel83o6uMfuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01FC7CE3F2C; Tue,  4 Jun 2024 15:26:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] rcu: Remove full memory barrier on RCU stall printout
Date: Tue,  4 Jun 2024 15:26:51 -0700
Message-Id: <20240604222652.2370998-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

RCU stall printout fetches the EQS state of a CPU with a preceding full
memory barrier. However there is nothing to order this read against at
this debugging stage. It is inherently racy when performed remotely.

Do a plain read instead.

This was the last user of rcu_dynticks_snap().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 10 ----------
 kernel/rcu/tree_stall.h |  4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fa6d2b557d6c..db9ca6c0c9b30 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -295,16 +295,6 @@ static void rcu_dynticks_eqs_online(void)
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
index 460efecd077be..4b0e9d7c4c68e 100644
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
2.40.1

