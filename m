Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE03C3F68
	for <rcu@vger.kernel.org>; Sun, 27 Sep 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790503460; cv=none; b=KE90K4tiC7RrMzarLbTWlrGJbWOZ0bt8RiQKEDDRErOO4h7+LCoO3WLb8+JZvraMgRdoQz7Zoc3jB/NNr4A/M+5NwvIEN5chD9lVCjevy63FXx8lPp6OSaZ0PRD0SgS8LSvysI6qQqg/3VLS+ejrGw84Qa4eEinppom1qXj+Vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790503460; c=relaxed/simple;
	bh=wMG+WZeHCxfGYxFJDEJTQwz/5F/+nITu+HXulyIXflA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARfnxaijHB1EieCAM+i08QGlMYngxeprMUoj74PTSBqTd/TVEtDhqE44HBFzC2FLWvoTIKcYgMEAt1xUnMDrFdXlEVdaUyTKcXMMQeW8DvSHT9p1LCxt7yNP63JduSXTYKj7WsqBpYcoDLMRAPsr8DE+EbecWzb9aIcrOBYcKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT0dWUQl; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT0dWUQl"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0dc47fee0so458040a91.1
        for <rcu@vger.kernel.org>; Sun, 27 Sep 2026 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790503458; x=1791108258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITvBuQnNqW1F2T7HCAHKBywausXUCxS/FkshXsi/rvs=;
        b=NT0dWUQlF17kqwPd1AfdV55vToeBIGELqff1hZPvACkv5rxuPKhFwvstbbLgG6316T
         Ii1BN/GqB4an+WC7VyiJuIbEufl2i1MzzO8nOlomu9tYCVgHb3frNCF7lg311BNE9C2Y
         rmLa3JsynlxmVJyHIjX2Hek3uTYeMzxppVWlJpFeKll9a9iQFeO9sV4AVuuhHCyHTjDc
         6hoioXIRcZscTFA2I6Pk2Y3DqKJWn+SWZ4oR30jL76iozoRSSw+1t2x7CVGtOSHbULLw
         BPjjS0LQgy22iK/eVuWioUUXzuOdZ3J1xXqsAwn7KHCuK6bt6QkfdpATFxguJmAP5s1O
         8WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790503458; x=1791108258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITvBuQnNqW1F2T7HCAHKBywausXUCxS/FkshXsi/rvs=;
        b=dVqmfceZNECq1zbe1ihGyKvz8buDtlukFrKhwuEM/qtGKpGNePc8Yk09nka5YIIHLb
         NicgSnpCd5blnxLmiIuzannlZ2eCyLNAs6qX54EvyQsi7rt1uXSQcpjOd40EtlcfHRew
         kUXtXGYwZe1cjqAH7bDZc2yBrXva5fvcmzdFDiMjdhrlxxuDpl+1juVWVoZ7Oy8wSDPd
         r1hX6m6jcddLDoGBjp4vKlQpHvb1IygfzoKfy+KlSyHP0WR0PKmX36l7lrjMsJNCXnjG
         3/pPoS1NoMaN0/pOr42G96IvuUlBvMhCAbExXVklw3oChMzSBPD0YTSLl+d/fGJisipe
         Nd7g==
X-Forwarded-Encrypted: i=1; AKwUvBxhoUzFiDmIkiBGJZAT00eKaVhgIM4VnXGnq/Ht8AC6dy/RKCO1ISmtDkw0RyG6tsGwBuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYINsKGEYSEy8FkMxaDvjDjCS3uiIfKTmhHoAFtI67vXVbNtHVMC
	N4V7ATtGEUz2YBxRDbI72EzF6HXttAL3uykQ5UkQ4yBTyBbJH92+1zoW
