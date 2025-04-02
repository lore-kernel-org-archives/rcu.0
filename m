Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE838DE1;
	Wed,  2 Apr 2025 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619902; cv=none; b=CBMDhZV5QROFFrEhNFPsZjtnKnEwJRb8ts8Ys3gkIPtN78Z1YBdgVUWVsaXFAmOOr1Ew6STCEBMrDBrfHPnLew2F0G3h+Q7GN4bsoydUgoMfmHS2y5MEVLouGi8eUAkiRAf0ix5MnbIJPWn2ajPv2rWAes3QhtRg/s3+BtWwZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619902; c=relaxed/simple;
	bh=a0GdHAAg36usb9mQAnpTtq8MdLA+2pFVqyVoOrfvCvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtZqjq9G5EfpVYN75csfJSLex38K/OwgCresnHrtEwkrX4dJ6xpYAjllEtSGaEJC3SUTKwImTdjknhUlMeq1IupKG9qu3lwI+VAkCERY7kAKuUQl1GTE7bWnpMxuFKwmFS5568FwypyVxmT9kRDVOvSUEKdEb5T6lJsJeYWEdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj+lpFdo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj+lpFdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A40C4CEDD;
	Wed,  2 Apr 2025 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743619901;
	bh=a0GdHAAg36usb9mQAnpTtq8MdLA+2pFVqyVoOrfvCvw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Bj+lpFdoONC0tRN/vK2b6x1rjWhdFYWqY1QsXIPJQO4nwsooKfPCoI4KThQl8zZlW
	 cBLz8bjzlHwm4OArISaBbfqJorreZbc0twTbpZZhLn3+x5onFEMJ5GLltER7LAAXZO
	 xgw1c7DnxaglnJldR6pPwo0gm4X/zCJ7zpaIpOr3AsTJsYadm4RkslcGyAB96ODzc1
	 Q55MKpfJlBBOJT3SBJ54VdL6HTKwto4unuyj6ye2huT846cF75BRzrzzj98BB/WdFU
	 PM2EqUxwtWNJg/xiXBbCZvdbwtWYcYYz5JheMJgbAoHR9UcXODnbou49kqFq94lemd
	 Ptp21Xp8msz2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1E524CE079A; Wed,  2 Apr 2025 11:51:41 -0700 (PDT)
Date: Wed, 2 Apr 2025 11:51:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 04/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
Message-ID: <52b014c0-8f3e-401a-9598-99a6a264601c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-4-paulmck@kernel.org>
 <20250402074211.tibxg1fJ@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402074211.tibxg1fJ@linutronix.de>

On Wed, Apr 02, 2025 at 09:42:11AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-03-31 14:03:06 [-0700], Paul E. McKenney wrote:
> > The torture.sh --do-rt command-line parameter is intended to mimic -rt
> > kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
> > mimicking more precise.
> > 
> > Note that testing of RCU priority boosting is disabled in favor
> > of forward-progress testing of RCU callbacks.  If it turns out to be
> > possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
> > testing of both, both will be enabled.
> 
> Not sure what you point at here: You can build a PREEMPT_RT kernel and
> RCU boosting is enabled by default. You could disable it if needed.

The issue is not the enabling of RCU priority boosting itself, but
instead the rcutorture testing of it.  And if it makes you feel better,
this problem is now sometimes affecting mainline testing.  So maybe
rcutorture will need to do only one form of overload testing at a time,
maybe using a mutex or some such.

> Config wise you set CONFIG_PREEMPT_LAZY=n but in general
> CONFIG_PREEMPT_LAZY=y should be used if possible. The preemption while
> holding a sleeping spinlock is somehow bad for performance if a lot of
> threads ask for it. But then it probably doesn't matter for testing.

For general use, agreed.  But in this case, I want CONFIG_PREEMPT_RT=y,
so I must also end up with CONFIG_PREEMPT_LAZY=n, right?  Though to your
point, that happens by default, so I don't need to explicitly specify it.

Or if the concern is general rcutorture testing of CONFIG_PREEMPT_LAZY=y,
that is done by the TREE07 and TREE10 rcutorture scenarios, both of
which I run regularly.

> You do set rcupdate.rcu_normal and rcupdate.rcu_expedited but RT has
> rcu_normal_after_boot set by default. Not sure if this makes any
> difference but I *think* that normal wins here.

I should definitely align with -rt common practice regardless.  Plus
rcupdate.rcu_normal_after_boot is set by default by PREEMPT_RT, so
there is no need to separately specify it.

On the other hand, the variant that does use expedited grace periods
needs to explicitly disable rcu_normal_after_boot.

Do real-time kernels normally enable NO_HZ_FULL?  Or do event-driven
real-time workloads prefer NO_HZ_IDLE?  I am currently guessing
NO_HZ_IDLE.  (I test NO_HZ_FULL in conjunction with expedited grace
periods in the second run.)

Please see incremental patch below, which I am testing.

						Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index ed43aea91c7d9..6d1a84f3f6315 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -481,13 +481,13 @@ then
 	# -rt doesn't like its interaction with testing of callback
 	# flooding.
 
-	# With all post-boot grace periods forced to normal.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_normal=1"
-	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_LAZY=n CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y" --trust-make
+	# With all post-boot grace periods forced to normal (default for PREEMPT_RT).
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_IDLE=y" --trust-make
 
 	# With all post-boot grace periods forced to expedited.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_expedited=1"
-	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_LAZY=n CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_normal_after_boot=0 rcupdate.rcu_expedited=1 rcutorture.preempt_duration=0"
+	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_FULL=y" --trust-make
 fi
 
 if test "$do_rcu_rust" = "yes"
