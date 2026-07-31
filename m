Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1A48986C;
	Fri, 31 Jul 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459846; cv=none; b=A6K4QqYRkbclvW0RVCbomCCK8BzQ46z71jheThIrHFSNFK8G/80rY6e0wvJYiRveUzKsk+X1OMVULCMqZV0/rK2Qd+NyxDs46fFuMHwKOETs22ZZYXUVVc0yzA5HFr86IGrYr5DGUi4px7w7dyBoCEuw6iSC7nmqXtI8PTgo6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459846; c=relaxed/simple;
	bh=5llBbBwxLKYol1TJ1pnv214WRC7ABWW8LA58eihPHbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mvh0WKd4HmhgWok5grLUeZ4JSPv8hWZMrL9qkF6GKz7F/Py0CUnxAagc6R8++T3pRrcRz2C/G5Za1EDelvFFbn1Nhu6JQ024mlVWl5DKYJDGgS8biSmk4oSFS5/UH6kYwrCo5dfVXevrBO7jVCrEBIjzc4hbzBxtB8icyx4SPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7RP3nGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7RP3nGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1841F00ADE;
	Fri, 31 Jul 2026 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459844;
	bh=JLZa/Dd+sC18+73+Ra12WgAISql/ToNz9XBkZZW556k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7RP3nGldjnT59WSYztj9OdSIIPanwiy3chCVY9CCfp2fQwd2dbIjyXrq+zMtB030
	 1ME83VmLPxJr1a7sMfj+7K91TzoAKg38VovGXQtPG4OQZOsRHO+b0e9NvHmApRWBAe
	 12Q+N+YdY8USRzoWyHogS5nx4wlSmKtovHd2SPhbehri78yItWDJ+OE0JZsiHWoCH7
	 nZHXNWX3b+3ft9R2M1hYNR8qQEaHyvOyUIXGIzfNMY5rZ6SqSBcEByttyMlNc2UCD3
	 sDH+aE8NjlPtL22AJ5QTCwfWhCYY8IT5bVXMJ4lawqXhYIHHxDs/zEOjpxkBBwL9hH
	 2I320diEt1Zyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99A60CE1059; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 07/10] rcu-tasks: Dump rtpcp->lazy_timer status in show_rcu_tasks_generic_gp_kthread()
Date: Thu, 30 Jul 2026 18:03:58 -0700
Message-Id: <20260731010401.3531631-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

Add 'P' flag to the diagnostic line to indicate whether any per-cpu
rtpcp's lazy_timer is pending.  this helps diagnose stalls where
rcu-task callbacks are queued but the kthread stay sleep because
the lazy_timer has not yet fired and no grace period has started.

The output is as follows:

[   31.319540][   T77] call_rcu_tasks() has failed boot-time tests.
[   31.320205][   T77] rcu_tasks: RTGS_WAIT_CBS(11) since 7518 g:4 i:0 kCuUP l:150000

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bc49698a3bcc14..0306a0568f0144 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -723,6 +723,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 	bool havecbs = false;
 	bool haveurgent = false;
 	bool haveurgentcbs = false;
+	bool havependtimer = false;
 
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
@@ -733,10 +734,12 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 			haveurgent = true;
 		if (!data_race(rcu_segcblist_empty(&rtpcp->cblist)) && data_race(rtpcp->urgent_gp))
 			haveurgentcbs = true;
-		if (havecbs && haveurgent && haveurgentcbs)
+		if (data_race(timer_pending(&rtpcp->lazy_timer)))
+			havependtimer = true;
+		if (havecbs && haveurgent && haveurgentcbs && havependtimer)
 			break;
 	}
-	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c%c l:%lu %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
@@ -746,6 +749,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		".C"[havecbs],
 		".u"[haveurgent],
 		".U"[haveurgentcbs],
+		".P"[havependtimer],
 		rtp->lazy_jiffies,
 		s);
 }
-- 
2.40.1

