Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A882D3208;
	Tue, 29 Apr 2025 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934201; cv=none; b=iylOWEAhUh79CH8ATe/kc44V6y9kWjtX9ffAGu8Jr2gaGb3TMBKd/J5FVWYPbvrBg4MPtptubJNQUunkRpiSoRLu0JWZhrsAhMqKcaa5mshGI2sUL83Gf7c/ghvn3RSEZXHi709d1VshLVAFIixPdQS5dGk95g38e9EhIEacbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934201; c=relaxed/simple;
	bh=JzScvX4/KWOWu92ElQeUAb8SA6xsSgfyRoCjWHokjL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrBOcO7EhdMX5Vju8ZMfnbp/mcTQcSr65xNjN6NCW1TA3uGgedN6XfveVBAKW9tSO3BRhA2BGDI/56LnOjYu01JMtKA8v83e0QokvFyNlosWdKcRKV7y4c0PImySw4yzTyl4lmeLeLfq3jEjpnegSryjlFfAgJ2O1RdB002KwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzgYMth1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzgYMth1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0596FC4CEED;
	Tue, 29 Apr 2025 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934200;
	bh=JzScvX4/KWOWu92ElQeUAb8SA6xsSgfyRoCjWHokjL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzgYMth1C/+Nvv5cWeKgVT03KJsVXSiWqXRFuHzdclSVY6CdjJMGA+TLSQhiw2vZ3
	 qjfXS0t7Bm/OpQ9ApTVzt0Cygdt1SHlLOEBTOvofDc8VC3Oth8NQ/keEu5y2m86dZh
	 9M7FMmR7mxO0+ZKcEJJHjU5PtZcvqLRdUejQC3EY4NCac/oSW82oprtlAsaMbcqXeB
	 +xcO++7KJotcWdE3bdgXwpAI4a1l/xYKlm1c8pyoTl31lEwKqfCIL1LUuBdmfJZRyK
	 1ui4AV+G59vDqIfDsIopcbyASPE8P3yhOI/6Ewe+7aUkuJLjXoOXf/t+STsr0ePp4w
	 uai3F1M6QQt1Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 4/5] rcu/exp: Warn on QS requested on dying CPU
Date: Tue, 29 Apr 2025 15:43:03 +0200
Message-ID: <20250429134304.3824863-5-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429134304.3824863-1-frederic@kernel.org>
References: <20250429134304.3824863-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not possible to send an IPI to a dying CPU that has passed the
CPUHP_TEARDOWN_CPU stage. Remaining unhandled IPIs are handled later at
CPUHP_AP_SMPCFD_DYING stage by stop machine. This is the last
opportunity for RCU exp handler to request an expedited quiescent state.
And the upcoming final context switch between stop machine and idle must
have reported the requested context switch.

Therefore, it should not be possible to observe a pending requested
expedited quiescent state when RCU finally stops watching the outgoing
CPU. Once IPIs aren't possible anymore, the QS for the target CPU will
be reported on its behalf by the RCU exp kworker.

Provide an assertion to verify those expectations.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5be292667385..e14bdbb658a9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4352,6 +4352,12 @@ void rcutree_report_cpu_dead(void)
 	 * may introduce a new READ-side while it is actually off the QS masks.
 	 */
 	lockdep_assert_irqs_disabled();
+	/*
+	 * CPUHP_AP_SMPCFD_DYING was the last call for rcu_exp_handler() execution.
+	 * The requested QS must have been reported on the last context switch
+	 * from stop machine to idle.
+	 */
+	WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
-- 
2.48.1

