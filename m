Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB978B4C;
	Fri, 16 Aug 2024 04:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781064; cv=none; b=LYac1xyVtPkjBUdsq9o4MfF9U5CZKo/WOKi/kpmxOd1vPSZTflH/tP2fSkzsRQuXkivQCSEMs0Fmq+i2QnOyDN1BSvZDi8YZVZhvdd38yfEhHj78EVHimSN+lm4iFDvGH1c2uRVKkesqPMLa+8cf+HCk2Z5UjKtN/7l11S6sL2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781064; c=relaxed/simple;
	bh=ft6U4z6A+mqbAhVQaGYeAhHApoONNXfw6evxiIkMcp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LyhCiiP13vP7dqeioiNhu5zONtxOxdqPwpKI/Rg7ZN5/1Z+x33nS1z/oTSm/LCRiMeCU279L7HAK0526m3idOfe9Jy+gVRl0sFx8SCseYQjbzHtiIJ0uTBGc8R3QLMhS1ADa3N3MZO7gAKD6ToH/gUZyNnyqTvx0u9zCSfAXQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvw9TnEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvw9TnEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBA0C4AF0B;
	Fri, 16 Aug 2024 04:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781064;
	bh=ft6U4z6A+mqbAhVQaGYeAhHApoONNXfw6evxiIkMcp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvw9TnEOTpzob4x8jpuEwk8hhEXeNFd0RDpPM/9wdZ92gmoL4TMzZkiKz9Di/IVca
	 pQEbv/g+Q6b//912E9rCP4JVeBotjKzyZcUs/9T7TTajskczsroGDo2x2ar6iqcUtv
	 9kL1Piak0pqza1/ZXWTF+GJJwiBkzs+ScG0xqwayhrEYm67JVgLgkj/D6VMQwfzYWp
	 HhQaKvyh+CDzz/x/ySl4eOQgcWv5zUtKwjzxj9QdZMfd4cUsoDIThBODlkzSxlJQY6
	 ide4sBkfRkxzD9Jztz4+gatikxxLJAH9x0ki/8WV9aet2GGemMtNG6165480H9B1FN
	 ZPTrAqvI8TaQw==
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
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 08/26] context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into ct_nesting_cpu()
Date: Fri, 16 Aug 2024 09:32:23 +0530
Message-Id: <20240816040241.17776-8-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree_stall.h                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 586c1ff22c2e..fd42d8120ac2 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -80,7 +80,7 @@ static __always_inline long ct_nesting(void)
 	return __this_cpu_read(context_tracking.nesting);
 }
 
-static __always_inline long ct_dynticks_nesting_cpu(int cpu)
+static __always_inline long ct_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d65974448e81..59b1d84a4749 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -516,7 +516,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       ct_rcu_watching_cpu(cpu) & 0xffff,
-	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
+	       ct_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
-- 
2.40.1

