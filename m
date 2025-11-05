Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270163B7A8;
	Wed,  5 Nov 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383622; cv=none; b=Hd1SzgUL4jeUSV1ItKBAFZsV0PDEhRLXtQ0EpyYyMYYwBaO2zNadGMHURS94347U74tDGOx5iIRoswIEIrRF7hGbH8AUB38JfHf484eL3+mPFRYmobh5rs1/gZ+2x8prf9ev6TDjltobiBMq6yefXvPsCqgo4pwbeMzfaA8KyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383622; c=relaxed/simple;
	bh=suQHIvjs+aRI5k1hyeEyvJAZvvbgAcbHbJHVHeR4at4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmeXvtDq5RZowbu9iVMi6s3wALZNO3DPCjyrcQMyhHeHwgWfz2niCHDa/nPVY0sbIfvMcyNRErNyCAfblckszgRdgzunaomfb4qj3WMEqGfQ2bKfP2FKKGtk0PvjdUWH5IRwJNfeuwwae3xvNgrQb2F4llJ5JijtCNiOIW4HjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLJ9PZnm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLJ9PZnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F26C4CEF5;
	Wed,  5 Nov 2025 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383622;
	bh=suQHIvjs+aRI5k1hyeEyvJAZvvbgAcbHbJHVHeR4at4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLJ9PZnmfr3ilHsBfu5uQeWxw71d7T9qVgG6Cb1UOlkWh18msQ1k+JCmKHnjz+vOp
	 +zoy9Eas7ZY1VfwfsCsvB4YBVy6fEt1zOuFxN6pOHQw6pI7XiVndUYDa+i964idh7B
	 1U21dn0FeykcU7PdC90AMb4p3Xz/ksybLLOCnbByfzOrNNEH1QY8FXA7Br3oK1Ym5j
	 3a4gXFEgaLleNmq9NhqP80wgqSXbqJAt9vpc8Vo21vuCn296r9bhybeVsP6lgc6a0P
	 UHWkOXsXPLOSzHagd2dde46ytFe89ioPL/dFMdXtSKcVW1s0RdXDvzOyT2qiP6r3iy
	 n1kTJ8SZAJmGA==
Date: Thu, 6 Nov 2025 00:00:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 0/16] SRCU updates for v6.19
Message-ID: <aQvXA3A5XHn-Tjhh@pavilion.home>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>

Le Wed, Nov 05, 2025 at 12:31:00PM -0800, Paul E. McKenney a écrit :
> Hello!
> 
> This series creates an srcu_expedite_current() function that allows
> after-the-fact expediting of SRCU grace periods, adds a DEFINE_SRCU_FAST()
> that further speeds things up by removing a conditional branch from
> srcu_read_lock_fast*(), updates documentation, uses SRCU-fast to guard
> event traces in PREEMPT_RT kernel (thus making such kernels safe for
> event tracing), adds srcu_read_{,un}lock_fast_updown() functions that are
> compatible with srcu_down_read() and srcu_up_read(), but do not permit
> use in NMI handlers (to permit further optimization of SRCU-fast readers
> by relieving them of the need to deal with irq/softirq/NMI handlers with
> unbalanced lock/unlock calls), and optimizes SRCU-fast-updown for large
> ARM servers that use LSE.  It is expected that this optimization will be
> obsoleted by some arm64 architecture-specific work:
> 
> 	https://lore.kernel.org/all/aQU7l-qMKJTx4znJ@arm.com/
> 
> The patches are as follows:
> 
> 1.	Permit Tiny SRCU srcu_read_unlock() with interrupts disabled.
> 
> 2.	Create an srcu_expedite_current() function.
> 
> 3.	Test srcu_expedite_current().
> 
> 4.	Create a DEFINE_SRCU_FAST().
> 
> 5.	Make grace-period determination use ssp->srcu_reader_flavor.
> 
> 6.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
> 
> 7.	Require special srcu_struct define/init for SRCU-fast readers.
> 
> 8.	Make SRCU-fast readers enforce use of SRCU-fast definition/init.
> 
> 9.	Update for SRCU-fast definitions and initialization.
> 
> 10.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.
> 
> 11.	Mark diagnostic functions as notrace.
> 
> 12.	Add SRCU_READ_FLAVOR_FAST_UPDOWN CPP macro.
> 
> 13.	Permit negative kvm.sh --kconfig numberic arguments.
> 
> 14.	Create an SRCU-fast-updown API.
> 
> 15.	Optimize SRCU-fast-updown for arm64.
> 
> 16.	Make srcu{,d}_torture_init() announce the SRCU type.
> 
> Changes since v1:
> 
> o	Merge addition and testing of SRCU-fast-updown for bisectability.
> 
> https://lore.kernel.org/all/082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop/
> 
> Many of these patches were previously associated with another series
> that re-implemented RCU tasks trace in terms of SRCU-fast.  This work
> is being deferred pending resolution of the ARM LSE situation on the one
> hand or full debugging of the all-too-clever workaround optimization on
> the other.  ;-)
> 
> https://lore.kernel.org/all/7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop/
> 
> 						Thanx, Paul

Applied to rcu/srcu, thanks!

-- 
Frederic Weisbecker
SUSE Labs
