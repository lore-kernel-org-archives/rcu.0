Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301B21B9E3;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=jqbVas16FwIisvWjMapbCymR7keWbJn9tSpMaeWvrl+s4k4fzCxto1psxoNZpML40cypc3EVA9wrSIIxHc7a54ZvD+JiRij9lTb11enem5D/YLdOy9LDSDxszraw9xlb98nJYNJ7MDUNaM5v4rxKMom0DAtIl/npp2BgN1QRJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=gTAZic+ReLagLKWgSKVMUdp+ApS8LL65gzQ81QuWoXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfpMryg8jSXp/4PtW10uxLNAf3sF/7dRJwpA7Wv9HgSOz0YtjhB2Cv/8A+VT0ZcdErtz5W3xyOCK9K4wlxVwOjgZZRdQrebK2CFz7UYDUaOwCKEX/V8/EWn2CqyS0iQ9Wv/tjeEsV1H5waBLi5VkQz4metXM2iuVPqWsJO6k88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe/Mi4ST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe/Mi4ST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E265CC4CEEB;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=gTAZic+ReLagLKWgSKVMUdp+ApS8LL65gzQ81QuWoXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oe/Mi4STr6zlGzc12tva8g859DU2hH75JR2FS6nI+p2xSox3/n0P9CLGEfQtBuv8Z
	 8v7Ys/1/htvRnrD8l9jsKWtMYT8+ua4PhBCU7e0lhmO0vTaWbnbi1zwbabjjmweBj6
	 z1Q/xjH+KFSI7hpE/DktXoM5DPCn+p8sEjzHihTtciQ18nzzIk7dKyHbwT6sKkXLHj
	 ErBZvZBpXqgRP0XecEkrdvpl84sHGna79Hx2q8eoHxbC0PyZZSMUYyIHVzlkzHfZoh
	 FpUdTrhdav17o8pi9B7NEUYVn9TOzhHeF24hK1gM5JW3ivt3zm80VvRaZmU9/jclmJ
	 4LGCg1AcHwdRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 390A4CE1311; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 09/12] rcutorture: Check for ->up_read() without matching ->down_read()
Date: Mon, 31 Mar 2025 14:03:11 -0700
Message-Id: <20250331210314.590622-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit creates counters in the rcu_torture_one_read_state_updown
structure that check for a call to ->up_read() that lacks a matching
call to ->down_read().

While in the area, add end-of-run cleanup code that prevents calls to
rcu_torture_updown_hrt() from happening after the test has moved on.  Yes,
the srcu_barrier() at the end of the test will wait for them, but this
could result in confusing states, statistics, and diagnostic information.
So explicitly wait for them before we get to the end-of-test output.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
---
 kernel/rcu/rcutorture.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d2728e95a69b1..079e164c85a16 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2439,6 +2439,8 @@ struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
 	unsigned long rtorsu_j;
+	unsigned long rtorsu_ndowns;
+	unsigned long rtorsu_nups;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2453,6 +2455,8 @@ static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
 
 	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
 	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+	rtorsup->rtorsu_nups++;
 	smp_store_release(&rtorsup->rtorsu_inuse, false);
 	return HRTIMER_NORESTART;
 }
@@ -2498,8 +2502,12 @@ static void rcu_torture_updown_cleanup(void)
 	for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
 			continue;
-		if (!hrtimer_cancel(&rtorsup->rtorsu_hrt))
-			WARN_ON_ONCE(rtorsup->rtorsu_inuse);
+		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
+			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+			rtorsup->rtorsu_nups++;
+			smp_store_release(&rtorsup->rtorsu_inuse, false);
+		}
 
 	}
 	kfree(updownreaders);
@@ -2515,11 +2523,14 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 
 	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
 	rawidx = cur_ops->down_read();
+	rtorsup->rtorsu_ndowns++;
 	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
 	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
 	rtorsup->rtorsu_rtors.rtrsp++;
 	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
 		cur_ops->up_read(rawidx);
+		rtorsup->rtorsu_nups++;
+		WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
 		schedule_timeout_idle(HZ);
 		return;
 	}
-- 
2.40.1

