Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3A2C028F;
	Thu, 16 Jul 2026 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161531; cv=none; b=ftbDuBw7YoCt21/5+jhEtUPQq20nEk4Os5Lq9aVeWTSvfv6g+lM3het6ZIIpqXdpWTBiwvgL+jhqBf+9bRkVnxkd9ACod10Nsxlut3qr9LuJ+UE9A2Z5XyqFUTPUNVYGOxXVQyx/xP/XI/XrHFE2y3DHijNXMyj3pyLi17AOgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161531; c=relaxed/simple;
	bh=5TRH08HpnQpKefliFHBcZse/jV9F6sm8wkK7QGwdEwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arLvxTXGFg8bl6RU79OG65owj+Ggw7aamZvRwfTdN5cR3gUuU3A7gVdiMc5RXVtvGmD8SdwL4vopLXVu33LySzdjIL3tNRBJnjr1+3pkjOGGONsF4csWph253AB/JIdCpS9CzD7DCAuVYNN2v917N55nsmQwta2KUcfize8ZJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmP4Wtj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmP4Wtj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1011F01559;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161523;
	bh=e8XPOoUXngqgBuzXy/XFx1AR3lM5r9CAVwZr40LUuY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hmP4Wtj8ai4zKr7Mky+15dV+y0X7AtLz0BT2nUgJtAx5YCyBUoz5IHlkCwfr3n19h
	 ON8Fud1G347Jcy3SEvUS0r19v7OpnMU9rk7fjVuqztYmT8Hn5wCnGHYxXGi+PExPVR
	 h4eJEsRSwEHBWkpRNN3Dz/FjBDezSh7KsPXlC+GFVY3qWq0W7wmdvJnbT0hhGZbzvp
	 suMq9UjO6AAwsDXk7bRnv6fyAG0YZRdmsaurRtnjMmlnvaL74IdrmVTZx+Qln0eIYt
	 cAzYhdCuR8tIZiyV05n0ZswriWmVI+e6o9uVEHyXHTGm1sWf9PRoJRXWC1pIzzopyS
	 sGv0lSM7usRIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88B48CE0E8B; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 11/11] rcutorture: Use this_cpu_inc() for rcu_torture_count[] and rcu_torture_batch[]
Date: Wed, 15 Jul 2026 17:25:20 -0700
Message-Id: <20260716002520.11895-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
References: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently __this_cpu_inc() is used to increment elements of both
the rcu_torture_count[] and rcu_torture_batch[] arrays.  However,
this can fail when the increments can happen in interrupt handlers,
as recently became possible.  This commit therefore upgrades the uses
of __this_cpu_inc() to the interrupt-safe this_cpu_inc().

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8514fef3ec10b6..9180016d87c0ce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2565,13 +2565,13 @@ static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
 					  rtorsp->ts, rtorsp->started, completed);
 		rcu_ftrace_dump(DUMP_ALL);
 	}
-	__this_cpu_inc(rcu_torture_count[pipe_count]);
+	this_cpu_inc(rcu_torture_count[pipe_count]);
 	completed = rcutorture_seq_diff(completed, rtorsp->started);
 	if (completed > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		completed = RCU_TORTURE_PIPE_LEN;
 	}
-	__this_cpu_inc(rcu_torture_batch[completed]);
+	this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
 	if (rtorsp->checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-- 
2.40.1

