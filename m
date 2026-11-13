Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531488;
	b=W2VTUP1lvNFB8V/12SCpb7UP3LmrNe3T8vaE7AbZDuU/dDCMeehB86cV9ZrsdcuaLFKL
	 m+IY5616okmxPj5UnHEqjN/8+gJsGJXSNP3Ib8VK4CJIRM4VEKS+4h+wWyxxXSqzAM9cj
	 YCRdyHtUugtcQc7QbstM0x9RXrHuXER+EqiM4XcXVxQ1yREBe6FRiqOZHGiUWe6P9+4qh
	 giab4rm/DHtno511oArcWmLMG7M6hZK38TG2bT2JglppBzfG7BPo3Gm/Az8JnYSYAHbRa
	 jCKa5y1JGJRGodsQiVQz6w9lAr3baDR1PspKd/stLVMIPRULnDcVRv/1al3QF9h0b2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531488;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9KrAdULCzzi+o1kFy+xOWC2+HcJXlxBlTraQzryexnE=;
	b=ZEs/RUFPHJic21MRiciwFAtfaxeaM3MAgJWvyYp9GTFJ3V5ZYVWjicNGQV1aErP81+cX
	 dci9eo83sckNpX3eiTlwCWchT8kuqL00NOVcmRIIuOrjXjrIn1As+fHTG6TowNNtCEOT4
	 7yZus+blauHMS4LCJq/+l/K6Ql2BUTMWNR+OB0f4ni61HJ4Ahhgyt4nkTnnznP9UpNMYq
	 hkb3xQYm6MZp37oAe9+TXtHD+RPC7oPQTyx25sgeoTG++F11SrOyI9xku0JfdAgTEu/mj
	 zAB7M+wNBQ+GsKR1NZQj6orewtmHtuEkDO0le0Wc/wLj2fsN7k198VifxVCUUBw9Cpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5VMZD1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C8432606A890;
	Fri, 13 Nov 2026 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5VMZD1b
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4BC641F000C5;
	Fri, 13 Nov 2026 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531488;
	bh=9KrAdULCzzi+o1kFy+xOWC2+HcJXlxBlTraQzryexnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5VMZD1bBeWBBKyH7KzbMN/ekUzo9lSI24LOdbzOuvH8EhKtd28O1jNpwXQLfJp91
	 eFHx90apAgYoKbcLWmZNbaDV/1pxmX0uTW7ryujlQ4YiorbWrbgvD2v08Lr0o0KVpA
	 n91kXAqFzaHNB2Wb9YAIEacumZGRAuiwCwN31C1freJKyo80517fhWzvtbzEzyXMgy
	 Ry5+vCXH+DEddiHx78U6RQ01kSUsvSg2ow9BDqRwLbY0kgTT16ce7p6/yymUNCjChq
	 hn2WFvBjbyXo/M01yzm9HY6aDdOnyJSa94jW2dPOfvku3gE20XOC88nJ1+OCSox/B1
	 UbCnhCd7dQurQ==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH for-v7.5 09/14] rcuscale: Add srcua scale type
Date: Thu, 12 Nov 2026 19:57:36 -0500
Message-ID: <20261113005747.2977123-10-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Add support for scaling atomic SRCU grace periods using
srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
synchronize_srcu_atomic().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 41abf05a14d9..687249d686a5 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -297,6 +297,44 @@ static struct rcu_scale_ops srcud_ops = {
 	.name		= "srcud"
 };
 
+static struct srcu_struct srcua;
+
+static int srcu_scale_atomic_read_lock(void)
+{
+	return srcu_read_lock_atomic(srcu_ctlp);
+}
+
+static void srcu_scale_atomic_read_unlock(int idx)
+{
+	srcu_read_unlock_atomic(srcu_ctlp, idx);
+}
+
+static void srcu_scale_atomic_synchronize(void)
+{
+	synchronize_srcu_atomic(srcu_ctlp);
+}
+
+static void srcu_atomic_scale_init(void)
+{
+	srcu_ctlp = &srcua;
+	init_srcu_struct_atomic(srcu_ctlp);
+}
+
+static struct rcu_scale_ops srcua_ops = {
+	.ptype		= SRCU_FLAVOR,
+	.init		= srcu_atomic_scale_init,
+	.cleanup	= srcu_sync_scale_cleanup,
+	.readlock	= srcu_scale_atomic_read_lock,
+	.readunlock	= srcu_scale_atomic_read_unlock,
+	.get_gp_seq	= srcu_scale_completed,
+	.gp_diff	= rcu_seq_diff,
+	.exp_completed	= srcu_scale_completed,
+	.sync		= srcu_scale_atomic_synchronize,
+	.exp_sync	= srcu_scale_atomic_synchronize,
+	.stats		= srcu_scale_stats,
+	.name		= "srcua"
+};
+
 #ifdef CONFIG_TASKS_RCU
 
 /*
@@ -1100,7 +1138,8 @@ rcu_scale_init(void)
 	long i;
 	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.54.0