X-Gm-Gg: AYBFou36BsmciQlZHVC6BBM5zOoNvkUYb3A8wMSgjFjzgk2Y4uSHJcC0E0KlXY94B48
	hIy8X3A92d2hqpaSmcTu1ZfU+RMF8BdxryhslHWdgeIx5gHooaqJNSm9peyGPCJG47miiz36Ar6
	OZZjuFsTVN1dwaac0Xr6DPV10u1ePqNFGbDz72p6k2dthvyTMCdVNpqqePjlTkP5Jfg/QHRu4jR
	jissuECsvCmjP21EQBAvxKrcYM+VltzjlW75KXofbEmmfirLnMC2OGyfXYH+4WaprpRMLZI3eS9
	hP7V8sRZ7rt3i0vJ8KEmd/n1lomZTi+hgDQ3qk7hznHU3CeQsA51IalCOWM8Jg+VfeTBORdnm88
	SU8LJIJn6mv80oT4LsaaaC9xtOXkgxbPP8sG90anu6nnQv3CNvyK6znA+DBeXQaNRQn2gey+Yp4
	yrihUj13mSTXeoNi09JkktnYXsLTH/ELTEdzyGylJbnbVbkhQgyOID+tBBTPb6F9rD4cPnOub3c
	nXJ6lY6sBCbphwz
X-Received: by 2002:a17:90a:d2cb:b0:3a0:dfb6:aec7 with SMTP id 98e67ed59e1d1-3a0dfb6d466mr3310823a91.67.1790503457660;
        Sun, 27 Sep 2026 03:04:17 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efaeb3sm14239040a91.2.2026.09.27.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:04:17 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH] rcuscale: add srcu_atomic scale type
Date: Sun, 27 Sep 2026 18:03:59 +0800
Message-ID: <20260927100359.3903688-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for scaling atomic SRCU grace periods using
srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
synchronize_srcu_atomic().

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcuscale.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5aca31c3c01d..86f1a912ebee 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -264,6 +264,51 @@ static struct rcu_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static struct srcu_struct srcu_atomic_ctlp;
+
+static int srcu_scale_atomic_read_lock(void)
+{
+	return srcu_read_lock_atomic(&srcu_atomic_ctlp);
+}
+
+static void srcu_scale_atomic_read_unlock(int idx)
+{
+	srcu_read_unlock_atomic(&srcu_atomic_ctlp, idx);
+}
+
+static void srcu_scale_atomic_synchronize(void)
+{
+	synchronize_srcu_atomic(&srcu_atomic_ctlp);
+}
+
+static void srcu_atomic_scale_init(void)
+{
+	init_srcu_struct_atomic(&srcu_atomic_ctlp);
+}
+
+static void srcu_atomic_scale_cleanup(void)
+{
+	cleanup_srcu_struct(&srcu_atomic_ctlp);
+}
+
+static unsigned long srcu_atomic_scale_completed(void)
+{
+	return srcu_batches_completed(&srcu_atomic_ctlp);
+}
+
+static struct rcu_scale_ops srcu_atomic_ops = {
+	.ptype		= SRCU_FLAVOR,
+	.init		= srcu_atomic_scale_init,
+	.cleanup	= srcu_atomic_scale_cleanup,
+	.readlock	= srcu_scale_atomic_read_lock,
+	.readunlock	= srcu_scale_atomic_read_unlock,
+	.get_gp_seq	= srcu_atomic_scale_completed,
+	.gp_diff	= rcu_seq_diff,
+	.exp_completed	= srcu_atomic_scale_completed,
+	.sync		= srcu_scale_atomic_synchronize,
+	.name		= "srcu_atomic"
+};
+
 static struct srcu_struct srcud;
 
 static void srcu_sync_scale_init(void)
@@ -1176,7 +1221,7 @@ rcu_scale_init(void)
 	long i;
 	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops,
+		&rcu_ops, &srcu_ops, &srcu_atomic_ops, &srcud_ops,
 		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 		HAZPTR_SCALE_OPS
 	};
-- 
2.43.0

