Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262782;
	b=sKuWBt0vVqfPlek4PtPA3ifDkMdfn7ksQy4yg6b4CyHu1W0wW2A099XTvHoE0+sNDNFP
	 8ugJ7/hulMfNXiqeQcNn7FnrEn5Q2b5l91WNIX7kPWnHolk5OsypOB7IhW2KSnYmbWpp/
	 7pV/1HtvnBsK0HIB1I6vwqo0pi2TjG5w1rjHKZMkIwoXDrxgI+OPhuUCfMdWvmUYJkeTh
	 h9zgxXboobUz1zFIrZuABWtIGotn/7IxklLwjdyS87TdqSiwIk+6yFXoeU+j/NrzflW65
	 mTHFt9I+e4QvARbCCoAGtd6HviLbHBd9cMKjvjhfIf2ZLK4mOltzq/HC1y39bZGtUXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262782;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wqlX2onpNtOaHU9fs4udxbR7gzBoxO/Ki8psPvw8vj4=;
	b=yMJcJJYPKp0AaquJQQaIXK8O+fokg/hz0HTuK/o1/yTHHWdYF5W60Z+btdRCijdCOE75
	 xfVIwmAVWq1zmkpseTiFYwr8TbQKx0YAlOn2jYEGip+BW67SKOpBpMAt1SwccFINGpKJq
	 kkM7Q1/VW9U9b3mEzT0GYBDqPDdyGC2la3vzvWIEvYGbef/+4GrAu5+si3tFTg5WwlKnb
	 RmfxxjRdufChuDujT2pmtluaufl78xczG99PdlRi+W4An6iBr8HDuHDVRO5jlkdmnA/c8
	 ug7iLbfCyHOvVVxrc9z+lZ0tI0XVlCMhvQ1XnpGmJpLxXvUaxtjaFQt4LBpQXPPO8bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DN3nNsOV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F92606A332;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DN3nNsOV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2977A1F008BF;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262781;
	bh=wqlX2onpNtOaHU9fs4udxbR7gzBoxO/Ki8psPvw8vj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DN3nNsOV2DYyC7VAll7sW+E9jTj7gj84g8fTUyx6PhLqY4TlcXEA34mTy7y6Vjkth
	 K625yQJftXhvNGpttDROuaSkeB6Cuu8RaTMhp3SrxZLtfSH1BgJZtSbKaDI8fxBbKY
	 isxROjP0ShNer2At6xcgdZAVsUlM+v7eHcJLWwxlnvccrnXXwN8jKxCHSwvYY9wMN+
	 MGX5/T5dM4vWu32JNYUQlJSouI2nHLg13auGI48mNaVkHmmxT3V/6YgTi1qHL/tfq5
	 MJ+RHhy/GvFViYCzRBmwSssdMatGe3r19mP66K0lMbY5xwwbD7yVxMT6MkeQWD09wy
	 rKXmMarDe9+Kg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B67E0CE0F42; Mon,  9 Nov 2026 14:19:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/8] rcuscale: Add srcua scale type
Date: Mon,  9 Nov 2026 14:19:36 -0800
Message-Id: <20261109221939.2070171-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
References: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
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
---
 kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1097ec15879cb..b172882824aca 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -293,6 +293,44 @@ static struct rcu_scale_ops srcud_ops = {
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
@@ -1110,7 +1148,8 @@ rcu_scale_init(void)
 	long i;
 	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.40.1

