Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585C20513B;
	Wed,  6 Nov 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908955; cv=none; b=o0zof2dR9+8uV7qKMHU19reswJefeq1t6GFtMBwMN+a+5KL7j0vEqKZGF21SoOLBL81DiBZLPdOX6ACGjGePfa52uy5Us77O6mvo1zZmzv4gUGIXnPapl9W815YyF08pup/rDbK/kQw7UQGPBuqZKs+2okqf8PfeGIKOXvKDtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908955; c=relaxed/simple;
	bh=6zHhX5oEUV07uCHmS2wHkHIVA45QcuRfPVXY/4+AqIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofwN0R/ICjTmxR4mZybupYrK96ZxxrnfwU13jejcxE06AD9QDZpIuFgctGVohSkozxzGtMYKAWIvcjFtuj9kMQyJbBNGHUrNHd6Ufqvga/MPRZ1+pSC6T8xDAwUM5rHee5HW9bZh44rSwqb0yVh3vwzL1n4iMKPKMNKRbLCJiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLgv/L4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLgv/L4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07225C4CEC6;
	Wed,  6 Nov 2024 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908955;
	bh=6zHhX5oEUV07uCHmS2wHkHIVA45QcuRfPVXY/4+AqIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLgv/L4cQ/MT+RuGQb6RC0ySq7ycR/3QqC4MO00q4nHebaneyMBP5UlMkhmLvvySh
	 jVgcV9ac2xhR804X12jaDBI4a/kLIHRfTxFfAjQNccLSB/ViOGPPJyyz2LP7c5EECm
	 WhK9NnK+Ojw/u8Atb6uqScuBEcZWMNPXlXjEoyNyWxG9LtOes0A5PkO/oZpO8Q+KeT
	 PJqEgMcV1LqQczEVb/U7B/j09GTmEVsH6u401hXJTAaSDaydjsbcjhojGj8EDU4s/Q
	 oEiavRCR09EQgTjJryajExQTBFdcV4giENRsmpDEAffPNBjpZiIFC5772qQn6FCGLq
	 nGtdwASCRyCQA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/6] refscale: Correct affinity check
Date: Wed,  6 Nov 2024 17:02:19 +0100
Message-ID: <20241106160223.42119-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106160223.42119-1-frederic@kernel.org>
References: <20241106160223.42119-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The current affinity check works fine until there are more reader
processes than CPUs, at which point the affinity check is looking for
non-existent CPUs.  This commit therefore applies the same modulus to
the check as is present in the set_cpus_allowed_ptr() call.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 0db9db73f57f..25910ebe95c0 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -829,7 +829,7 @@ ref_scale_reader(void *arg)
 		goto end;
 
 	// Make sure that the CPU is affinitized appropriately during testing.
-	WARN_ON_ONCE(raw_smp_processor_id() != me);
+	WARN_ON_ONCE(raw_smp_processor_id() != me % nr_cpu_ids);
 
 	WRITE_ONCE(rt->start_reader, 0);
 	if (!atomic_dec_return(&n_started))
-- 
2.46.0

