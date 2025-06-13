Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540041E5206;
	Fri, 13 Jun 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828147; cv=none; b=Up5LKz6jM0JeSq3YKUid47C9T1Z57AO2owdR0Qcg1nZDbjvosIZP+RcMluU5X9mJjWvFkUJDJ+5J/0k33pl1Qhji6WmUXG/vWpI7S8I+ISCqixbdcLynGcNnPT8gS/QcSLb/sv9bCqQbqY5UOvet8sIzyv/F5LQks+F1fklzT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828147; c=relaxed/simple;
	bh=yraQ9N6DoxkVeYF+9KhqSRurdHu3KLUKyTGxW1FZ0ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5dDETlXbsbBFdKxzcI4+rEKDO9XU2YPO8zJ6V8X2CtJPaSYYb4owjb3mA2Jzwmn4Z++yXXth4R8qUNHoAvdtkciSQShtiedgWFGt2d7qqs+Xggn47hhQMX4m9vis6bFcdNCGzH5RIzbIERZqcAPFt2d39aTsbKTCXOMye9TY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vD8Syex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tSuaW3Gm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vD8Syex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tSuaW3Gm"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749828144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaTlRENjdS56eVUvOmYn4aQmfrTxRF+Kl8v2rMC9NJA=;
	b=1vD8Syex6ddWCBVl2TYcjfKwND97NhVYcVMCb6AaEJbTvD6mBXOYtEAbkRoNqp6bNHToqJ
	a8fSEi4bn0iuHDFHcKUuxjYUhn+L9GRMR7KFGEPlf+4kz3DnaqYYBuhMfpCa0uqE45pLID
	S2UojCAqVmYWtTsWEBMvQA8Ue7ppAiDXlexgtnc8c1sCXADLVZMhbAywovaMo6uEwKRwAA
	AchVZ7sCTQuO+5BaKJdREDJOF12n4nCuuiNlJd+WSHDMzOWXN78kFR3m0bIvTJPg+MdZkW
	t4FmPj1/8Y6Dq6Z4Ab8Mq7n+dKAcZztUMtRIxIg0ACNCDqoPeDmxcHknfz5vdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749828144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaTlRENjdS56eVUvOmYn4aQmfrTxRF+Kl8v2rMC9NJA=;
	b=tSuaW3GmESQfpxXxRqndAcsRra5d4ppFzfr6etGforslmF6wr6FYWbhXLcXG06R1+ufnJz
	N5mK6Ir8UydKnIAg==
To: linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 2/2] trace: Use rcu_read_lock() instead preempt_disable()
Date: Fri, 13 Jun 2025 17:22:18 +0200
Message-ID: <20250613152218.1924093-3-bigeasy@linutronix.de>
In-Reply-To: <20250613152218.1924093-1-bigeasy@linutronix.de>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch from classic RCU to preemptible RCU.

This requires to change the guard in the __do_trace_ macro and account
for it in trace_event_buffer_reserve() where the preemption counter is
substracted. This is then no longer needed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/tracepoint.h  | 2 +-
 kernel/trace/trace_events.c | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f85..15f851a1de55d 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -271,7 +271,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(t=
racepoint_ptr_t *p)
 	static inline void __do_trace_##name(proto)			\
 	{								\
 		if (cond) {						\
-			guard(preempt_notrace)();			\
+			guard(rcu_notrace)();				\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 	}								\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abff..76ea1cf9f4d65 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -659,13 +659,7 @@ void *trace_event_buffer_reserve(struct trace_event_bu=
ffer *fbuffer,
 	    trace_event_ignore_this_pid(trace_file))
 		return NULL;
=20
-	/*
-	 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
-	 * preemption (adding one to the preempt_count). Since we are
-	 * interested in the preempt_count at the time the tracepoint was
-	 * hit, we need to subtract one to offset the increment.
-	 */
-	fbuffer->trace_ctx =3D tracing_gen_ctx_dec();
+	fbuffer->trace_ctx =3D tracing_gen_ctx();
 	fbuffer->trace_file =3D trace_file;
=20
 	fbuffer->event =3D
--=20
2.49.0

