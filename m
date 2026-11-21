Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275355;
	b=cMk/gl7CTavpWiwaha5SHtILlBvyRfKzKatOWKHlIqDSHcFjh/e1y4i4bf/x/uoUesIp
	 ceM709fOO1dEjVda5YowknpuPtoTq3mg27g8sFDAvxLQPat75MIP2IMWwWg6fw/VoMICz
	 o5Y+9vx7QAP/qdYoOFhwWYRaE03Li56LC9LqvWYuWrJyiQ8JcWdoUWzDs2O3nCGuvaAL2
	 c4OzB/yOrDLrcHTtzxjy1L7N5cXLk7PdceaFXX9uAPfRwK/Ije98/G5LmtVn/OwODwe1D
	 ntM8HZ1qgVb3uBU5P1qTRuNAzUncBQf5ZM6Ug572e45HRdaP/Gczc1EnaESj2VpmM2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+qpQ1S5lUF7DLeDMaWi8lmddQtSDKtkjGJto3tKUh/M=;
	b=nI24/PbSjW8Bb0oyx/wy+RcOhwrjHkP1C3cD52ez8VuhtPgR5qiEi1d2iPjo8Yly/XYF
	 wnYAKUcA4QKlu88JS7D5Lc33Dkc47qtoZMYd/DpeyxIZF5DyE9iCVbUGITz8ZWHVgl5t0
	 X4rdGnjsHn2bRZg7u/39LeLvNVEz7aDMOtdmcdcGnfhY3ek4fhrhlS0t3Ohmb0hNEKROX
	 rtfKj9oEECj0Eq4m0nHxrXgcvxIn1T5WmJCXByj/J4+/xadbXefQKeJIjXRYxt8nHHPbY
	 uOnsrDuuuNb0ND0MIIYP2+S9FxYjm0oV4suJV4IxLBjlqSHQ4+lX+/QbdY8zl5fgzVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdkhAtJU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 94E1C606A320;
	Sat, 21 Nov 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdkhAtJU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 26AE81F000C0;
	Sat, 21 Nov 2026 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275355;
	bh=+qpQ1S5lUF7DLeDMaWi8lmddQtSDKtkjGJto3tKUh/M=;
	h=From:To:Cc:Subject:Date;
	b=XdkhAtJUyoTRTar0XdWuAtBjwJtSntREKrgADWobrWOzkn1vV2qwbm0PUN1IO0CYt
	 GSgBNdqW38YAhJ3syjSVQeW4nCwUhV+RL5LE7R3DRKBrC8dMWK3anstZkSKZSSqBVO
	 ozsPeypW3X/fSka1SrfsVEc5IK9U4DudE0mbWM5O/hhgr/4QQue2q+HsgEgpE1UEnP
	 aRbGKh1gZQiyW/9YxAi4GUlgSGJev6iqGG5CJf3Fyr9B6abVhC3otkkJgx2O13wLlX
	 wTp/Y22NxgY97mQ97LL8VQqoxgTp3a+bLKTMwGMuZ4NN8yZ6Zy7ufeVmb8eeQ4N3mB
	 Tre6DfKgc00Dw==
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/6] rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
Date: Sat, 21 Nov 2026 10:35:46 -0500
Message-ID: <20261121153552.68941-1-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Hi,

This is v3 of the series that rewrites rcutorture's RCU priority-boost test
around a CPU-hungry reader, so that it neither depends on disabling RT
throttling nor infers boost failure from a grace period merely taking too
long.  See the v1 and v2 cover letters for the full description:

  v1: https://lore.kernel.org/all/20261111213826.2035045-1-joelagnelf@nvidia.com/
  v2: https://lore.kernel.org/all/20261116194438.306618-1-jfern@kernel.org/

