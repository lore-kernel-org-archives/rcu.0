Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530999;
	b=FwjMU1r42gDDuCsHqoPQPYd5yw7MhrxtWHEgvZu/HCWg643rxWWPSo5RTBJlEEalXDC9
	 rWokUZeid4FpHkbXNWPZsVugFY0wY8gwEltqASzCYCCSRO/lcsHKRl7Ez/xa/MAm6QUx2
	 7LxGXeKL+6hBsES+0fQNQldwe+J9F/X4VUrnPYarRmoF8uuZYImLtPDl5PM3QG2AVNnw9
	 WMkfy1mbEcILcfeeL84kamirRjqpYbWDZ+UWtjL6fAEabTag0pbFu6/ZBBDeptrtAmk0V
	 Km84gQsL8NtDPiW/EL0VboSHBj5V0K4fgNAUesCjiHD7gJCCN/Ie0gJo4gV+Zj4oc1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530999;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mammJvdWasvAO8ivxo8p3ZSf9bVtHP0oKGV1IVgegGs=;
	b=nwm15ayvapy1aSfQaO2daFKXHXPcBXAVef831Le1LX829EWM98i7gtGAK8hyydDjsISn
	 pp23LwLAGhfuTaw93uRtNniFBke2mydTuSCn6zA5vAM8f5TAQGnCE1OnlSFzGI8jStYuZ
	 OM0CG0wQSY9H0mYGAcA5HX7atRj/xn5j2IkhIb623Oe1hGodlGxz1wfCSyP9sX7p52LMN
	 cqLTHlq71ifWF5WUcMDJnInPaht+iXoW7i8X90udT1DA3xrL86K2gt3xHcHHBwFDBU8qw
	 29fcu37CbKjtQpjOXUTYMY3VYBcrmmldwezlE6dux/M6t7XsyU/dH/vv8tOqzj8sHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYTVys7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 79F1B60A2600;
	Fri, 13 Nov 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYTVys7i
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B95A51F000CE;
	Fri, 13 Nov 2026 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794530999;
	bh=mammJvdWasvAO8ivxo8p3ZSf9bVtHP0oKGV1IVgegGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYTVys7inrutEn4q7Rnyfcm9syh9FM1q25+LBHwoyVe8d9grH46Ax/IKg+1XcY8jC
	 eQtWVhYb7vaQFBq3P/XP4NgKqVV78jpLJVMdTVHj1Pex+udVbQPdeTGzVI+2X/Q8Ck
	 Hum9KjVFi2xvDFP6t168yjeiE6ou+TjxuZKc5Vk4IxHrv5ZTacTZ9fkxsftWgnkw+F
	 HXBro7ayiqgoi//JJbJ9OUj2Ll3Y8qi0Qn2UxsHzgZJEoYmoJ/qM3GigtF3lYrPv5x
	 yCWZsVxfCmC2NMTknfE52Cx+I7u17dnyQgrGBLFJ+YgSjVW3sBOdx7BdMYGS0BL9OU
	 5moq2CR+F53qA==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: rcu@vger.kernel.org,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH for-v7.5 5/5] cpuhp: Expedite RCU when toggling system-wide SMT mode
Date: Thu, 12 Nov 2026 19:49:44 -0500
Message-ID: <20261113004946.2758197-6-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113004946.2758197-1-jfern@kernel.org>
References: <20261113004946.2758197-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vishal Chourasia <vishalc@linux.ibm.com>

On large idle systems, changing system-wide SMT level using the sysfs
control interface still takes approximately 40-55 minutes. Changing SMT
levels is an user triggered operation generally done when systems are
fairly idle. This causes users to be blocked from doing other subsequent
work.

Analyzing the collected profile data during SMT level switch, showed
that CPU hotplug machinery was blocked on synchronize_rcu() calls.

Expedite RCU grace periods for the entire duration of triggered SMT
switch operation via the sysfs control interface. Individual CPU hotplug
operations via the online/offline interface are not affected.

On a PPC64 system with 400 CPUs:

  SMT8 to SMT1:
    before:  1m14s
    after:   3.2s   (~23x faster)

  SMT1 to SMT8:
    before:  2m27s
    after:   2.5s   (~58x faster)

On a large config system with 1920 CPUs, completion time improves from
~1 hour to 5-6 minutes.

Tested-by: Samir <samir@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 include/linux/rcupdate.h | 8 ++++++++
 kernel/cpu.c             | 4 ++++
 kernel/rcu/rcu.h         | 4 ----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3f74ae6d6e1f..e498e21172da 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1213,6 +1213,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+#ifdef CONFIG_TINY_RCU
+static inline void rcu_expedite_gp(void) { }
+static inline void rcu_unexpedite_gp(void) { }
+#else
+void rcu_expedite_gp(void);
+void rcu_unexpedite_gp(void);
+#endif
+
 DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
 DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 376d297a6292..d7dc1022bf6f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2658,6 +2658,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_expedite_gp();
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
@@ -2687,6 +2688,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
+	rcu_unexpedite_gp();
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2704,6 +2706,7 @@ int cpuhp_smt_enable(void)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_expedite_gp();
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
@@ -2717,6 +2720,7 @@ int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	rcu_unexpedite_gp();
 	cpu_maps_update_done();
 	return ret;
 }
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index d60444bf3a02..7cae7e64e96d 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -530,8 +530,6 @@ do {									\
 static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
 static inline bool rcu_async_should_hurry(void) { return false; }
-static inline void rcu_expedite_gp(void) { }
-static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_async_hurry(void) { }
 static inline void rcu_async_relax(void) { }
 static inline bool rcu_cpu_online(int cpu) { return true; }
@@ -539,8 +537,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 bool rcu_async_should_hurry(void);  /* Internal RCU use. */
-void rcu_expedite_gp(void);
-void rcu_unexpedite_gp(void);
 void rcu_async_hurry(void);
 void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
-- 
2.54.0

