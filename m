Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027E125B2;
	Sat, 19 Jul 2025 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884899; cv=none; b=Jes0NN34Uzekn4PObjbyZ2E/PccOeKv69EcvmWLn8GW8zX0CFlCJ7QE7JX18+cv4mzW28l0YfEmSphhuTFU1Y0531uf1fGr5IzfWK7zLiHzpg02NKAPMJQI+my2RqKO9edz+DNllGAts7MlYBsEo0ChqE3ExmVmI8ClRwPWyxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884899; c=relaxed/simple;
	bh=9QmLJANZefPN4fX6BWptBQk5yBPaFOqHuPr+mZ0Kvo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzjDix55d6XB0FkIwDyfxjcbKHPer6svevXVgwWFvzzwVsiFnJQv8h327FvP5JJP8BQugpY43bYsfqXy8t/NEcz99WT7OKwbkPQE9/fWLxGxKlQdq9aSCkfIVU72YbL7JuuAd5lKGnAKRN9Kwp2hk3X6Mc6U2lXZLX4efX0h50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifjq+2gK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifjq+2gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8F0C4CEF1;
	Sat, 19 Jul 2025 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884898;
	bh=9QmLJANZefPN4fX6BWptBQk5yBPaFOqHuPr+mZ0Kvo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifjq+2gKCKX4amJcdslj69q121nVmcLIc2OWZqqCGH0rLFErN5Pa1GjHLDz90GoYo
	 sDMiekM/Kc2jIVSLNwq48F1O/F2zmSXAF4bo09kmzrBRgk1R0KOYqswGj6eiFpVoSl
	 Yz00GhngEJdlapfSDzvUtJHtxXV7NFLsaefWDfMIsbffPTWLmVe1vWyWnIhjZTJ38V
	 wnn0cNTXGTIn4k4C85cmTKdCKdR3FPaQd1jjEElJn1l7si1/MZ5opA6ktN3EBRfVzb
	 vqKk0hUVw/ikxgbsz+5i1G7kJKzTDIJJstOFzqXEk2WuO6enfoUk6Qp1seubFo7C0S
	 l3QByV3HOft5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D961CE0D86; Fri, 18 Jul 2025 17:28:18 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/4] srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
Date: Fri, 18 Jul 2025 17:28:15 -0700
Message-Id: <20250719002817.4121867-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop>
References: <3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop>
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
index 478c73d067f7d..7a692bf8f99b9 100644
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

