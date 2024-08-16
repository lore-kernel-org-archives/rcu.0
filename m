Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C44137747;
	Fri, 16 Aug 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791053; cv=none; b=VXHcmYju4rwehhHENeFrsbdLREGsUwZKS17lPRGPCFS7noOTs/KqM/6KyivbJV71WcIYTVorWe0axRjiKPgFDipJkjoNgLjM+QH/fgDIgSEgFY3IU9fRTU9l2qSXHP5xwWgGu2ogQJGT77CvNwF6uEmk5ZFRlk+g9cfszufGccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791053; c=relaxed/simple;
	bh=Qo8iVEXOB5vQe3YYkQwY0kyj0PXdCKtErMcG9BVvOic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZB//MJCLYyxv7nbcX7ypAd8NNTKsA4XqGeSdXkncUMazrcX4ejqJyqggIds5SoVpQhyquj4cRUq0sbMkymkeX9gqYOjJBiXv41CvsqAwK6d2N6j6jFFu42KfBC0BEE02ZguKd4KSVtWiyKWeXlGYUOiyLTvEpcDgG2HWVSwoYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feyIAjIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feyIAjIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A798C4AF09;
	Fri, 16 Aug 2024 06:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791053;
	bh=Qo8iVEXOB5vQe3YYkQwY0kyj0PXdCKtErMcG9BVvOic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feyIAjIsF/8CpfxfrRKmpUs3o4VwSDpGKvURV5yqsxxeHLk337oP7ZFb1c2L0JQKE
	 xCg5kDr8EYYBZtugVQ+xiQRVIRCY4hmhiCcTH3hb0XoxkxKWFE9v2pio+02PYOPW1+
	 ZMHKhX5q/0+ZYQryJyrtvq3rFEkKoCPq+nWiPij+14vufggAfSWlXb0dmIbqcUAcbC
	 jiCaLxuWPKJETr+vflfug9RELdAh9+Ai8VtAwry6DgPiXSHVSls2TMY6p5VVWrBgya
	 ZeqJykDYOdgQwBauR/RYoGabsf4bXzOVuX3am7k2zVegoSag45LVxnPJPOyP4tdEgQ
	 OE2wZEGhOaVZg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH rcu 04/12] rcuscale: Stop testing RCU Tasks Rude asynchronous APIs
Date: Fri, 16 Aug 2024 12:19:13 +0530
Message-Id: <20240816064921.57645-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The call_rcu_tasks_rude() and rcu_barrier_tasks_rude() APIs are currently
unused.  Furthermore, the idea is to get rid of RCU Tasks Rude entirely
once all architectures have their deep-idle and entry/exit code correctly
marked as inline or noinstr.  As a step towards this goal, this commit
therefore removes these two functions from rcuscale testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index b53a9e8f5904..d534d4ec2314 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -333,8 +333,6 @@ static struct rcu_scale_ops tasks_rude_ops = {
 	.readunlock	= tasks_rude_scale_read_unlock,
 	.get_gp_seq	= rcu_no_completed,
 	.gp_diff	= rcu_seq_diff,
-	.async		= call_rcu_tasks_rude,
-	.gp_barrier	= rcu_barrier_tasks_rude,
 	.sync		= synchronize_rcu_tasks_rude,
 	.exp_sync	= synchronize_rcu_tasks_rude,
 	.rso_gp_kthread	= get_rcu_tasks_rude_gp_kthread,
-- 
2.40.1

