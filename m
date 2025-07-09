Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BF28DB5D;
	Wed,  9 Jul 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057799; cv=none; b=f+qzLwRWa5/xFrka2OQ5O9TzvXqp8cdihdeXtjeV1kUG2xINx2kFpvMV0wDoCNUxU+/vxGx9hkaZzNjPY5uTE6h9CY30d0zuvb8IcU3olFRTMi/Xch0QNKCUibrS59AUnq8piaMJgHanGaUCN7/FSPAtGMBJK4ulsW8yFc4hfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057799; c=relaxed/simple;
	bh=6qbMqWsJuVvvTWS+gO5LrsfTdlSB6Hd/6dmtTEFxq1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmh+ZSNGcq1ixGYuoUcr43aA0dX2sQfdykaf64eU6eVUKZlJPybn33SRfXbPZzhnNMlD2BkyvVYnKYozPNDy096+IYWzDOfIVVYAJqHu+bynmru6BXKst9LgA1KPv92e+r6ff5G2lPoAiXrFFlzPnfpMSLPq7U+nWxGQH/6EsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+oAG77J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+oAG77J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC77C4CEEF;
	Wed,  9 Jul 2025 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057799;
	bh=6qbMqWsJuVvvTWS+gO5LrsfTdlSB6Hd/6dmtTEFxq1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+oAG77JmwfOmK7IRxWVcaSrZQkGT6KydkHcPzp9W1X2dYdc4UXUy1TKjlBiu6N5p
	 dB/fpKXugYnN5ARG67To28K+FK8q9anHg2DWFqgYvv7IQAoUce1pUT/Wn5Cw1F9Y4S
	 dtmRwvL1wtVxMt7GPOmoa8ZHbnMgdfN4BymRxQc1/+xPX+IDxoVlpaY3VWrP7buQen
	 5+AxKP2GVBVImdrziQkCIZSkJab6JDGqUQcZcjYkAeB50OBz54sCsV2CA6ZIX9fdYC
	 ZPhpAFnpuf4qweDkGgr2lyyL3rSOEsTzW2ctSGAY+9OXKx8+C2oonbCErOhhYFA9UD
	 UcX7mex8U2OKQ==
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
Subject: [PATCH rcu 08/15] rcutorture: Check for no up/down readers at task level
Date: Wed,  9 Jul 2025 16:12:08 +0530
Message-Id: <20250709104215.15562-9-neeraj.upadhyay@kernel.org>
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

The design of testing of up/down readers such as srcu_down_read()
and srcu_up_read() assumes that these are tested only by the
rcu_torture_updown() kthread, and never by the rcu_torture_reader()
kthread.  Because we all know which road is paved with good intentions,
this commit adds WARN_ON_ONCE() to verify that things are going to plan.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f773d4f8f2ae..10f3cc4861ee 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2232,6 +2232,7 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
 	i = ((i | (i >> 3)) & RCUTORTURE_RDR_MAX_LOOPS) + 1;
 	for (j = 0; j < i; j++) {
 		mask = rcutorture_extend_mask(*readstate, trsp);
+		WARN_ON_ONCE(mask & RCUTORTURE_RDR_UPDOWN);
 		rcutorture_one_extend(readstate, mask, insoftirq, trsp, &rtrsp[j]);
 	}
 	return &rtrsp[j];
@@ -2368,6 +2369,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	WARN_ON_ONCE(!rcu_is_watching());
 	init_rcu_torture_one_read_state(&rtors, trsp);
 	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
+	WARN_ON_ONCE(newstate & RCUTORTURE_RDR_UPDOWN);
 	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
 	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
 		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
-- 
2.40.1

