Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77E155A5F;
	Mon,  5 Aug 2024 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860322; cv=none; b=fpyW3/rTpzHOEJlT5IFq3ZwU9+e69d3j4m5Ey+QwnuJqd8QWXtQwDXmDDjRPc5HLPX4Xoi8KTlXWUAL860I9FwwmVTqX+mIsfwqzaXI1vfqslIqYceIw43XADqek4u5e4ilgjjGJ24Bi8LhYi0r5BlvD8sD5MmYZkBQ5+AvtIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860322; c=relaxed/simple;
	bh=IJ2jshHO8kyHIVYmbsMx94o5MjqmTKCql5heFidDMSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qylAsWAc9WacyoTxKWWWLux7fpsoHUQrbLZvOijqlkiqt//XXusFx+i/EXLhyoBvbnvJoOAr+/EM0m9fxWkt93i+ZfEp4XVmFmvJmPSILJxBzTqyJ2/CY+w3L1A68Zn82MYmOS6VQIJi78ejgYQLGWfi1+9L/VWYoro6eW8crHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHVXNrkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHVXNrkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC38DC32782;
	Mon,  5 Aug 2024 12:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722860322;
	bh=IJ2jshHO8kyHIVYmbsMx94o5MjqmTKCql5heFidDMSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHVXNrkIwjmpT/4yWLnyBrDnrjk6tK9evHTF3PCdJ/6OJguOrzPQSTTFvTvbi6SbN
	 5ibuqOVpRtOQg6RT5448Cr49t2gw16D3DiWSb7OgMsguqIGGLnwnobKNkrtrqGzTuD
	 6tPd2mDM5vEH2BwZTfjQrBw/3JUP13bvBAed9sTqHMTv4uGTHxdroyVzde1ihedSBJ
	 BdUVFtxX/fQkuNTjXvrTEDAhAThUJ5IuUWGSlxXMVttZwZ5sGWsDxi53PxDKpuqoOB
	 7m3XdS/qVqN6UaofLtlu2fK0vT6kvl3d7tsJlUjMcUGNTc0zhYIkIaqI7rl/Mtpy4z
	 MtiTRs/Ym10kw==
Date: Mon, 5 Aug 2024 14:18:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: RCU-Task[-Trace] VS EQS (was Re: [PATCH v3 13/25]
 context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*())
Message-ID: <ZrDDH8XWczouHJdb@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
 <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
 <ZqlmjVyWXIneklCm@pavilion.home>
 <30c6d4aa-7598-4dc1-8592-7533d64714c2@paulmck-laptop>
 <Zqot4NpepOORtNzv@localhost.localdomain>
 <6c915a8d-983a-4cbb-8d89-01e326a16876@paulmck-laptop>
 <20240805090122.GH37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805090122.GH37996@noisy.programming.kicks-ass.net>

Le Mon, Aug 05, 2024 at 11:01:22AM +0200, Peter Zijlstra a écrit :
> On Fri, Aug 02, 2024 at 09:32:08PM -0700, Paul E. McKenney wrote:
> 
> > Huh.  One reason for the current smp_call_function_single() in
> > cpuhp_report_idle_dead() was some ARM32 CPUs that shut down caching on
> > their way out.  this made it impossible to use shared-variable-based
> > CPU-dead notification.  I wonder if Arnd's deprecation schedule
> > for ARM32-based platforms will allow us to go back to shared-memory
> > notification, which might make this sort of thing easier.
> 
> All those idle paths should be doing ct_cpuidle_enter(), which includes
> telling RCU the CPU is going idle, no?
> 
> I cleaned all that up a while back.

On every architectures? That would be a good news, as we could then remove
the CONFIG_TASKS_TRACE_RCU_READ_MB dance.

There is still some vulnerable path on CPU hotplug down path once
cpuhp_complete_idle_dead() is executed. The dead CPU may still call a bunch
of general purpose functions (the exit path of smp_call_function_single()
and the exit of cpuhp_report_idle_dead()). And this will become worse once
we remove TASK-RUDE and rely only on rcutree_report_cpu_dead().

Thanks.
