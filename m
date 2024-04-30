Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FB2199E8A
	for <rcu@vger.kernel.org>; Tue, 30 Apr 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468724; cv=none; b=E2AXYV24jo4N6nV5WMGLdXJh+mmELc7FWAcwvKSFhd9fEgNRoZHeAwbWmgEm8PIxrCJ4IIkJjUj6ib9F2V7+rnktKPiXs+J3p+xr42bep9KkFHN756z7xvSI1M2wuYzOLY4LryjfAHcDU8Mk3LZB45J5m6JSmm/cbVws1FGQOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468724; c=relaxed/simple;
	bh=gLzeFeK7xoPYuYItjATa5D0M3vpYqdDQWtf+lxIjfQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn9tnF3VUJDw9Lt20BYv4u6sxCugwNqW9/lop/4zeTAAIg5hqOtcuHyxNoHnZ9LugD7I9oqvVBr0J1bD9oUNbDuylV0KxRzIVlHAIv3ym7ifcwYkDnieuzuwXWm09t9LYqtv7SrZxFepxwcoD62rVY0rVf7ckwY2TeDuIuB7OaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHuZKbi/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHuZKbi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwvNVTB/8njt0PvzvkOv+IOpnsKs5zqtEj+q7KlChso=;
	b=PHuZKbi/DfsRZ6w2DQWkE+TXfLgwRBmFP8qnFJvgWaYrvMDC+XOJtc/VZXssLiKzXeLqlk
	tmaAv7r1jaJRuZu/1IXJUhSeeEKbVLPk0klc5cGnZ9XacZVSI92tUPi+a9tV1Ejj5Z0vFF
	IZLtG4d+HgPGiDBpzjiQx2sFCXe4faU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-InFSlWZwNMumyKiKgxZz1g-1; Tue, 30 Apr 2024 05:18:38 -0400
X-MC-Unique: InFSlWZwNMumyKiKgxZz1g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A0461049C98;
	Tue, 30 Apr 2024 09:18:37 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8294A40BAA2;
	Tue, 30 Apr 2024 09:18:34 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 11/27] context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into ct_nmi_nesting_cpu()
Date: Tue, 30 Apr 2024 11:17:15 +0200
Message-ID: <20240430091740.1826862-12-vschneid@redhat.com>
In-Reply-To: <20240430091740.1826862-1-vschneid@redhat.com>
References: <20240430091740.1826862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree_stall.h                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 8f32fe599c5c0..34fd504e53a86 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -92,7 +92,7 @@ static __always_inline long ct_nmi_nesting(void)
 	return __this_cpu_read(context_tracking.nmi_nesting);
 }
 
-static __always_inline long ct_dynticks_nmi_nesting_cpu(int cpu)
+static __always_inline long ct_nmi_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d8e5b49e65565..6cb346952e3e4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -516,7 +516,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(cpu) & 0xffff,
-	       ct_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
+	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
-- 
2.43.0

