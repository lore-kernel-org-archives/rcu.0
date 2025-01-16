Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF422FACD;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=eoKVHMhBMCF0wbEJ4EY6mmK+zcrkbhcensWdrbRpDo1XuAdBkFr9hi+Y+VLx5eyZzG7fQTKBzegbCUD/5SIFomsrwLhj+3YmmA5XKSDAAC759SFxilAj0eneO+/XJxv2CcfCaF8vRQiLfQG+F2tSCFVlmNeClnpo2ilTFlRLDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=h7UaYb14hxuWlBGdYH1/6Ho7xR5oRrUYUhDJkEaVBH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxiIA02Tn+XuxNKcQ6/jtccyf19J9txRVo05C3GH6h7MO7YSOwULikM2La4gYnXcpXHWRJNbQINbImKZGd2sadYSWKIxL4gucBxQCO06TRfruCXRac+I44kS5HOyg3xyihn51QUeA9dHAix93WtmYqNgCEVUuJwZvEFbp9BU+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+w/JRJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+w/JRJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E945C4CEDD;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058409;
	bh=h7UaYb14hxuWlBGdYH1/6Ho7xR5oRrUYUhDJkEaVBH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+w/JRJhEln/T2a1R34CUiY94csoGwVS7GAMoAKe7bxjKrwE7XmBoXgsdb00JL/vr
	 WjinbS19FsBT/osxApckOUsBADtwu+Td1ok/FkYswuk0pPr+goIqkxKlPtK5TrsKyU
	 dbsWoHkbAvJXb1iFeF7yglvlQe4+4mi572OBJYNeSgkVa/49k0dvXKbJLY7Doq5XIY
	 2tMdWh+DbfRVWQ+QKG3QDnC8uzVx6ciUXDA8ePACc7n088jZIirl/x1wBH+M38UsAm
	 So+KWmNKV+rJzWgtoTFSJ5ccpycEgX3u9Hi2JIoi/ZD089CzJMg9LsVujoOov3onJT
	 iudcOkXJgnuYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F1E8CE37B4; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/9] sched: update __cond_resched comment about RCU quiescent states
Date: Thu, 16 Jan 2025 12:13:21 -0800
Message-Id: <20250116201327.3782963-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

Update comment in __cond_resched() clarifying how urgently needed
quiescent state are provided.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a5190..b0f7ffcc46a66 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7281,7 +7281,7 @@ int __sched __cond_resched(void)
 		return 1;
 	}
 	/*
-	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * In PREEMPT_RCU kernels, ->rcu_read_lock_nesting tells the tick
 	 * whether the current CPU is in an RCU read-side critical section,
 	 * so the tick can report quiescent states even for CPUs looping
 	 * in kernel context.  In contrast, in non-preemptible kernels,
@@ -7290,6 +7290,8 @@ int __sched __cond_resched(void)
 	 * RCU quiescent state.  Therefore, the following code causes
 	 * cond_resched() to report a quiescent state, but only when RCU
 	 * is in urgent need of one.
+	 * A third case, preemptible, but non-PREEMPT_RCU provides for
+	 * urgently needed quiescent states via rcu_flavor_sched_clock_irq().
 	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
-- 
2.40.1

