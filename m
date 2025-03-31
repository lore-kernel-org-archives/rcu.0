Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A521C9E0;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=lr+0nvSlcQAmqMMHfkqFuiaE5ccbc3CjCteasoXEc5698FLFlFCvfwW1o+nmg5Sew6cxF4Av1sbruljmuMK645msHohzikkRknh0PJD69czXYvX4D5vEToKXjsGV9IDkgl2cJQlBBzHO/rjrl0jpSTduT7OwdNNGKqRjd6hLkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=zAxLHrj5ynpEb7swglRSR0yWaTaNYTdq/FpancJFEO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=maFAIP7BUNMligJ46BgvWhUcubTgEZJMRSzjNP4HMrT7mApfhcC9If7HZfiRIoBgh1admk5mye4J8we5NrDuHDrACc+TqKwMSt6xsnqW7WnHAs6M0bmOeYl/iWOWbi0w5V1w2cYJJjFOm3EPhG2ym7h8ZqQ2e1/hABCfJ6D7BCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0lS0Kw8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0lS0Kw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63C3C4CEF4;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=zAxLHrj5ynpEb7swglRSR0yWaTaNYTdq/FpancJFEO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0lS0Kw8hYcJamCQawQXyarCiLNmu+tBQKRSQ+aVO5Kml6jRfmIniSuawnIi6n+N6
	 81kVSJKtm3VS8lvkhTOqa+BstEpC0UY4ZQ3kTriYxslpq9I2rF9hKN/CJiHMpTAH2x
	 n1nCdTmbxGMDZO7Vxsa+JSGu+YAyoUyHuYoxj26anxkmwQlh9aOhyWOst6xfkYosbJ
	 et038JDBLe5BYkdbxp8w8Y9ZX8jbyddy11hoMf2SL95HjDEUPxGPBTu4QAejAhtuef
	 lxdvEBuvijj/HH3Y+1ZCEirbDJRmqwHNLD0w59oi07eFGtKzO6qcl6yg1V7jBTnW8W
	 09cunOc3bWuAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36562CE130F; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 08/12] rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
Date: Mon, 31 Mar 2025 14:03:10 -0700
Message-Id: <20250331210314.590622-8-paulmck@kernel.org>
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

The down/up SRCU reader testing uses an hrtimer handler to exit the SRCU
read-side critical section.  This might be delayed, and if delayed for
too long, it can prevent the rcutorture run from completing.  This commit
therefore complains if the hrtimer handler is delayed for more than
ten seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ea40f3ad32dc2..d2728e95a69b1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2438,6 +2438,7 @@ rcu_torture_reader(void *arg)
 struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
+	unsigned long rtorsu_j;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2522,6 +2523,7 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 		schedule_timeout_idle(HZ);
 		return;
 	}
+	rtorsup->rtorsu_j = jiffies;
 	smp_store_release(&rtorsup->rtorsu_inuse, true);
 	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
 	if (t < 10 * 1000)
@@ -2544,8 +2546,10 @@ rcu_torture_updown(void *arg)
 		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 			if (torture_must_stop())
 				break;
-			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse)) {
+				WARN_ON_ONCE(time_after(jiffies, rtorsup->rtorsu_j + 10 * HZ));
 				continue;
+			}
 			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
-- 
2.40.1

