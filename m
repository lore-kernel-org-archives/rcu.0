Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAED380FFB;
	Sat, 19 Sep 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776066; cv=none; b=m2EHjFSJW868zkFij1bL/cq8mqBJHngaDx+LGg0mvNIp03BdLP2b22t55PTp4E6RVD8+98MA9BIZVAvbFQEOA8Sdzp0ewvHw7IzpwlqPM1HFA+yub4ZFmqPbvRtwtVg1PsW9RR6/lOzibv66zpEzvFOTBfT52nmJlV+61+uDwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776066; c=relaxed/simple;
	bh=emhGjryoKAzeixDJ+IrrZwVL7nh8IOIJ6cHVlsM6gNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDHFz1NdXj1niF6R4PlAIuuQeC2pW67Q778X1EUguChSung+RVkTg0Oj+f8C3/fzueHQd4QdyuznBML52eDgFaFOB49tLf+RJdo8lZd0DG+a0VaOYuhEuipedbCUlw1gZtP5RmXlXV+MjlUCWKtaBVIiMoHFfYeoos3rFyZ0cvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxrXohui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxrXohui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C55A1F00923;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=3yJCQ8Pquwx+ZNXNfkooAaUAiyLSRGujHC/iL97Z0b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxrXohuic1X8pxbpUlRPtmPNy4MBeRhfI8ebH/thqXFg7CeQjgEAIF0KgWRWHuDMa
	 3O1dWWD9Th7HuzHKhA/+gwH2wK379C1zWg0wjhBPicYrhh6S2Wa/cyJvZHDEQyaSYp
	 ChxyQrKsiXyw9AjyVehac9+4bzAKXUxFdfHMYxxg4kawVRScB8i3OmcEufrqSNtcVl
	 gNzrwKqEf7JM4Ct6FMt5G6ZqYW62vNTIMPm5t5QvZ1V1kYdoMvJXacRVrebjlm2M4/
	 8aaB6svxV6M+jmojzF9GU5sctliHwlNaa8PTx60nMavGHN5/hA1N/qlZ82c6M0N+nl
	 JMxwV49wfVTuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D536CE0E63; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 18/28] doc: Add hazptrtorture module parameters
Date: Fri, 18 Sep 2026 17:00:46 -0700
Message-Id: <20260919000056.3132131-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the hazard-pointer-torture module parameters to kernel-parameters.txt.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 .../admin-guide/kernel-parameters.txt         | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..e93768fd5c55 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1964,6 +1964,102 @@ Kernel parameters
 			for 64-bit NUMA, off otherwise.
 			Format: 0 | 1 (for off | on)
 
+	hazptrtorture.defer_modulus= [KNL]
+			Defer release of the hazard pointer on average
+			one out of the specified number of times.  Zero
+			disables.  Negative one defaults to 1,000 times
+			nr_cpu_ids, unless hazptr.kthread_do_pending_ms is
+			equal to zero, in which case it instead defaults
+			to zero (disabled).
+
+	hazptrtorture.irq_acquire= [KNL]
+			Acquire hazard pointers from an irq handler on average
+			one out of the specified number of times.  Zero
+			disables.  Negative one defaults to 1,000 times
+			nr_cpu_ids.
+
+	hazptrtorture.irq_release= [KNL]
+			Release hazard pointers from an irq handler on average
+			one out of the specified number of times.  Zero
+			disables.  Negative one defaults to 1,000 times
+			nr_cpu_ids.
+
+	hazptrtorture.kthread_do_pending_ms= [KNL]
+			Interval between cleanup of pending (deferred)
+			hazard-pointer releases in milliseconds.
+			Zero disables.	Negative one defaults to three
+			milliseconds, unless hazptr.kthread_do_pending_ms
+			is equal to zero, in which case it instead
+			defaults to zero (disabled).
+
+	hazptrtorture.nreaders= [KNL]
+			Number of hazard-pointer reader kthreads, each
+			of which repeatedly acquires and releases hazard
+			pointers.  If the value is zero, one reader
+			is spawned.  If the value is less than zero,
+			the absolute value is multiplied by the number
+			of online CPUs at initialization time.
+
+	hazptrtorture.nwriters= [KNL]
+			Controls whether or not there is a writer.
+			There is at most one writer, so this value must
+			be zero or one.
+
+	hazptrtorture.onoff_holdoff= [KNL]
+			Set time (s) after boot for CPU-hotplug testing.
+
+	hazptrtorture.onoff_interval= [KNL]
+			Set time (jiffies) between CPU-hotplug operations,
+			or zero to disable CPU-hotplug testing.
+
+	hazptrtorture.preempt_duration= [KNL]
+			Set duration (in milliseconds) of preemptions
+			by a high-priority FIFO real-time task.  Set to
+			zero (the default) to disable.	The CPUs to
+			preempt are selected randomly from the set that
+			are online at a given point in time.  Races with
+			CPUs going offline are ignored, with that attempt
+			at preemption skipped.
+
+	hazptrtorture.preempt_interval= [KNL]
+			Set interval (in milliseconds, defaulting to one
+			second) between preemptions by a high-priority
+			FIFO real-time task.  This delay is mediated
+			by an hrtimer and is further fuzzed to avoid
+			inadvertent synchronizations.
+
+	hazptrtorture.reader_sleep_us= [KNL]
+			Set occassional read-side sleep time in
+			microseconds, defaulting to zero for disabled.
+
+	hazptrtorture.shuffle_interval= [KNL]
+			Set task-shuffle interval (seconds).  Shuffling
+			tasks allows some CPUs to go into dyntick-idle
+			mode during the hazptrtorture test.
+
+	hazptrtorture.shutdown_secs= [KNL]
+			Set time (s) after boot system shutdown.  This
+			is useful for hands-off automated testing.
+
+	hazptrtorture.stat_interval= [KNL]
+			Time (s) between statistics printk()s.
+
+	hazptrtorture.stutter= [KNL]
+			Time (s) to stutter testing, for example,
+			specifying three seconds (the default) causes
+			the test to run for three seconds, wait
+			for five seconds, and so on.  This tests the
+			hazard-pointers primitives' ability to transition
+			abruptly to and from idle.  Setting this to zero
+			disables stuttering.
+
+	hazptrtorture.torture_type= [KNL]
+			Specify the hazard-pointers implementation
+			to test.
+
+	hazptrtorture.verbose= [KNL]
+			Enable additional printk() statements.
+
 	hd=		[EIDE] (E)IDE hard drive subsystem geometry
 			Format: <cyl>,<head>,<sect>
 
-- 
2.40.1

