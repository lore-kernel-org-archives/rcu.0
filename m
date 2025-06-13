Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12A1E51FA;
	Fri, 13 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828147; cv=none; b=BtO5e1UIBYIsBpeALoRF7A3OFHh8nzIZrNfSJhK61VFaNu4q5fjckI5szm8hA2I/zT/feHHwAMbG3n9it03iui7/bP+FfnIDGqXUzTqDfHQatnz0Dq+yRwzujijD2s8kpOfJKxFvChFRTSPGorHIT0to2QZdxDv7CSrfnGU01AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828147; c=relaxed/simple;
	bh=QCRRZXKvWLVAjHMr27fyUs7lEHznJH5LPEZ6GoemBQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClKfmI1hW3Dl1nfI/7zQ5pnQ77eY4DKeVCqan/l0tGtpWFS51th1/hC842xsw789xbcfF6fkHUCb4udGw1hdS9I+APy7Gf67jNxYFi2sI2t0mXxr9mwZPZTCVBhEi0GqjYE1pFvyMaNKX8PRxx12UfAtgpJasgfldLlvPTd8VLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H/ZP8GWJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZlA+lgfO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H/ZP8GWJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZlA+lgfO"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749828144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqttoDwydFcskDHEmdV8pxyAqc9dyGNtiSuPH4p44jI=;
	b=H/ZP8GWJJkX0wGBMx+Qj2xqFhW4gYpdmFV17mkM19B3uqu8trFJ2IYUFQDqiNuxueiIie3
	bSqquN3BzsxTJZVLtPmkJYG3L/KHqlY/KeI6jo6f7xG/ET65EqvNsE5tIUB8Wh7imc2uj9
	j3nBf/NA9CCq2VciUj+Ytf9869wJcTCErwimFkwmZJfhn6+trcL5Md2JWpd/vJRbiMwbg7
	HlM71+pUYwpicPf8R5bdXu5WJS/UJCoIb97ZysfejZIEMuUTy1g/qVeYtQMNUArsT7ClMc
	/2eNB706lIrImv2kPgfCndO5OpxcE982E7w6BgdTFxPJLnhj/qgWv/bNlbu8Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749828144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqttoDwydFcskDHEmdV8pxyAqc9dyGNtiSuPH4p44jI=;
	b=ZlA+lgfOorWnu9wnb5WfZbQefLRz4s9jCUHjddABfI67s5W0MBpeFP93HFF28DCsUQM+CD
	Nfg/7C1moQHGB8Dw==
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
Subject: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Date: Fri, 13 Jun 2025 17:22:17 +0200
Message-ID: <20250613152218.1924093-2-bigeasy@linutronix.de>
In-Reply-To: <20250613152218.1924093-1-bigeasy@linutronix.de>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rcu_read_lock_notrace() follows preempt_disable_notrace(). The idea is
provide a rcu_read_lock() version so that the preempt_disable_notrace()
user (which use RCU-sched under the hood) can migrate to preemptible
RCU.
The first user should be tracing (tracepoint) which is using the
_notrace variant.

rcu_read_lock_notrace() is a slim version of rcu_read_lock(). It simply
increments/ decrements the counter. It does not emit any warnings if
RCU_NEST_PMAX is exceeded or patricipates in STRICT_GRACE_PERIOD. It
also does not participate in rcu_read_unlock_special() as it would if
invoke from NMI.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rcupdate.h | 41 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree_plugin.h | 14 ++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb1..0de7e68a2411a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -71,6 +71,8 @@ static inline bool same_state_synchronize_rcu(unsigned lo=
ng oldstate1, unsigned
=20
 void __rcu_read_lock(void);
 void __rcu_read_unlock(void);
+void __rcu_read_lock_notrace(void);
+void __rcu_read_unlock_notrace(void);
=20
 /*
  * Defined as a macro as it is a very low level header included from
@@ -93,6 +95,11 @@ static inline void __rcu_read_lock(void)
 	preempt_disable();
 }
=20
+static inline void __rcu_read_lock_notrace(void)
+{
+	preempt_disable_notrace();
+}
+
 static inline void __rcu_read_unlock(void)
 {
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
@@ -100,6 +107,11 @@ static inline void __rcu_read_unlock(void)
 	preempt_enable();
 }
=20
+static inline void __rcu_read_unlock_notrace(void)
+{
+	preempt_enable_notrace();
+}
+
 static inline int rcu_preempt_depth(void)
 {
 	return 0;
@@ -843,6 +855,16 @@ static __always_inline void rcu_read_lock(void)
 			 "rcu_read_lock() used illegally while idle");
 }
=20
+/*
+ * Used by tracing: cannot be traced, NMI safe, usable from the scheduler,
+ * usable to trace the RCU implementation.
+ */
+static __always_inline void rcu_read_lock_notrace(void)
+{
+	__rcu_read_lock_notrace();
+	__acquire(RCU);
+}
+
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
  * way for writers to lock out RCU readers.  This is a feature, not
@@ -873,6 +895,11 @@ static inline void rcu_read_unlock(void)
 	__rcu_read_unlock();
 }
=20
+static __always_inline void rcu_read_unlock_notrace(void)
+{
+	__release(RCU);
+	__rcu_read_unlock_notrace();
+}
 /**
  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
  *
@@ -1166,4 +1193,18 @@ DEFINE_LOCK_GUARD_0(rcu,
 	} while (0),
 	rcu_read_unlock())
=20
+DEFINE_LOCK_GUARD_0(rcu_notrace,
+	do {
+		rcu_read_lock_notrace();
+		/*
+		 * sparse doesn't call the cleanup function,
+		 * so just release immediately and don't track
+		 * the context. We don't need to anyway, since
+		 * the whole point of the guard is to not need
+		 * the explicit unlock.
+		 */
+		__release(RCU);
+	} while (0),
+	rcu_read_unlock_notrace())
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0b0f56f6abc85..02cccca917a22 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -420,6 +420,13 @@ void __rcu_read_lock(void)
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
=20
+notrace void __rcu_read_lock_notrace(void)
+{
+	rcu_preempt_read_enter();
+	barrier();  /* critical section after entry code. */
+}
+EXPORT_SYMBOL_GPL(__rcu_read_lock_notrace);
+
 /*
  * Preemptible RCU implementation for rcu_read_unlock().
  * Decrement ->rcu_read_lock_nesting.  If the result is zero (outermost
@@ -445,6 +452,13 @@ void __rcu_read_unlock(void)
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
=20
+notrace void __rcu_read_unlock_notrace(void)
+{
+	barrier();  // critical section before exit code.
+	rcu_preempt_read_exit();
+}
+EXPORT_SYMBOL_GPL(__rcu_read_unlock_notrace);
+
 /*
  * Advance a ->blkd_tasks-list pointer to the next entry, instead
  * returning NULL if at the end of the list.
--=20
2.49.0

