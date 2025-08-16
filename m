Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3479EA;
	Sat, 16 Aug 2025 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755320098; cv=none; b=PiUf6kYKrN/ONDGaq8zbgjLPcis+SP+zHf+GaQXo5dpiDLgSGEzPKJvqMBQdHscyxmX1hfTsvkjQVkCXpQStdSM6QFwMdON55wfGOhZWfuA0wGmN5n0u9+fu3Utf/jmDI9sIoyLnRzbJk9d8gTdVgobnR7KpB2LyjPHg2L7sCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755320098; c=relaxed/simple;
	bh=h+o3WSXaw2RyG9oM71im2NRh43BA9eu7Ciwz1kBTYg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNgQviuspe4vCVVuoMsJ3PHkqgvpUooQ1CAi8l3a5g+vaymOwPUqW0/rDUVTJFK9XbsdfEk4QmuK/LzyRSkdU+otNvDQp81wn3Hd0LOk5dI2C/FsIQNVBHTftTWyI3g/cprZTAWoGnFp8B0aLdOhI7zsdV10OOUdG2lhypMHeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksW83XI+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksW83XI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA71C4CEEF;
	Sat, 16 Aug 2025 04:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755320098;
	bh=h+o3WSXaw2RyG9oM71im2NRh43BA9eu7Ciwz1kBTYg8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ksW83XI+2TgIE37dDMzx7xh78RWjjuvDyKbFgSYUIkbcJ3RBBLWTepoXdCwX/gwMT
	 tTPA/pNFZqHLBzKVaxt4m7q6oEEkG5c2i/NMDJizwok7njy5k9ogL0+4IxIVYYsUuW
	 uRta3bPPzejKwR/76ttjQbLsGHeyYqTyXIo8Q5mRdHMa2+cwfIRdpPZUfQvFFmFykF
	 +7xc6CdsD2ld1ChMPVDjQKLBWP22yMUFNNZ81y/6Rpo3VuRrSC8jFwGYN1uwLAIdyc
	 a83vzqVUQYG6wvpxNjIoy5uIpbMIGoMoIJJvTIa/1chEMZYsHk0jhawojXT+DiY2Zp
	 6MEf2Lg2f2KTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A888CCE0ADB; Fri, 15 Aug 2025 21:54:57 -0700 (PDT)
Date: Fri, 15 Aug 2025 21:54:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/3] doc: Update whatisRCU.rst for recent RCU API
 additions
Message-ID: <189f6091-016f-4a96-a1f1-321231aeddaf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
 <20250816000007.2622326-1-paulmck@kernel.org>
 <aKAA3OHvISThlUX-@archie.me>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKAA3OHvISThlUX-@archie.me>

On Sat, Aug 16, 2025 at 10:54:04AM +0700, Bagas Sanjaya wrote:
> On Fri, Aug 15, 2025 at 05:00:05PM -0700, Paul E. McKenney wrote:
> > +RCU: Initialization/cleanup/ordering::
> > +
> > +	RCU_INIT_POINTER
> > +	RCU_INITIALIZER
> > +	RCU_POINTER_INITIALIZER
> > +	init_rcu_head
> > +	destroy_rcu_head
> > +	init_rcu_head_on_stack
> > +	destroy_rcu_head_on_stack
> > +	SLAB_TYPESAFE_BY_RCU
> > +
> > +
> > +RCU: Quiescents states and control::
> > +
> > +	cond_resched_tasks_rcu_qs
> > +	rcu_all_qs
> > +	rcu_softirq_qs_periodic
> > +	rcu_end_inkernel_boot
> > +	rcu_expedite_gp
> > +	rcu_gp_is_expedited
> > +	rcu_unexpedite_gp
> > +	rcu_cpu_stall_reset
> > +	rcu_head_after_call_rcu
> > +	rcu_is_watching
> > +
> > +
> > +RCU-sync primitive:
> > +
> > +	rcu_sync_is_idle
> > +	rcu_sync_init
> > +	rcu_sync_enter
> > +	rcu_sync_exit
> > +	rcu_sync_dtor
> 
> Looks like inconsistent (normal paragraph instead of literal code block like
> the rest).

As in the "RCU-sync primitive:" needs another colon (":") at the end of
that line?  If so, agreed, will fix on next rebase, and thank you!

							Thanx, Paul
