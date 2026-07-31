Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D52EEE77;
	Fri, 31 Jul 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460045; cv=none; b=Ge72kGpDwrFjwyiroykFVjzyD2nbJLbnOOxC2KBmzgxZ4o8R9aiTpiz46XnLV0XCECnZvm/fnhMO+PeKEl9m885edr7mnr2D9VMoEuNKXwti4z6k5W+2WWUD23cNyGSd1POYeSsumCOuAdUMTWeFr/STJkl9lbcg0l+ljzBNW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460045; c=relaxed/simple;
	bh=5TRH08HpnQpKefliFHBcZse/jV9F6sm8wkK7QGwdEwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ug9xRhkcTk/3lDe02HONTtHG1JPigLxLeOXSYJOgHsNLJVHtVgFjSRMzKfPO2rMoVnNzHEtuQh8uN/ZBr/Z5j+h7AFWepAKmQoNbmtVu76D9Yhy6N9jtoLsZzyl/A0xQhcl9DQbFqoHqebJkc+ALmz45IBlF+rP+3CYmIlNeqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsU5mEvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsU5mEvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB601F0155A;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460041;
	bh=e8XPOoUXngqgBuzXy/XFx1AR3lM5r9CAVwZr40LUuY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsU5mEvpsvcqLfuJ+TcdpVqeKuXuJudAv+JeHtcVlpch8JurcduoB93lRVGU6dph8
	 go4pDuQomky9hjUi3guEHSz38djKWSpWKd7wPh57hcHpkin+g7eJDCRW6EdowEUOLB
	 Lt0+0uoGDSYjZQtxYaqp+502TpkwN9aUo7NYgRGRimI5u5qkXnGEz32fm2kP34fTE5
	 sA9+FOnIHjbmInfj3+0XzMwuAXDPAVvCDdfx+BaR/aFpairH3Syk9HxR6o9s4TaC6V
	 jhtJby22+7PwHo7ewnlekN/ah3XSQf/tb1WgNQdzshMM6iVhm7ZHFwRpmXKOraXLI8
	 InlA5/Y1h+agg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99849CE14DB; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 10/13] rcutorture: Use this_cpu_inc() for rcu_torture_count[] and rcu_torture_batch[]
Date: Thu, 30 Jul 2026 18:07:16 -0700
Message-Id: <20260731010719.3531912-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
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

