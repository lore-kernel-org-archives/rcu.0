Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD83B8D75;
	Mon,  6 Jul 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358889; cv=none; b=rprYOw8H9hUww+KtR2OC50qolYVDFcOmaPjNBy+7mBDHn0QnUIwtKvh54uMqhgFmIO4xQ4ZjkTx2IuNsjswsy/EM6axqH0zHdzxpIJ9BTXTyhV45V4hvZca68Mqx5TJ3nPH2anIq3i8K3Qty4XhI+s6VMi/k9zFBg55aAbLlXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358889; c=relaxed/simple;
	bh=53GiFZhnQzwnO4b0Tj/JBGgNVPFjY5AdV7oQvh8Tysc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/92LA2tOwG7yPZWbZxln7+CQ2AK23hs15RBIDYYtP3FmwDgdWEm33jMPKC3UTGSRDZ/yo++mj5PmYZupauJJqHkG3yPb3RIcIvxeOwZDzEwNdF4UfpXY94a+ppq/qpYpjOtBPNKjYk8ehxdT77erWUUKIy1NCLxGpH50rLWJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REXFBEHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REXFBEHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994CF1F000E9;
	Mon,  6 Jul 2026 17:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783358887;
	bh=cD4VVXp5TnIqFhzSBhexKUn6HSVG2nDuJZQtRH2FUU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=REXFBEHEm94e71S72DGN4ctUTbZYoZYBuB4jTjouD1lcWwXZ8fEiN187gZ9OVKLPl
	 22fZCRER+QT4Z3hHpsDwLRiWJiBL9QsPxkg3vEuwINS2hDDIotrUv0NjK6735INrqa
	 Ipp60RqgR63Z+QUZgiSR68TPetqtAWz/gC1pLXVi4vsjZlGATaCqvxkRhCyqQSp2dm
	 Lw4TWXQ9oZeBks9tsAc2MuQWiH7L+3CJEJ2YyWjAEUnxm/FLyZo2B8Y5ADI4oQw8st
	 epvsmHyW0EPfYWtksxDzQiYC3I/CPA5lA5LYMv2r3Zc45Ja/8KDj0g2hChMLNWsGg2
	 ff7YEreFAGqug==
From: Puranjay Mohan <puranjay@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] srcu: Add lock guard for srcu_fast_updown flavor
Date: Mon,  6 Jul 2026 10:27:41 -0700
Message-ID: <20260706172744.3920417-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706172744.3920417-1-puranjay@kernel.org>
References: <20260706172744.3920417-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a guard(srcu_fast_updown) definition for scoped
SRCU-fast-updown read-side critical sections, following the
existing pattern of guard(srcu) and guard(srcu_fast).

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/srcu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a54ce9e808b92..72c86d3b23f2e 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -638,4 +638,11 @@ DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
 DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
 #define class_srcu_fast_notrace_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, _T)
 
+DEFINE_LOCK_GUARD_1(srcu_fast_updown, struct srcu_struct,
+		    _T->scp = srcu_read_lock_fast_updown(_T->lock),
+		    srcu_read_unlock_fast_updown(_T->lock, _T->scp),
+		    struct srcu_ctr __percpu *scp)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_updown, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
+#define class_srcu_fast_updown_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast_updown, _T)
+
 #endif
-- 
2.53.0-Meta

