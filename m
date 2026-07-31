Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B7C2C8;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459845; cv=none; b=XsaFiZ6TH8QP7j2+XZw1fOTOf+Eb9cNMdeyroVpivw7L+amB0cK+5/vCzdULXQKzRzm3MuOPWBS8hoUdjL2hFvT5XwlkXBl30P+XEpQx3BKsslUantJZ/t93KgeVWflalHjQKAMzlZllDfXImMC1X8Shwy4BFs4J2NJzlRHh0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459845; c=relaxed/simple;
	bh=YOgIfjZ9Hv3w6fqRg4OHpHpWDtOkOacsGc+bursHpzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDJzsr1cQY73rDUDDjfVaP0JFJuLFRs86IRFBiE3VLWMZrGWA3jwkCtWzDSuFObxhMdJ9blXXT2cqkBZA+uDcnbfd7BgRrnkuIy/XQ3a/FwhI5M/kijlWTaAwid4A9M8Lc7LRPHaQXQVusjmyAFVcdGOhBQHP/puRFDElOf6dKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLR6lCpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLR6lCpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52301F000E9;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459843;
	bh=D0YSEH/Doqmop/Dz/KZ0B/3nd5tyCJxHYawhjRSN0dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLR6lCpWbe0725u7glWXikjC3ZJxi5gshVS6iz3DnvEd+87l/ahuCPoUwg6vimpKa
	 m8TJhUm4HAp7RIVHzPbKqj4xqWsd5x7iqClR51owJ13gbESCKojWScoEbEIxbfDBUe
	 AsIWI47O5mAF0ho3JmHFCNcxlD6Dbi2tuL9MmSa6/03cbKg4jBGPDmuPY7qL8uKiOO
	 P/Q19AC2zJDnCsHtVh+a1PUAVjmp4lpgm3EmNiVc6D+qOlSaen6S9gga1foYBaSedJ
	 fPIF4kNazUil7YKv0m0DtMhdd+Wi9ioN86vlosxnp9mPvcSIziuuxaK4/millXw4bl
	 9197wJGB8QAMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 894AECE0F69; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 01/10] rcu-tasks: TASKS_TRACE_RCU doesn't need IRQ_WORK
Date: Thu, 30 Jul 2026 18:03:52 -0700
Message-Id: <20260731010401.3531631-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that Tasks Trace RCU is implemented in terms of SRCU, it no longer
has any particular need for the IRQ_WORK Kconfig option.  This commit
therefore removes the "select IRQ_WORK" from the TASKS_TRACE_RCU Kconfig
option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 762299291e09ba..332df7a7a6347c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -140,7 +140,6 @@ config FORCE_TASKS_TRACE_RCU
 config TASKS_TRACE_RCU
 	bool
 	default n
-	select IRQ_WORK
 
 config TASKS_TRACE_RCU_NO_MB
 	bool "Override RCU Tasks Trace inclusion of read-side memory barriers"
-- 
2.40.1

