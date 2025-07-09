Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72D290D94;
	Wed,  9 Jul 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057780; cv=none; b=IwkQpfV8YKSEUcjHQp/OTr8ZL+DaQpWZ0RH6kHpjFqqGPxA8Sfv6W37xdpQK/MBwIadiNQxFprfOS9lvKodFfyysCa8QrfVGsGW5/VMWKyTs72oIInxBCVf7+dXcK5j6h2+B3rH25gmYL1yvA1AvfUyCj+vyeQfGx3sHmKfuPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057780; c=relaxed/simple;
	bh=TfM5r+t9W543sU7xGWHEO3cseVE1ObpCWpbwoWQe2rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyvZNMH4slUCLwnGgVVt/Ru25t6R+8QnKxFef+DTvBlXLUTlByfanwwGNSfMBTCnGIfFX+xZYSTKszmwcFTHS5Ua9HGPLiwB7cNwKYpNCCHZOKi6JuWexp5hbXyGcbX4s44gpDAWmrGx9lNi3F87+jbItDh5byxuhvW+TTae3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lliWGBG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lliWGBG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D60C4CEEF;
	Wed,  9 Jul 2025 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057780;
	bh=TfM5r+t9W543sU7xGWHEO3cseVE1ObpCWpbwoWQe2rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lliWGBG/IAfEXuxRZXPO1z+qWbqIRx/kqy1stM3Su8siZkXQu9KQ9J5VDV7HbYkhz
	 Ca4iZm1BfmvhBILl7rK62Ujp+KvSu+B+eg3a1pwDi+QV2jxP9O8D7WEtStjJgVQ0iW
	 B0qlbLR9eV/deX04RR2teMbSsEaqsbnvnrAl5PUmVemy1iXZHKWCYCViyDsOn1jivb
	 MbrvBvNN1IMt6KKM7fzeGnYUcDbTbyNC4WRtry8eRWBLnNul5ySrxA28pkeWyb9fDc
	 mHpyea/n8dFuDZcsrJU1m/wavsrCbhZwGoCvvziK7RYkXeB19XfxmWUtz2wtCf4fCT
	 PfoNz30hgPWBA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 05/15] rcutorture: Pull rcu_torture_updown() loop body into new function
Date: Wed,  9 Jul 2025 16:12:05 +0530
Message-Id: <20250709104215.15562-6-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This is strictly a code-movement commit, pulling that part of
the rcu_torture_updown() function's loop body that processes
one rcu_torture_one_read_state_updown structure into a new
rcu_torture_updown_one() function.  The checks for the end of the
torture test and the current structure being in use remain in the
rcu_torture_updown() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 44 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bf87c0c4e77e..13cf0e472868 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2513,6 +2513,29 @@ static void rcu_torture_updown_cleanup(void)
 	updownreaders = NULL;
 }
 
+// Do one reader for rcu_torture_updown().
+static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rtorsup)
+{
+	int idx;
+	int rawidx;
+	ktime_t t;
+
+	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
+	rawidx = cur_ops->down_read();
+	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
+	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
+	rtorsup->rtorsu_rtors.rtrsp++;
+	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
+		schedule_timeout_idle(HZ);
+		return;
+	}
+	smp_store_release(&rtorsup->rtorsu_inuse, true);
+	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
+	if (t < 10 * 1000)
+		t = 200 * 1000 * 1000;
+	hrtimer_start(&rtorsup->rtorsu_hrt, t, HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+}
+
 /*
  * RCU torture up/down reader kthread, starting RCU readers in kthread
  * context and ending them in hrtimer handlers.  Otherwise similar to
@@ -2521,10 +2544,7 @@ static void rcu_torture_updown_cleanup(void)
 static int
 rcu_torture_updown(void *arg)
 {
-	int idx;
-	int rawidx;
 	struct rcu_torture_one_read_state_updown *rtorsup;
-	ktime_t t;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
 	do {
@@ -2533,23 +2553,7 @@ rcu_torture_updown(void *arg)
 				break;
 			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
 				continue;
-			init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors,
-							&rtorsup->rtorsu_trs);
-			rawidx = cur_ops->down_read();
-			idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
-			rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
-			rtorsup->rtorsu_rtors.rtrsp++;
-			if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors,
-							&rtorsup->rtorsu_trs, -1)) {
-				schedule_timeout_idle(HZ);
-				continue;
-			}
-			smp_store_release(&rtorsup->rtorsu_inuse, true);
-			t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
-			if (t < 10 * 1000)
-				t = 200 * 1000 * 1000;
-			hrtimer_start(&rtorsup->rtorsu_hrt, t,
-				      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
 		stutter_wait("rcu_torture_updown");
-- 
2.40.1

