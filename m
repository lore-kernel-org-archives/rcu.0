Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD42DEA6E;
	Mon, 21 Jul 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115075; cv=none; b=DZOb2deT3twohjL5Sghg/YyiRw5qFpxBVxrj4znBTy45faDnRtjkg1OGPSeWqyEdtFQ9jm/o/9ixCFma93Ha6MmFtWSiWfndDeftQ0DWb4YaBpxlHn5SWWKF5VRnMGnOQaGAMvAUcl/AHtT1zLqV3QSaHGI1FT2QaXkJ0AmRYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115075; c=relaxed/simple;
	bh=9QmLJANZefPN4fX6BWptBQk5yBPaFOqHuPr+mZ0Kvo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2JdjR/9tVR2UKvTqDwa1MUv3CdGdqCx8ADSTUuFh66FHj7RuN0DGJ8HVxombKP323QnNYotjf6xZXpNXU6FSKMy+7hwQPLXsxwXGQRK1j0hquSYd3L/LSfYhfgWK0UG3TKU/XWXuzXoPVpbJ4ySnDc6rkFHwzFQ444/xlDklBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq6F2f/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq6F2f/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60846C4CEF6;
	Mon, 21 Jul 2025 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115075;
	bh=9QmLJANZefPN4fX6BWptBQk5yBPaFOqHuPr+mZ0Kvo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jq6F2f/gSimRuTQNMi+gVsJIc3/EGJEmNdIFuBtjzbjK/LZ2WRuMxw0386rPM7yEw
	 2iVFcGg2JjFuDmEbs9QgkBpm1h2Cgf+i5G/+wFqPqdqq78AEMakRQdo2HBBw0URc+i
	 an0do7TW+UaUUPo1QLwXTWkeSms7HyZ15Q9m0r2ENds/PIeu31K6CRy+GBka4y3TSC
	 WnEInAflcdOBifcUei305Wy8l5cNODIa3tP61DRl1whiW8Fe/l26qPNCIImVH4cw08
	 K3T0hwgedPYbBjkvd+ySphv5dK6k8eCEDk7sw/bent6hAy418gLI6T9XiSqd/EHBd7
	 hw2SnhaEyWXtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0F0CACE0CB3; Mon, 21 Jul 2025 09:24:35 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 2/4] srcu: Add srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace()
Date: Mon, 21 Jul 2025 09:24:31 -0700
Message-Id: <20250721162433.10454-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
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

