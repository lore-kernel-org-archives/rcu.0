Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321A19F462;
	Thu, 12 Dec 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029401; cv=none; b=gcLndafEJmkeFvo4oJtTSSUJzoP2CCLVlX3QJ7o5XtHhVNxUiMKC602or5SaF4D/yRrAQcEi6/yoiaOSfgPcvqPGcYke8FjEtsS0M2lb6EujA35SUt/wAFpcmPeQ7MxNt4kh78ouojiGDfxg97FlYm5KhDci90nds7sdmZqTwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029401; c=relaxed/simple;
	bh=GghhS7nJXir3DyfOrcVtzmcjB+1jZq2oIKrPvYNKecI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTQgDWkESntNDAdydWx3tSK6HroPLUX31er7YgkFp5RCYy7bDtgq68ngTpPO1sPovVNzwwgRRra0Ux9tG8KUMozu+BW+JwQKmb5gJfERgW43WnzyrXtK20yz2RrC8HA+5yTcVcvIbD5ZAfBlBLLnXcaDUzbfQAbSKXNDOKD1q/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcHtjmHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcHtjmHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D3DC4CEF5;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=GghhS7nJXir3DyfOrcVtzmcjB+1jZq2oIKrPvYNKecI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcHtjmHv6fFMUtRWd6sl2NoSvatJMFaIlUZQDs5PpynB0J1MWwvPF5dqekkxSN1Iw
	 1jJudlB8uw51Q6xSuBjh9Y6E1IkKqxx3QL5an0KS7y72uRmoSP0NQnTWHo+Cn3PtoS
	 Uyx66sLDJcQlEeD1IWH9G3ldAZWGRfm2n3y338GQtm1egpryxDEWU5cBaZjsEpwR9W
	 hxOK96wbbu4L9yHfxsrlPLGAkOEmmiTOnuYV3HN/zaVV2zknrws0diYOnwcQkcdWN5
	 MPlR0N5bunJysiZ4zMhjMbN7XPxxsYrngHoM2jPX/zS3jEvJuBCrsrBw/+5x7RIe+g
	 XKBZNZam3VJ6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E0871CE15A5; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 17/18] rcutorture: Add per-reader-segment preemption diagnostics
Date: Thu, 12 Dec 2024 10:49:56 -0800
Message-Id: <20241212184957.2127441-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For preemptible RCU, this commit adds an indication for each
reader segments to whether the rcu_torture_reader() task was
on the ->blkd_tasks lists, though only in kernels built with
CONFIG_RCU_TORTURE_TEST_LOG_CPU=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ab354bb7f1b68..41b661bf000a7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -464,10 +464,8 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 		rtrsp->rt_delay_us = shortdelay_us;
 	}
 	if (!preempt_count() &&
-	    !(torture_random(rrsp) % (nrealreaders * 500))) {
+	    !(torture_random(rrsp) % (nrealreaders * 500)))
 		torture_preempt_schedule();  /* QS only if preemptible. */
-		rtrsp->rt_preempted = true;
-	}
 }
 
 static void rcu_torture_read_unlock(int idx)
@@ -1961,8 +1959,11 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
 		int cpu = raw_smp_processor_id();
 		rtrsp->rt_cpu = cpu;
-		if (!first)
+		if (!first) {
 			rtrsp[-1].rt_end_cpu = cpu;
+			if (cur_ops->reader_blocked)
+				rtrsp[-1].rt_preempted = cur_ops->reader_blocked();
+		}
 	}
 
 	/*
-- 
2.40.1

