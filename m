Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83250233D64;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747904; cv=none; b=E+SJLnix+MUORNQJVOiWik8UKfofPy9NRV3i+clZLqVrF8DsAP5ePJHoUoKCwzwyFc17kNOp0mQDRDVZfJsmI1ijFthG+krdCj4u/ex3zwDMrvM6Gd4/4K1LUIFKV957TotfYCbfb82Fkml2d5CHvRerf5uXJcTkMdf9Y0LEH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747904; c=relaxed/simple;
	bh=wjmsx2LsnelLdH4TKcVqs8egjrClA+QsGvFK5jj/1bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8yY3YU65Ecr5kPKLN4cnKg6SDiOuyUhcXKm+4k9Ite5+IX9xQ1PwHtbBFBcOhwT4iILWEgkE4RtkZtR58jGFr2UVcChh1az79hzqtlSkbuVogW15znEWC/VgArwzzKNX+M80Ce4wgt1Hhy5lsPRxlZwTNSM6DD/R0Q8ERQ7mtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZLcWfKt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZLcWfKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EED9C4CEEE;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747904;
	bh=wjmsx2LsnelLdH4TKcVqs8egjrClA+QsGvFK5jj/1bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZLcWfKtbg2U5TR32eUtMOVbGysa8lPQ/814+NucwLCsbLOKIiLr0rohen99x3nZu
	 7eIN8TUFPq+yKJY9aapEQwn83U4P1BA8gmtGi8hNZ0dgv+sL0sS4BYhwqBDW1E2XfZ
	 FoQUtBrCP3KyPo6NUsJEdlnQHM8ihz7G8ybK2EG1Gyn9L0cCLIOxpaDyQH3XPtnJZ2
	 /StrT+rkajelXRMqLAFbTbreXgvylBZbON6SpD5XOUUGnzA9rLK9C2PhkFaivt1T9r
	 LcCONDMViYjesXO+mAgJxL29RreTFDrBYfLpCfWFRQ2Pgt+maZMagaiYDu3DBnPYED
	 xhRwiTwlTxrbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B525ACE11D4; Thu,  8 May 2025 16:45:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/5] rcutorture: Check for no up/down readers at task level
Date: Thu,  8 May 2025 16:45:00 -0700
Message-Id: <20250508234502.1996788-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
References: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The design of testing of up/down readers such as srcu_down_read()
and srcu_up_read() assumes that these are tested only by the
rcu_torture_updown() kthread, and never by the rcu_torture_reader()
kthread.  Because we all know which road is paved with good intentions,
this commit adds WARN_ON_ONCE() to verify that things are going to plan.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 21ff365fca5d9..d94b24f19cf59 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2231,6 +2231,7 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
 	i = ((i | (i >> 3)) & RCUTORTURE_RDR_MAX_LOOPS) + 1;
 	for (j = 0; j < i; j++) {
 		mask = rcutorture_extend_mask(*readstate, trsp);
+		WARN_ON_ONCE(mask & RCUTORTURE_RDR_UPDOWN);
 		rcutorture_one_extend(readstate, mask, insoftirq, trsp, &rtrsp[j]);
 	}
 	return &rtrsp[j];
@@ -2367,6 +2368,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	WARN_ON_ONCE(!rcu_is_watching());
 	init_rcu_torture_one_read_state(&rtors, trsp);
 	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
+	WARN_ON_ONCE(newstate & RCUTORTURE_RDR_UPDOWN);
 	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
 	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
 		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
-- 
2.40.1

