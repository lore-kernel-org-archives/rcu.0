Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057C14A4C8;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447717; cv=none; b=WC5LmrHa27YLa1TdY648yz42NWXyKey30inlqRi2nG5Y9iNINjbl0i+DZevy99f4vQfMOvaFq+vyb6tsKkogTPLitqOpgjgVXLrEG/VVnooxwDQ5bX349CgFhMS2JkqM9MDMCeSW43YnBKH1RsYkKksZdwW0iiczaFwwml437S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447717; c=relaxed/simple;
	bh=Eu9iIKrUmBF+EtSklwZ4302HDaY6OtItQ7LVMVD6LIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FO1GdBLWErkblZIvbh/N0Xb+8lq9+a+/Qf1N7SDR2C/YdxJLcnlrPhQMDJVdUrXvRduObm1VKfA1kKUrH7whSFE5wCzn84dRBl9n9MKVhzj1snvzEeq00kzIkSpEkhYjo6uN4HM3Er+vjlGSdw3V4UoMrY9eBR4uQp9TCOU0qTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqkEdViH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqkEdViH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D2EC32786;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724447717;
	bh=Eu9iIKrUmBF+EtSklwZ4302HDaY6OtItQ7LVMVD6LIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqkEdViHRN3JOmr8HgG4OdQ2Occ5V8K6tjroC0/GI0g16iglsYQx34Q5F4h4Umhy2
	 kTNzx3Okkn/Kx258/OrEK2y10HUqbJRdgxVndSDyiVienTsnkYubQpfhJabUjgwn4U
	 c02VyMMSbrKOahJLshopzXZk9IgFKWgHfC39tlPS7y0qAS5Q0ZFg6ctcwnqRyWliLG
	 R6KsGtM1riQWLCqQ2qOi9nRyC4MTP/G7YPpFfWgBjKIbhXZVJ+ilAsy2xyKymvQAe4
	 X3FtMbN20NS9kMbeeioc8ilak8jihCBZCu0ONuA7cgCNfXz6+qDIcFkZ0GtNsrdCU8
	 Ba0iQeNJCLOxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 273C6CE0D9B; Fri, 23 Aug 2024 14:15:17 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	riel@surriel.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] rcu: Defer printing stall-warning backtrace when holding rcu_node lock
Date: Fri, 23 Aug 2024 14:15:12 -0700
Message-Id: <20240823211516.2984627-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <415b108b-1046-4027-aa2a-c829b77f39f6@paulmck-laptop>
References: <415b108b-1046-4027-aa2a-c829b77f39f6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_dump_cpu_stacks() holds the leaf rcu_node structure's ->lock
when dumping the stakcks of any CPUs stalling the current grace period.
This lock is held to prevent confusion that would otherwise occur when
the stalled CPU reported its quiescent state (and then went on to do
unrelated things) just as the backtrace NMI was heading towards it.

This has worked well, but on larger systems has recently been observed
to cause severe lock contention resulting in CSD-lock stalls and other
general unhappiness.

This commit therefore does printk_deferred_enter() before acquiring
the lock and printk_deferred_exit() after releasing it, thus deferring
the overhead of actually outputting the stack trace out of that lock's
critical section.

Reported-by: Rik van Riel <riel@surriel.com>
Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index cf8e5c6ed50ac..2fb40ec4b2aea 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -371,6 +371,7 @@ static void rcu_dump_cpu_stacks(void)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
+		printk_deferred_enter();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		for_each_leaf_node_possible_cpu(rnp, cpu)
 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
@@ -380,6 +381,7 @@ static void rcu_dump_cpu_stacks(void)
 					dump_cpu_task(cpu);
 			}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		printk_deferred_exit();
 	}
 }
 
-- 
2.40.1

