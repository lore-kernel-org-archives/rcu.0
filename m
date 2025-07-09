Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB282918DE;
	Wed,  9 Jul 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057794; cv=none; b=qLlTecmlric50S80VhprNumLjU9Z/vnSxbyfgx4DHDSuRleU8/iIttitKFhHC1x+3s92gFnSc49CKK9odoB6nKGXFuUmLko/T4wtsjZjtG3yZCDkoiyMFP1hCYmI+VOz7nT9n801b0hrrZdvi/FbEj3WX6itjUDIGPQRJUByLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057794; c=relaxed/simple;
	bh=SNPLFBpiKo7+F2IHAJdiaq/+KUvKNSLOdScapqS6Tis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fC7zx213YzO5dG5ORFYShl+ju6aNIXFwwB3EaAek0A42CZ+Yjet7iyJ7i+jS5qtRU32wsXvy68I8+7eU0BPqJ6RnuT+uXnRtlwt6A8nh3EiJhnVXayuhqRhlENa5kMI9hDqcko0Haal2e1xtplU1ruGuo8vmWDed3Zq2/5zU7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP00ZnQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP00ZnQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11EBC4CEEF;
	Wed,  9 Jul 2025 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057793;
	bh=SNPLFBpiKo7+F2IHAJdiaq/+KUvKNSLOdScapqS6Tis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OP00ZnQ4Wmbxivt1ptEZ0UfI2/HZRwmbw5e/0v2J3Mh738U25pqCKMTcuEHr7hUjb
	 NQ1GH9UzwVvsEVsMVwOwGSgwc63s72MbB2kRC+aJ46lXqTjj1Ieu5Y4gup1MTeVXtl
	 W+H9lNOcgGX7/rwvR2F9SJ0ocjCBgiYZ1Kk5f5o4t8H2M6a+x81PF1EuBiNhauuy6v
	 F4mfHhZbwX/gNcxyUvqTRBsvaX4im3EsYC/yZBjkNBWF7H/NgEJ651YhDnbzHm+y6F
	 /YbMwbqUVvX5ZWe0S1icRF5gsSj+mZTh0PG5KZN+2gmNwTFLSWslBmRP3DwBDMynnl
	 M5sHcn4zr/fVg==
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
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 07/15] rcutorture: Check for ->up_read() without matching ->down_read()
Date: Wed,  9 Jul 2025 16:12:07 +0530
Message-Id: <20250709104215.15562-8-neeraj.upadhyay@kernel.org>
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

This commit creates counters in the rcu_torture_one_read_state_updown
structure that check for a call to ->up_read() that lacks a matching
call to ->down_read().

While in the area, add end-of-run cleanup code that prevents calls to
rcu_torture_updown_hrt() from happening after the test has moved on.  Yes,
the srcu_barrier() at the end of the test will wait for them, but this
could result in confusing states, statistics, and diagnostic information.
So explicitly wait for them before we get to the end-of-test output.

[ paulmck: Apply kernel test robot feedback. ]
[ joel: Apply Boqun's fix for counter increment ordering. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 22288efc8c67..f773d4f8f2ae 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2449,6 +2449,8 @@ struct rcu_torture_one_read_state_updown {
 	bool rtorsu_inuse;
 	ktime_t rtorsu_kt;
 	unsigned long rtorsu_j;
+	unsigned long rtorsu_ndowns;
+	unsigned long rtorsu_nups;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2463,6 +2465,8 @@ static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
 
 	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
 	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+	rtorsup->rtorsu_nups++;
 	smp_store_release(&rtorsup->rtorsu_inuse, false);
 	return HRTIMER_NORESTART;
 }
@@ -2507,8 +2511,12 @@ static void rcu_torture_updown_cleanup(void)
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
@@ -2524,10 +2532,13 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 
 	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
 	rawidx = cur_ops->down_read();
+	rtorsup->rtorsu_ndowns++;
 	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
 	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
 	rtorsup->rtorsu_rtors.rtrsp++;
 	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
+		WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+		rtorsup->rtorsu_nups++;
 		schedule_timeout_idle(HZ);
 		return;
 	}
-- 
2.40.1

