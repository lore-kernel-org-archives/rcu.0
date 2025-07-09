Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E72C08D1;
	Wed,  9 Jul 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058026; cv=none; b=XHCKwpG5vg+DopM5659rnyWfV9liuWsvmc8UevWqtHSVYmZb1I5HMBiDFn/9XoBoD4d/9y8w16g+Y0gFt/uwqHz+JtJN/LArrie7m8e+6wfwlUyL58h6HA/JS9o/JaDLy05aqg8CKkxkwJ7nhg+VRuvNb+k9TXoaanCbPuJVeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058026; c=relaxed/simple;
	bh=e1BHcaYIkCpx/CHPZ4PtOBHjn/DmOqQFeLNeR8CAhZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbnyTKVxx/fjqGPEMg6UcLHAI1XdyxISk7GtqlUEybeGsgqNsuQYTqd1ux8z2+5RMhFcBl5ykw2Rp5P/IRCn0KgInugJb8EZ+qVItig6xJLR7k+WMncSmDBzyuktQsou3k+mB0LJKfwKtjXafbpXUPgZf/YCUuX7U0yWo1g1Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekI3f6MO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekI3f6MO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995E5C4CEEF;
	Wed,  9 Jul 2025 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058026;
	bh=e1BHcaYIkCpx/CHPZ4PtOBHjn/DmOqQFeLNeR8CAhZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekI3f6MOrT72oUwkHmg5gafW55hBKdRwTVZPxtUWaFkH6yrkXiwzXmovAjm7u4HxD
	 Ij11IbyMPD+UFF6Ol/UFDt0aqZiOTXXpgrEItbpEyqqs1u4lzTo8C47KZ8vY9UOmpi
	 d5O+FLpu/pg48gVX4eur9g2VDJZz3TwAhyCtV73dyBQO4rYSD1zL58USxijLGiUyuj
	 N0v9FoCHxtTVgsSIo0g4s0W4ADjnNmpz6u5BYve6n64bx3W9gIJBiG5lTuwvoXbsGX
	 vbawmB7Ey1mcvkKI+/HFg4M1EQ+CAURRayoGibU965MJ6PRjaC00AtvMQ2wgDDPwH8
	 d9IAMP77Phcbg==
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
Subject: [PATCH rcu 2/2] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access
Date: Wed,  9 Jul 2025 16:16:41 +0530
Message-Id: <20250709104641.15699-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104641.15699-1-neeraj.upadhyay@kernel.org>
References: <20250709104641.15699-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

In the preparation stage of CPU online, if the corresponding
the rdp's->nocb_cb_kthread does not exist, will be created,
there is a situation where the rdp's rcuop kthreads creation fails,
and then de-offload this CPU's rdp, does not assign this CPU's
rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
rdp's->rdp_gp->nocb_gp_kthread is still valid.

This will cause the subsequent re-offload operation of this offline
CPU, which will pass the conditional check and the kthread_unpark()
will access invalid rdp's->nocb_cb_kthread pointer.

This commit therefore use rdp's->nocb_gp_kthread instead of
rdp_gp's->nocb_gp_kthread for safety check.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_nocb.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index cb29b6bb0ed4..08eb9b0e2fab 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
 static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 {
 	int wake_gp;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(cpu_online(rdp->cpu));
 	/*
@@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
+	if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
 		return -EINVAL;
 
 	pr_info("Offloading %d\n", rdp->cpu);
@@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 
 	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
 	if (wake_gp)
-		wake_up_process(rdp_gp->nocb_gp_kthread);
+		wake_up_process(rdp->nocb_gp_kthread);
 
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_nocb_rdp_offload_wait_cond(rdp));
-- 
2.40.1

