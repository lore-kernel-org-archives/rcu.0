Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0501391;
	Tue, 13 Jan 2026 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262613; cv=none; b=YsDnTdh3AuZILSzMVqv1qGjVy4HM9uoTyk/4B3xhr8NQ7QT8Dk3ACPpEGNDx2D+GBI+uah6Otx4HhwP/U9XcSHFNeL4ICsASfxGsiD9+zUU3dMBjBCZBp+TiBJTwie3p6EjI6/7mx3i0anukSDXpC7WUU3vDVHH0doCgqrtpM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262613; c=relaxed/simple;
	bh=KCXXBX8HfRi2zwIot219OOx2+veFSi9aFGIlHXTTZ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L37yIZFeGEWXcsfmQnFD3gcM3EkoRVuGZUaUm3XSD+8gldyy3QlfNNEmNmFJln6XYE7phObAIDJ6UyhjUx4C+uIMbVovZU6NRBTF7kmgGPg1KvDf0tGqJh7pum/ElBG1VZ7SVPcsBv/L6leYSyS18I5cQK25c2xKqZ9uejd9I0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYfZCUxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYfZCUxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642A0C116D0;
	Tue, 13 Jan 2026 00:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262613;
	bh=KCXXBX8HfRi2zwIot219OOx2+veFSi9aFGIlHXTTZ9A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MYfZCUxKGHvr/LRo70nn/jcRYJjD5+wuGDdXE5RQQCtxV8HbIS5o9OSuIyuWOchvi
	 YI3/UK2AONix8RoSJLqOOz8wkg3keLftl3CsLRwjW1CWmbS+P3Zmoa1WzhVqVJ/UZg
	 nWSe5XQbXZhcd+nbyvku2aDkak3rEr3Z0LdjoxIKpmW0L0IbtIRpRVSQBNDFYHlM/i
	 zcfTvBHXEfrZ/sqMXWAa1o80eb6mVelGdnQBxdCICYCO5gzaHYfXQ30itXru25rvZJ
	 hWxrd1aT4xKhaByBm39yz+tVVKMcc1hDi4dh1m+8Vr4EdrbUU96ARz0g3aXz9BppDl
	 q85kmOuq3CJ2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0AD32CE0A3C; Mon, 12 Jan 2026 16:03:33 -0800 (PST)
Date: Mon, 12 Jan 2026 16:03:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <8dbba75f-329d-4e86-b61e-38be0b101b0b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <aWUp2kDi5gjGKOtR@milan>
 <aWU9HRcs4ghazIRg@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWU9HRcs4ghazIRg@linux.ibm.com>

On Mon, Jan 12, 2026 at 11:57:41PM +0530, Vishal Chourasia wrote:
> Hello Joel, Paul, Uladzislau,
> 
> On Mon, Jan 12, 2026 at 06:05:30PM +0100, Uladzislau Rezki wrote:
> > On Mon, Jan 12, 2026 at 08:48:42AM -0800, Paul E. McKenney wrote:
> > > On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> > > > 
> > > > 
> > > > > On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > 
> > > > >> 
> > > > > Sounds good to me. I agree it is better to bypass parameters.
> > > > 
> > > > Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> > > > 
> > > > I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> > > 
> > > This would require increasing the scalability of this optimization,
> > > right?  Or am I thinking of the wrong optimization?  ;-)
> > > 
> > I tested this before. I noticed that after 64K of simultaneous
> > synchronize_rcu() calls the scalability is required. Everything
> > less was faster with a new approach.
> 
> It is worth noting that bulk CPU hotplug represents a different stress
> pattern than the "simultaneous call" scenario mentioned above.
> 
> In a large-scale hotplug event (like a SMT mode switch), we aren't
> necessarily seeing thousands of simultaneous synchronize_rcu() calls.
> Instead, because CPU hotplug operations are serialized, we see a
> "conveyor belt" of sequential calls. One synchronize_rcu() blocks, the
> hotplug state machine waits, it unblocks, and then the next call is
> triggered shortly after.
> 
> The bottleneck here isn't RCU scalability under concurrent load, but
> rather the accumulated latency of hundreds of sequential Grace Periods.
> 
> For example, on pSeries, onlining 350 out of 400 CPUs triggers exactly
> 350 calls at three different points in the hotplug state machine. Even
> though they happen one at a time, the sheer volume makes the total
> operation time prohibitive.
> 
> Following callstack was collected during SMT mode switch where 350 out
> of 400 CPUs were onlined,
> 
> @[
>     synchronize_rcu+12
>     cpuidle_pause_and_lock+120
>     pseries_cpuidle_cpu_online+88
>     cpuhp_invoke_callback+500
>     cpuhp_thread_fun+316
>     smpboot_thread_fn+512
>     kthread+308
>     start_kernel_thread+20
> ]: 350
> @[
>     synchronize_rcu+12
>     rcu_sync_enter+260
>     percpu_down_write+76
>     _cpu_up+140
>     cpu_up+440
>     cpu_subsys_online+128
>     device_online+176
>     online_store+220
>     dev_attr_store+52
>     sysfs_kf_write+120
>     kernfs_fop_write_iter+456
>     vfs_write+952
>     ksys_write+132
>     system_call_exception+292
>     system_call_vectored_common+348
> ]: 350
> @[
>     synchronize_rcu+12
>     rcu_sync_enter+260
>     percpu_down_write+76
>     try_online_node+64
>     cpu_up+120
>     cpu_subsys_online+128
>     device_online+176
>     online_store+220
>     dev_attr_store+52
>     sysfs_kf_write+120
>     kernfs_fop_write_iter+456
>     vfs_write+952
>     ksys_write+132
>     system_call_exception+292
>     system_call_vectored_common+348
> ]: 350
> 
> Following callstack was collected during SMT mode switch where 350 out
> of 400 CPUs where offlined,
> 
> @[
>     synchronize_rcu+12
>     rcu_sync_enter+260
>     percpu_down_write+76
>     _cpu_down+188
>     __cpu_down_maps_locked+44
>     work_for_cpu_fn+56
>     process_one_work+508
>     worker_thread+840
>     kthread+308
>     start_kernel_thread+20
> ]: 1
> @[
>     synchronize_rcu+12
>     sched_cpu_deactivate+244
>     cpuhp_invoke_callback+500
>     cpuhp_thread_fun+316
>     smpboot_thread_fn+512
>     kthread+308
>     start_kernel_thread+20
> ]: 350
> @[
>     synchronize_rcu+12
>     cpuidle_pause_and_lock+120
>     pseries_cpuidle_cpu_dead+88
>     cpuhp_invoke_callback+500
>     __cpuhp_invoke_callback_range+200
>     _cpu_down+412
>     __cpu_down_maps_locked+44
>     work_for_cpu_fn+56
>     process_one_work+508
>     worker_thread+840
>     kthread+308
>     start_kernel_thread+20
> ]: 350

I still suggest that you test on a big system.  There are other sources
of synchronize_rcu() calls than just CPU hotplug.  ;-)

							Thanx, Paul
