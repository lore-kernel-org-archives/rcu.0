Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14715ECE9
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832320; cv=none; b=Y1CIAxZ0C2hRq1fu9Q9V6yG+xG44BetYfTC+RrsgZgrZjeylpqJ8a4NCqwpMCoqlag45tMJjMpo4o7m3SPoov7+elbxK8jMns3/2DBLBrlgKrzy8CBjgW6sT6hR95QObcuHPLYLlZwFA6RmmRAIY5Ea+LUUtAUKmJs7jjTpLIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832320; c=relaxed/simple;
	bh=M1ycwrx85gwd22Qgvxzy/Tavlsv+i17Oq4QAV1+TTjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO0ny/nZ9TrmrNoqqbkB42nYoYvtlqRW1b8GdQUq9rf0q891mAVeb4Q/0k1zfC1OYa7RMsW5NIZwX53v0Zqtvp0WPSiUu96bpvCdzqgnEQ1V4LJMpSs6ZKy18xhH3FglXEvsNRtfK6tCiIz/hsDdSwNGMmeJ6A5tEqQY23xWQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaC50uCZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaC50uCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoW/Tl3zMSyfl7VQn42yC5u4NPpuJQunRfSUZLr19q0=;
	b=DaC50uCZrr6xAGDBIZID6wixypVisEYycm2gn7S768+r6YHj9xMqPuWQaeMcKl7AABpJcu
	ANaeHwn3L2Nwn9Uk5bQQjPfn6AYR8O0WEafGoxGnbw7TOcIVJsUac1k4dsAqmdqnI8AKoc
	0HmjNqELVwCQyBBlDbT2YJdtTWbjASY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-w6u3LtqPNmeRF4fjm7QLIQ-1; Wed,
 24 Jul 2024 10:45:13 -0400
X-MC-Unique: w6u3LtqPNmeRF4fjm7QLIQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B45EC1955D47;
	Wed, 24 Jul 2024 14:45:11 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A28771955F40;
	Wed, 24 Jul 2024 14:45:07 +0000 (UTC)
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
Subject: [PATCH v3 08/25] context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into ct_nesting_cpu()
Date: Wed, 24 Jul 2024 16:43:08 +0200
Message-ID: <20240724144325.3307148-9-vschneid@redhat.com>
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree_stall.h                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 586c1ff22c2e9..fd42d8120ac29 100644
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
index d65974448e813..59b1d84a47493 100644
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
2.43.0

