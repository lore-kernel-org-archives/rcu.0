Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470C235C17;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631892; cv=none; b=KW5LOMuP9XxIPEjr/MDgxvanYEsMr9NMsghvMZd+b63pqSwiyYeg2cJSgnSzcp7qt/UBEnQXSHc7/aq4SoLoUDyZESU9231e3nfrblEg4FQgvMOI6R5t7CIl7S+K0Tnb2GO8yuUuRgP5DM72AdZ5e5mFLIbjj0bnKYfcX5PaC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631892; c=relaxed/simple;
	bh=QrzgNx2Z70ZJkhKYaYpwPppmFmFzg0Cl6Eu7C/Gx3I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5IPCCSCfqcOlcRdNaFidrCBdD5B6zOTsgyiiinjc2Zzmfs1ZDuLUoZA+ygHKiToXwRikAZNqwAvsmBnmJiNqKxF7JrvxnkEHQFj+imRazlfnXnmEiXvBAbcYFi50nG4gIrtb570pUr6g6WtOklPDpnEhW3dg/larohwemWu9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWVJpd4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWVJpd4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAB9C4CEF8;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631892;
	bh=QrzgNx2Z70ZJkhKYaYpwPppmFmFzg0Cl6Eu7C/Gx3I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWVJpd4gfZAsWYAH/445Byydyr7Y6Zu/60orVuDF33qiM+GaqvOSpGD2yjXJpVXG4
	 YMSrrHgGDT/EezO81Uac7KxCAT1xn8Um8WZ2Z/J+6TP+njkDu2x+JAwO3KGwZ7a3Wo
	 n80hL4dKaSTclcHQV56praekKaUPCg4eMi9eOA2GVndB3QgVOC5LX7rmp5Lb1QJ/38
	 qqz+vfLrnVbEioKwzuYt4b+Vk4wvyXtyc9J87bmiN7ijPHN73XQbH11fX3uGKkCnQC
	 dV/RZf3D/uw+nu4gemX+UU+4o6P0oQcTJNe28E/qNqstg/1aMTz6jChnNz/3hcQVCT
	 PlEwZnNVw7qCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2F70CE1482; Mon, 10 Mar 2025 11:38:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 9/9] rcutorture: Check for ->up_read() without matching ->down_read()
Date: Mon, 10 Mar 2025 11:38:09 -0700
Message-Id: <20250310183809.3576320-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
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
 kernel/rcu/rcutorture.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fcdd6271f435c..a0786b3c223be 100644
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
@@ -2499,7 +2503,12 @@ static void rcu_torture_updown_cleanup(void)
 		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
 			continue;
 		(void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
-		WARN_ON_ONCE(rtorsup->rtorsu_inuse);
+		if (WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
+			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+			rtorsup->rtorsu_nups++;
+			smp_store_release(&rtorsup->rtorsu_inuse, false);
+		}
 
 	}
 	kfree(updownreaders);
@@ -2515,11 +2524,14 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 
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

