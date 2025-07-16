Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE62D77F8;
	Wed, 16 Jul 2025 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706464; cv=none; b=RY4iYLU7COr8TTTMGSHVStMVxjT7IqPM08Y8ll3d6qlGnK5/ktuqT4ivlVqpEv3yaCM6h7J3pVkXpdimXDmCIcpPr1iLk1iR5dCav9OLEDgnxzeyiueu+hUlgphq+WpGlpDsvThFJyQNjhkRxlbI3elgC7fvVRSF1FUDx5Gokv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706464; c=relaxed/simple;
	bh=ZJbmCfsVL0hjoLbkEG1IKoi7GsXaapp0/u28pJAuVHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBJnq1YFky0xhx1ghSjuo5liQtGIq2BPLHqxdfK0v/7afq9nVJa/OFybjYowot6/fmreEiHb+/BZD9r/YiacZDTaqmq5ZmRToNtY5Z1NREVpQTV5862VMBh/BzchjB8eNwUuhu84lrcOIra/PgcIROfiXlzCDm2r2wyjuS5htL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWcfC78c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWcfC78c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3A2C4CEF4;
	Wed, 16 Jul 2025 22:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706463;
	bh=ZJbmCfsVL0hjoLbkEG1IKoi7GsXaapp0/u28pJAuVHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWcfC78c3L6w7FRmHMxCgwwyLGcA8/HG0AdAgtQu7amWBnXVlxglMPlzBz02HA5PJ
	 NwSG/HJIyWnEnWHqcJGP/avvw1DSoyfRwGsyHTdzur7+6nyhp+C0WuWBey3/z67KJZ
	 Z/KT85hcHgRYvwmRLVs4BjrLOmOHra1VhdA7OXvt/PvOgr/GoJhEDhs08NA800stdp
	 PewSaWbdUlIuwNd6gT62UpEL267CZ9z+z+N6ZUCZBROTdmQEMaJCTEGoyFXygVhx0S
	 OPuTZOVVlp6U0Th/aWlUfuifktxpcRphpiSZYNmmmbOMy0DeModskYLjECZlv0dYY0
	 hYcEzGFfEjAQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A9EECE09F5; Wed, 16 Jul 2025 15:54:23 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC 2/4] srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
Date: Wed, 16 Jul 2025 15:54:16 -0700
Message-Id: <20250716225418.3014815-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
References: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds no-trace variants of the srcu_read_lock_fast() and
srcu_read_unlock_fast() functions for tracing use.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/srcu.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 9a25a2cb000fe..ef65ffe152fbd 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 	return retval;
 }
 
+/*
+ * Used by tracing, cannot be traced and cannot call lockdep.
+ * See srcu_read_lock_fast() for more information.
+ */
+static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
+	__acquires(ssp)
+{
+	struct srcu_ctr __percpu *retval;
+
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	retval = __srcu_read_lock_fast(ssp);
+	return retval;
+}
+
 /**
  * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -394,6 +408,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
+/*
+ * Used by tracing, cannot be traced and cannot call lockdep.
+ * See srcu_read_unlock_fast() for more information.
+ */
+static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
+						 struct srcu_ctr __percpu *scp) __releases(ssp)
+{
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
+	__srcu_read_unlock_fast(ssp, scp);
+}
+
 /**
  * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
-- 
2.40.1

