Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597B198E77;
	Wed,  9 Oct 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478351; cv=none; b=FuPwUkzR2akrVa9oUxcxTbczpZCcCN3XyiuVSYtUKTwMymftbRngB64bIso5J+TtNCmOgOzbEPFYABVBPX+OBjKEtXPRR2S3GBNPVwjLxhJ0Y6WULZf0tXfVNpnCe1ndsqTRBGhSI/VWtUV6uXwuNSMMRWIFVdFti6TCYMGUF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478351; c=relaxed/simple;
	bh=PZBlSy5cYNFCTG1gkW22h6MA1qut/IZhj71pdF1EkhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=olf2DVoLxsrDumPmEEnPgPLZka6JgjjkCSgwfES3Koe//328Bp71PytCh74EPEmFKhTV1jXKgfKgWfyZUZUjoLbOOeqYfOcaZTyPqCJSLuM/z6w4qNygQgScCwEEYcYFx2fhoQccMILxlOjPDQAwQVkJlXNfmDggNQT0lFJLnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbj//0A6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbj//0A6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B308C4CEC5;
	Wed,  9 Oct 2024 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478351;
	bh=PZBlSy5cYNFCTG1gkW22h6MA1qut/IZhj71pdF1EkhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbj//0A6W8qw2wR2SD8dkda/79mSFO+6Kll+nXGcS4nfWS27I6DMMTV4cHlUZFc+V
	 NEd+osPaQJsEYkQgJ7xsr0sZzksNiKwp0wls4gagar7ryhqmPRSb7sPn9wHhPrCGtf
	 pU/Z0s/PwLdwkgxf/1Kq6kiQY+f6RB7/MXfuicbJ1Hp0f+F2KgqFCtsd5w9i1yZ28U
	 CGI+E8iU3iHwLe+1PaFSqMZKTetXsOsB+JjVz2uWzHjDIZb8TvqsO0XYD9ipv/Xar9
	 /UbdpcokvvoGlgiNZ/Ae7C++1dh1dxfbLFrQW9wSVb5pXi1QoMMnjAyr/FlMEOPIxx
	 tpk8WjT5Q9qug==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	peterz@infradead.org,
	neeraj.upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 10/10] rcu: Allow short-circuiting of synchronize_rcu_tasks_rude()
Date: Wed,  9 Oct 2024 18:21:27 +0530
Message-Id: <20241009125127.18902-11-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

There are now architectures for which all deep-idle and entry-exit
functions are properly inlined or marked noinstr.  Such architectures do
not need synchronize_rcu_tasks_rude(), or will not once RCU Tasks has
been modified to pay attention to idle tasks.  This commit therefore
allows a CONFIG_ARCH_HAS_NOINSTR_MARKINGS Kconfig option to turn
synchronize_rcu_tasks_rude() into a no-op.

To facilitate testing, kernels built by rcutorture scripting will enable
RCU Tasks Trace even on systems that do not need it.

[ paulmck: Apply Peter Zijlstra feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 72dc0d0a4a8f..ef9de6b91a3d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1485,7 +1485,8 @@ static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
  */
 void synchronize_rcu_tasks_rude(void)
 {
-	synchronize_rcu_tasks_generic(&rcu_tasks_rude);
+	if (!IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR) || IS_ENABLED(CONFIG_FORCE_TASKS_RUDE_RCU))
+		synchronize_rcu_tasks_generic(&rcu_tasks_rude);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_rude);
 
-- 
2.40.1