Changes since v2 (from Sebastian's review of 5/7 and 6/7, thanks!):

 - 5/6: boost_disable is now an rcutorture parameter,
   rcutorture.boost_disable, instead of rcutree.boost_disable.  It makes
   rcu_spawn_one_boost_kthread() skip creating the boost kthreads.
 - 6/6: BUSTED-BOOST boots with rcutorture.boost_disable=1.
 - Added Sebastian's Reviewed-by (1/6, 3/6, 4/6) and Paul's Tested-by.
   (note: Paul gave his Tested-by on v2, before the changes to 5/6 and 6/6 above,
   so Paul, please let me know if the T-b still does not stand for those 2).
 - Rebased onto the current rcu/next.

Paul also noticed that TREE03 with rcutorture.stall_cpu=25 reports a boost
failure.  He considers that expected, so nothing here changes it.

Joel Fernandes (5):
  rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
  rcutorture: Remove unused check_boost_failed hook
  doc: Document rcutorture.test_boost_reader_ms
  rcutorture: Add boost_disable to disable RCU priority boosting
  rcutorture: Make BUSTED-BOOST disable RCU priority boosting

Sebastian Andrzej Siewior (1):
  rcutorture: Don't try to disable to RT throttling.

 .../admin-guide/kernel-parameters.txt         |  16 ++
 kernel/rcu/rcu.h                              |   5 +-
 kernel/rcu/rcutorture.c                       | 202 +++++++++---------
 kernel/rcu/tree_plugin.h                      |   4 +
 kernel/rcu/tree_stall.h                       |  57 -----
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot  |   1 +
 6 files changed, 128 insertions(+), 157 deletions(-)

Range-diff against v2:
1:  307c7ad81e84 ! 1:  f73cdf3db202 rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
    @@ Commit message
         [ jfern: Apply feedback from Sebastian to use div64_ul() ]
     
         Signed-off-by: Joel Fernandes <jfern@kernel.org>
    +    Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    +    Tested-by: Paul E. McKenney <paulmck@kernel.org>
     
      ## kernel/rcu/rcutorture.c ##
     @@ kernel/rcu/rcutorture.c: torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
2:  8037cd6fe691 ! 2:  dd690a7332dc rcutorture: Don't try to disable to RT throttling.
    @@ Commit message
         [ jfern: Rebase onto the rewritten priority-boost test ]
         [ jfern: Remove the now-unneeded sched/sysctl.h include ]
         Signed-off-by: Joel Fernandes <jfern@kernel.org>
    +    Tested-by: Paul E. McKenney <paulmck@kernel.org>
     
      ## kernel/rcu/rcu.h ##
     @@
3:  121b55687de4 ! 3:  c9bfbebcbc04 rcutorture: Remove unused check_boost_failed hook
    @@ Commit message
         [ jfern: Apply feedback from Sebastian to remove rcu_check_boost_fail() ]
     
         Signed-off-by: Joel Fernandes <jfern@kernel.org>
    +    Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    +    Tested-by: Paul E. McKenney <paulmck@kernel.org>
     
      ## kernel/rcu/rcu.h ##
     @@ kernel/rcu/rcu.h: static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
4:  66bf2bb52aa0 ! 4:  89de9f2ec120 doc: Document rcutorture.test_boost_reader_ms
    @@ Commit message
         kernel-parameters.txt.
     
         Signed-off-by: Joel Fernandes <jfern@kernel.org>
    +    Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    +    Tested-by: Paul E. McKenney <paulmck@kernel.org>
     
      ## Documentation/admin-guide/kernel-parameters.txt ##
     @@ Documentation/admin-guide/kernel-parameters.txt: Kernel parameters
5:  88332b3b02c5 < -:  ------------ rcu: Add rcutree.boost_disable to disable priority boosting at runtime
6:  02867b20df51 ! 5:  67d1712c26ec doc: Document rcutree.boost_disable
    @@ Metadata
     Author: Joel Fernandes <jfern@kernel.org>
     
      ## Commit message ##
    -    doc: Document rcutree.boost_disable
    +    rcutorture: Add boost_disable to disable RCU priority boosting
     
    -    Add the new rcutree.boost_disable parameter to kernel-parameters.txt.
    +    CONFIG_RCU_BOOST is now enabled automatically for preemptible RCU and
    +    cannot be turned off, so rcutorture's BUSTED-BOOST scenario, which is
    +    meant to show that rcutorture detects broken priority boosting, can no
    +    longer break it.  Add an rcutorture.boost_disable parameter that keeps
    +    rcu_spawn_one_boost_kthread() from creating the boost kthreads, which
    +    gives that scenario a way to break boosting.
    +
    +    The parameter only has an effect when rcutorture is built in, because
    +    the kthreads are created during boot.  Document it in
    +    kernel-parameters.txt.
    +
    +    [ jfern: Apply feedback from Sebastian to not create the boost kthread ]
    +    [ jfern: Apply feedback from Sebastian to limit this to rcutorture ]
    +    [ jfern: Apply feedback from Sebastian to fold the docs into this patch ]
     
         Signed-off-by: Joel Fernandes <jfern@kernel.org>
    +    Tested-by: Paul E. McKenney <paulmck@kernel.org>
     
      ## Documentation/admin-guide/kernel-parameters.txt ##
     @@ Documentation/admin-guide/kernel-parameters.txt: Kernel parameters
    - 			Set maximum number of finished RCU callbacks to
    - 			process in one batch.
    - 
    -+	rcutree.boost_disable=	[KNL]
    -+			Disable RCU priority boosting at runtime, even in
    -+			kernels built with CONFIG_RCU_BOOST=y.  This is
    -+			for testing the boost tests, for example by the
    -+			rcutorture BUSTED-BOOST scenario, and should not
    -+			be used otherwise.
    + 			periods, but in jiffies.  The default of zero
    + 			says no holdoff.
    + 
    ++	rcutorture.boost_disable= [KNL]
    ++			Do not create the RCU priority-boost kthreads, so
    ++			that RCU priority boosting never happens.  This
    ++			is for testing that rcutorture detects broken
    ++			boosting, as in the BUSTED-BOOST scenario, and
    ++			should not be used otherwise.  It has an effect
    ++			only if rcutorture is built in, because the
    ++			kthreads are created during boot.
    ++
    + 	rcutorture.fqs_duration= [KNL]
    + 			Set duration of force_quiescent_state bursts
    + 			in microseconds.
    +
    + ## kernel/rcu/rcu.h ##
    +@@ kernel/rcu/rcu.h: bool rcu_is_task_rcu_boosted(void);
    + static inline bool rcu_is_task_rcu_boosted(void) { return false; }
    + #endif // #else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
    + 
    ++extern bool rcu_torture_boost_disable;
    + 
    + #endif /* __LINUX_RCU_H */
    +
    + ## kernel/rcu/rcutorture.c ##
    +@@ kernel/rcu/rcutorture.c: static char *torture_type = "rcu";
    + module_param(torture_type, charp, 0444);
    + MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
    + 
    ++// Global because tree_plugin.h reads it during boot.
    ++bool rcu_torture_boost_disable;
    ++module_param_named(boost_disable, rcu_torture_boost_disable, bool, 0444);
    ++MODULE_PARM_DESC(boost_disable, "Do not create RCU boost kthreads, to test boost-failure detection.");
    ++
    + static int nrealnocbers;
    + static int nrealreaders;
    + static int nrealfakewriters;
    +
    + ## kernel/rcu/tree_plugin.h ##
    +@@ kernel/rcu/tree_plugin.h: static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
    + 	if (rnp->boost_kthread_task)
    + 		return;
    + 
    ++	// With no boost kthread, rcu_initiate_boost() never boosts.
    ++	if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) && rcu_torture_boost_disable)
    ++		return;
     +
    - 	rcutree.csd_lock_suppress_rcu_stall=	[KNL]
    - 			Do only a one-line RCU CPU stall warning when
    - 			there is an ongoing too-long CSD-lock wait.
    + 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
    + 			   "rcub/%d", rnp_index);
    + 	if (WARN_ON_ONCE(IS_ERR(t)))
