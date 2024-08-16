Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4584DF8;
	Fri, 16 Aug 2024 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789575; cv=none; b=QQvBTvp3WVr2a7HCe8+obdhi9poXV1rzoViZc4AUGshlfNNmWSLPoeLLIyLhlTdG6Ce8o55rXCq+nGB/Wpq8Tw0+ZNS0qxyOKbj2gJzRLJWU4NMsgTsGJVIwuDQowB5GE7I6BQn57Z8HIZrN7eb9NrdJ8WZCFraHxafb028xciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789575; c=relaxed/simple;
	bh=AlqWkw/2JMAlkwmyJf8Pc8RsnoA/o6Fq3Kq4FPM4U5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q15vuIwPx7zvRw0rvPAOs14t69JZtufjbbO3TEKBMUV2aWCl30B4VMZLoe39f8it5DfgdLjs+Hf0bxQCFcJ2Rmh4GSOkrJ567HYlM5Z6n8MtWNF8Ijcs+Djd1EBKKamdrdrCpYjGQM/gY0sC6aHpk35x9bwO64E5gVWMI7JzPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEw3yFh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEw3yFh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13510C4AF0F;
	Fri, 16 Aug 2024 06:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723789574;
	bh=AlqWkw/2JMAlkwmyJf8Pc8RsnoA/o6Fq3Kq4FPM4U5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEw3yFh7pxuvjza8cAH+szYzMC9+gafSUrHu/U3V6LeFgYY3rEhzsXIwPfgNx+3zY
	 Ytu0ootI3Sjkc5Qvy8dp9sb/6c2GaP+HVtKZxpEPdMIqLJiUjFnIbfgaffhnqZtFFI
	 iw/Q2abWdATx+cq4Y4XtqfARQNCntZLYEuNNYj4UkNlRwn+xGCgsooPfDsCGuSNqbT
	 6rzjmirg+LjrJlWoGeW2hbPoJJjur9gE23+AE6plgpLIeaxiOx8R5dxocBZ6HbqCOn
	 UwQqYbaLUuzsHxmZVg8yWjBPFBkO/BXFEn1udF0Jz2Jiyyah5xoBaKjmCI5CyMtG0b
	 wMJRR7fSOG99A==
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
	frederic@kernel.org
Subject: [PATCH rcu 3/3] srcu: Mark callbacks not currently participating in barrier operation
Date: Fri, 16 Aug 2024 11:55:32 +0530
Message-Id: <20240816062532.51893-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816062445.GA51253@neeraj.linux>
References: <20240816062445.GA51253@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

SRCU keeps a count of the number of callbacks that the current
srcu_barrier() is waiting on, but there is currently no easy way to
work out which callback is stuck.  One way to do this is to mark idle
SRCU-barrier callbacks by making the ->next pointer point to the callback
itself, and this commit does just that.

Later commits will use this for debug output.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index aaee09a6748c..31706e3293bc 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -137,6 +137,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 		sdp->srcu_cblist_invoking = false;
 		sdp->srcu_gp_seq_needed = ssp->srcu_sup->srcu_gp_seq;
 		sdp->srcu_gp_seq_needed_exp = ssp->srcu_sup->srcu_gp_seq;
+		sdp->srcu_barrier_head.next = &sdp->srcu_barrier_head;
 		sdp->mynode = NULL;
 		sdp->cpu = cpu;
 		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
@@ -1562,6 +1563,7 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
 	struct srcu_data *sdp;
 	struct srcu_struct *ssp;
 
+	rhp->next = rhp; // Mark the callback as having been invoked.
 	sdp = container_of(rhp, struct srcu_data, srcu_barrier_head);
 	ssp = sdp->ssp;
 	if (atomic_dec_and_test(&ssp->srcu_sup->srcu_barrier_cpu_cnt))
-- 
2.40.1

