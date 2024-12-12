Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B191ABECA;
	Thu, 12 Dec 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029488; cv=none; b=Qh08vunu7uRBNtyLmak9FxmgocUmF7iToHgjbUOnPPB54uMr+D/JyAPCRkfGkIGBoMmgpmDYTeQNJQgjKNjheoL9huW514yRuZMXf6hBzJsIhGRod3SUxxvN9c1bbaKj8rCUgZOOZHFSata9snQ3eWCHYm+yp5t4DNsLMEN1KnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029488; c=relaxed/simple;
	bh=gqxisnv0SFoQNhSBdAUzLSQ+6u7ZhkbzFupLt3evPrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9bEmH7YUbJOeFjlxnuVa15nv9aNXHWodM/6G7d8CPC3lxZogMWg9k3zaETfXxGMTvY9SM9IVDx0i93lAnQywCgMaJp9sXvcgVETgFcTasUI1MdhKossSs6gNyAaLmhsK1cBFOk5JQMbTi8b1sOznrC7Z4txBOGYj1xO361DAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI8N1JzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI8N1JzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12244C4CED3;
	Thu, 12 Dec 2024 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029488;
	bh=gqxisnv0SFoQNhSBdAUzLSQ+6u7ZhkbzFupLt3evPrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sI8N1JzHB1gjKaUMNLXY5kJWkdc3efR5qvdqhDuVHIDndi1GRObGSVThbo3sfzCHV
	 fhS+/sx2D8+CMJ3kRZJ+CVGjhQuxN3SmOqUIuQd7pvhuwYwyyq+rA9OQdsOMIxBRHb
	 qzqx8reKkQmxENaTDjuvso04uqb0P1C9/pp6oyZ7413Yc/Y0HheCohQlTeTEO5HgDI
	 swt8tuB/UIrTzPwSz712aVlDKpHSRPFP/2xxPzM/RebPvJbQqSQEThLWVCfar3FsZC
	 MgJQ5XbhCCYknpHP4FAQYmvFkP8rMK53+dVUSB5zJ/Fb8zpu+EAJF8jbTJZdxzDPG5
	 5FI3m54nTg3aQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C66D3CE0F9A; Thu, 12 Dec 2024 10:51:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Feng Lee <379943137@qq.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/3] srcu: Remove redundant GP sequence checks in srcu_funnel_gp_start
Date: Thu, 12 Dec 2024 10:51:26 -0800
Message-Id: <20241212185126.2193701-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c330fdd2-91b6-42f4-b28e-cf35dfd165b7@paulmck-laptop>
References: <c330fdd2-91b6-42f4-b28e-cf35dfd165b7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Lee <379943137@qq.com>

We will perform GP sequence checking at the beginning of srcu_gp_start,
thus making it safe to remove duplicate GP sequence checks prior to
calling srcu_gp_start.

Signed-off-by: Feng Lee <379943137@qq.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 26ef58b481aae..b83c74c4dcc0d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1077,7 +1077,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	/* If grace period not already in progress, start it. */
 	if (!WARN_ON_ONCE(rcu_seq_done(&sup->srcu_gp_seq, s)) &&
 	    rcu_seq_state(sup->srcu_gp_seq) == SRCU_STATE_IDLE) {
-		WARN_ON_ONCE(ULONG_CMP_GE(sup->srcu_gp_seq, sup->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
 
 		// And how can that list_add() in the "else" clause
-- 
2.40.1

