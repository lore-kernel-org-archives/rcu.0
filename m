Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAC23D283;
	Thu, 16 Jul 2026 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161096; cv=none; b=m+Igw28ipJDHbxgg6ngILIXj4nA+DbgqPpSe2suBrMcVjBU29bLs7lPpo8OflnnIjjjwlF9adQnCJcW/BCWBoKil/1bJDbetQzecZWHVtm5hp57/uh+xDxvG7o7Kt07gKJfuSa+ngujZxidRf7UDkBF+seMPSKKMa8kFU2HXLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161096; c=relaxed/simple;
	bh=gpQurLnFPrnkDNe+MWnj+a7OVfK1lfa352oLOHf8xQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXXQReZiDIfWJvm8s2swGK7rgec+Zla8T0ERQ0QzA3P+6vnUQkzSuzcsvrVmbj0gqsmkpDA3RIQW5X/8h93T2iAnhh7xUvzSUmwm5SGWuyw32FifA8Ou1sA9PueaH1apkoApydtreFHmBtqW1vOS2TLVZUR2SCIFYSe3kla8iw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLPtPVIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLPtPVIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A4B1F00ACA;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=Tk/d40pMOZOxOEG/n4oOtTc7jUK/Df01qF5T3EGToyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DLPtPVIj2ZbrlkywyeGSZfEQGXe3GTMlgQZm71TqX2bclYUyPsyYX9c1uVxEWseOf
	 Q819E0GrO3jc+6DRFgXSYGDG/w8VndAQb13qLlsyTVgGtVhokX8cgwC6Njzeoos3ue
	 PQ8PFtqa/K1X68PZcENkTgRHIIyk1FzOUoR0lrnT9Mft+O4RfRZ82TPw87D4fnw1A6
	 skI7qDC05kdO3oR3ATOrZokJUO8c0tTmgNb4SwKb+FqL6Ef4AX4twbjIeJFoBz8bjq
	 QeIW8GXpOFBylUn4oV9XnCxZ8U+Z93PEEE1eSupDnWi6eNDA9UJfwwDjCaYeO2+wGt
	 cYX96dM5k7D1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F2E6CE0F71; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 18/24] doc: Add hazptrtorture module parameters
Date: Wed, 15 Jul 2026 17:18:03 -0700
Message-Id: <20260716001809.11084-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the hazard-pointer-torture module parameters to kernel-parameters.txt.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f2281..7977ce806a2647 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1951,6 +1951,102 @@ Kernel parameters
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