7:  b172a791f0a1 ! 6:  99a7a7cfe376 rcutorture: Make BUSTED-BOOST disable RCU priority boosting
    @@ Commit message
     
         BUSTED-BOOST is supposed to fail because priority boosting is broken,
         but boosting is now always built in for preemptible RCU, so the
    -    scenario passed.  Boot it with rcutree.boost_disable=1 so that it again
    +    scenario passed.  Boot it with rcutorture.boost_disable=1 so that it again
         exercises rcutorture's ability to detect missing priority boosting.
     
         Testing: kvm.sh --configs BUSTED-BOOST --duration 10 now ends FAILURE,
    -    with 81 of 84 boost intervals reporting:
    +    with 82 of 84 boost intervals reporting:
     
                 rcu_torture_boost boosting failed
                 Boost inversion: reader got only 203 of 2000 ms CPU in 4003 jiffies
     
         Without the parameter the same scenario passed with no boost failures.
     
    +    [ jfern: Follow the rename to rcutorture.boost_disable ]
    +
         Signed-off-by: Joel Fernandes <jfern@kernel.org>
    +    Tested-by: Paul E. McKenney <paulmck@kernel.org>
     
      ## tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot ##
     @@ tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot: rcutree.gp_cleanup_delay=3
      rcutree.kthread_prio=2
      threadirqs
      rcutree.use_softirq=0
    -+rcutree.boost_disable=1
    ++rcutorture.boost_disable=1

base-commit: 83984be2e4ae1aee94a0f6a65284cde82c2dc0eb
-- 
2.54.0

