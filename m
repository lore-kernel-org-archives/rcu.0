Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2283176EF;
	Sat, 16 Aug 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755343719; cv=none; b=A0Z73t5aaiDRiEJpfWuyNViwT4o+b61hD7zxZMeHsZe4kSHMHPSQX8oVKNWICCseHxkm64I2dnLYDa2bQYE98dbFmP3cLqvbygaeZ0Wl34SihGXqw9J/gNV1MMFdPk47QV/yNUcL5eVOdpqotMeKvo8VLevvYCBQK7k0vEpW9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755343719; c=relaxed/simple;
	bh=GdbpJlNPcYe2jq7H+QxjZs4LcOs7iU3fpgNEVLkQGBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo7kbiYt76VzG88ThQ+jKz7jOheZi963zlepWc7GqEbQy/y5ECuJ+Y9YZch/H72Ld424qPtuk/DdpV0BPWJe/646WZ4OtpaoQO7c4BPJuLbeW02ZsPMonoNkuoOi8xiIkPyHPB6DflvghBzCOflYbED7p0GMsj8PLgyNnXT5jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q42GqAOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q42GqAOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2222DC4CEEF;
	Sat, 16 Aug 2025 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755343715;
	bh=GdbpJlNPcYe2jq7H+QxjZs4LcOs7iU3fpgNEVLkQGBs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=q42GqAORk6zxFOBb8tgrXU4oSv5vFS8zrZRdqDOIbTTwdcKCnFo7YBXrZY0Eawwtf
	 yOqN67y0tyt/Idin7KDcMJDvRUeOhKawK89rYVquDGqKyaCpN8Xw8b8KuS3tr0I4RK
	 HvFAxBezZhjWFdF7MKQVUtdsdad1QUFDXWw7PLJv4H8GedlzFOo3oAtKhHdB/okTnb
	 2+zD6oqnR1esR3vrfcSDmNrWGelSbDcCqOG/ti3MjuMUhtS54Una5g5RwgY9f6h8bE
	 ZuQcYWaBFLsT1ISkuaigByIgbljgEph7YTEPOsOrO2G3l4xFCa/eD+5XFfPO03eawI
	 wmQH6BblxBhlA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98706CE0B78; Sat, 16 Aug 2025 04:28:34 -0700 (PDT)
Date: Sat, 16 Aug 2025 04:28:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/3] doc: Update whatisRCU.rst for recent RCU API
 additions
Message-ID: <3b3b8560-7096-43e3-821a-301d2e8a9ffa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
 <20250816000007.2622326-1-paulmck@kernel.org>
 <aKAA3OHvISThlUX-@archie.me>
 <189f6091-016f-4a96-a1f1-321231aeddaf@paulmck-laptop>
 <aKAZPTg-bUcz3ZGY@archie.me>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKAZPTg-bUcz3ZGY@archie.me>

On Sat, Aug 16, 2025 at 12:38:05PM +0700, Bagas Sanjaya wrote:
> On Fri, Aug 15, 2025 at 09:54:57PM -0700, Paul E. McKenney wrote:
> > On Sat, Aug 16, 2025 at 10:54:04AM +0700, Bagas Sanjaya wrote:
> > > On Fri, Aug 15, 2025 at 05:00:05PM -0700, Paul E. McKenney wrote:
> > > > +RCU: Initialization/cleanup/ordering::
> > > > +
> > > > +	RCU_INIT_POINTER
> > > > +	RCU_INITIALIZER
> > > > +	RCU_POINTER_INITIALIZER
> > > > +	init_rcu_head
> > > > +	destroy_rcu_head
> > > > +	init_rcu_head_on_stack
> > > > +	destroy_rcu_head_on_stack
> > > > +	SLAB_TYPESAFE_BY_RCU
> > > > +
> > > > +
> > > > +RCU: Quiescents states and control::
> > > > +
> > > > +	cond_resched_tasks_rcu_qs
> > > > +	rcu_all_qs
> > > > +	rcu_softirq_qs_periodic
> > > > +	rcu_end_inkernel_boot
> > > > +	rcu_expedite_gp
> > > > +	rcu_gp_is_expedited
> > > > +	rcu_unexpedite_gp
> > > > +	rcu_cpu_stall_reset
> > > > +	rcu_head_after_call_rcu
> > > > +	rcu_is_watching
> > > > +
> > > > +
> > > > +RCU-sync primitive:
> > > > +
> > > > +	rcu_sync_is_idle
> > > > +	rcu_sync_init
> > > > +	rcu_sync_enter
> > > > +	rcu_sync_exit
> > > > +	rcu_sync_dtor
> > > 
> > > Looks like inconsistent (normal paragraph instead of literal code block like
> > > the rest).
> > 
> > As in the "RCU-sync primitive:" needs another colon (":") at the end of
> > that line?  If so, agreed, will fix on next rebase, and thank you!
> > 
> 
> Yup, that's what I mean.

Got it, and again, thank you!

							Thanx, Paul
