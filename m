Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A5192B81;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=tnyt0dAPHr9hlpyC11Nmiiccy0nDR5NiY/SlVj2r5vfb2rzb/62OlQtzStDrQddna5HzfwrAITNLK55tCBPRsyuil0yykVv8ERIXvmpshSQhAnLR3xi4EiB511H+aV50SC4ShFjo4PBjslKKTu67lkrp1fjPuX/4rUJcqA+8gp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=2Lx4yyF9T7WYi8pwj0diBRfCKm7e6c3pIx6k+wIPZwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rEeJYSULlOo3i5LkJTVyd3TsOkJv9YuL7/Cfnj4eN7HlpIHX75XONKdn1xjKK704oTJ7PXFkF7Pd151oa2DB/P8hxLA0vUbJm7ou0zD/7KGSJr3h2qA4JKVwENifaywxErVSaSNBsGKqB4C6YxFFJab8xlTZ9HWeGLK7N6DAYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBVwtMLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBVwtMLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882C0C4CEE6;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=2Lx4yyF9T7WYi8pwj0diBRfCKm7e6c3pIx6k+wIPZwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBVwtMLZro5+Vv+VqAPQe+Ux9DRPOxo6CYK17zxnZB8ec048QOXehb4j2FzjD63S0
	 ypcoj8Hs14ndymmJXv/8Qq2d4g3CV5rZbdUPvRy2ujZnOFSEh8Uw8g5tg9jldw9Ttp
	 2LSbZOwpCS/L/itRQhJUz2Hvb41E0a1FSo2Clu65Yb0tGnsykQw5UpL9bF4lEDRpM6
	 gI0Gj3dUAoe70d27kVdK61cH/k1243MbNNSXbJh8f0qa6mRYdiZEchfE00j5F89Ynh
	 MItxSSGMyXJCC0qL53wJAn+qfHmRnoKyEPHFYJOxuGcb6sMTtDRAvtcdknZqWvLoXg
	 y+55p4W3UzFVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD518CE1107; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 10/18] rcutorture: Pretty-print rcutorture reader segments
Date: Thu, 12 Dec 2024 10:49:49 -0800
Message-Id: <20241212184957.2127441-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current "Failure/close-call rcutorture reader segments" output is
good and sufficient, but annoying when you have to interpret several
tens of them after an all-night rcutorture run.  This commit therefore
makes them a bit more human-readable.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 81b3743f81dca..c875e7239ae7d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3560,25 +3560,39 @@ rcu_torture_cleanup(void)
 			pr_alert("\t: No segments recorded!!!\n");
 		firsttime = 1;
 		for (i = 0; i < rt_read_nsegs; i++) {
-			pr_alert("\t%d: %#x ", i, err_segs[i].rt_readstate);
+			pr_alert("\t%d: %#4x", i, err_segs[i].rt_readstate);
 			if (err_segs[i].rt_delay_jiffies != 0) {
 				pr_cont("%s%ldjiffies", firsttime ? "" : "+",
 					err_segs[i].rt_delay_jiffies);
 				firsttime = 0;
 			}
+			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
+				pr_cont(" CPU %-2d", err_segs[i].rt_cpu);
 			if (err_segs[i].rt_delay_ms != 0) {
-				pr_cont("%s%ldms", firsttime ? "" : "+",
+				pr_cont(" %s%ldms", firsttime ? "" : "+",
 					err_segs[i].rt_delay_ms);
 				firsttime = 0;
 			}
 			if (err_segs[i].rt_delay_us != 0) {
-				pr_cont("%s%ldus", firsttime ? "" : "+",
+				pr_cont(" %s%ldus", firsttime ? "" : "+",
 					err_segs[i].rt_delay_us);
 				firsttime = 0;
 			}
-			pr_cont("%s", err_segs[i].rt_preempted ? "preempted" : "");
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
-				pr_cont(" CPU %d", err_segs[i].rt_cpu);
+			pr_cont("%s", err_segs[i].rt_preempted ? " preempted" : "");
+			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_BH)
+				pr_cont(" BH");
+			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_IRQ)
+				pr_cont(" IRQ");
+			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_PREEMPT)
+				pr_cont(" PREEMPT");
+			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RBH)
+				pr_cont(" RBH");
+			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_SCHED)
+				pr_cont(" SCHED");
+			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RCU_1)
+				pr_cont(" RCU_1");
+			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RCU_2)
+				pr_cont(" RCU_2");
 			pr_cont("\n");
 
 		}
-- 
2.40.1

