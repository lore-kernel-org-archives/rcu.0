Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F405187DE;
	Wed, 30 Sep 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787351; cv=none; b=ZMy7uTMv4+6+V22FASfudsUp05cYmUKBbAyfDTYOg3+47HKbbwc/3mfc90vWFNBzJIMlD79PebFUrCRT31KbaTUVR64U7weMTqWAt26eNJ1rlZcXFsTeq/s3zUIdHrDF8RxcSa2sRKnFn29vP5u1+HBfe1gVczcU/AdJfutWmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787351; c=relaxed/simple;
	bh=XpTP6/6qBRzPJ+YzxtRCV4YvNQy0L2llC9O3oYN1+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlggdMv2IAQfmhkAD8zU+xJfxMorPV8XP9WGCnHfwQhHq2X9jvZYM8bbVHGdep7yDFWa0h6RYeaV19YDhOqfDHNMIYrXPMTugOKr5cTK7izxJG1EBNdOxpl/rYKOV3ctXXOlgRw6cQ/fAuktf92T9e/1nnPMuqgv9jbuheawC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT/kZFbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT/kZFbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA14C1F0089A;
	Wed, 30 Sep 2026 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790787349;
	bh=6kOQREggUPmUfErKbWpShQw/0dZzXXRX2f2tagdB6rs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=RT/kZFbNnegr4ZFhIf9q1I1dqGA6Q17R+ijfl28Yse7IpY512zcMIxub9EfV36fZa
	 GMCOHZWZL36WRbkiI0hOcoA6InIKaoguxBOeBa9gmQAW7JyoazCMxBcdCWnaiResgW
	 pDzIfGPYEQBFIh+Pi0W/Vjx0miuk5w/JihiH4LwJr3oz/37MHKHnNhNO70dWy2HyFH
	 8Br6ECJ+xIXovjxLwIP912zS3/VMkmks+XwZ/icigKDtaocyYqhDjXNkfrTgRcZrk8
	 vJWjyreG2uPMaqSGSANNIBbA+O+taPtB1fx3qGDPX0pbl4ClKIIODpZBdJgO9JW0I6
	 zRPF88ck9I9xQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 66A72CE097C; Wed, 30 Sep 2026 09:55:49 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:55:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <254e4bf2-f632-4a95-8853-86c7cd0db8f1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>

On Sun, Sep 27, 2026 at 01:15:39PM -0400, Mathieu Desnoyers wrote:
> On 2026-09-27 12:40, Boqun Feng wrote:
> > On Sun, Sep 27, 2026 at 11:51:31AM -0400, Mathieu Desnoyers wrote:
> > > Introduce a "try acquire" hazard pointer fast path, which performs an
> > > early load of the address to store it into the hazard pointer slot, and
> > > then re-loads that address after a barrier to check whether it has
> > > changed meanwhile.
> > > 
> > > On comparison failure, rather than re-try, guarantee forward progress by
> > > falling back to the __hazptr_acquire slow path on failure.
> > > 
> > > The acquire slow path attempts a try-acquire for any available per-CPU
> > > slot. If that fails, it chains the backup slot into the overflow list,
> > > therefore guaranteeing forward progress for both hazard pointer
> > > read-side and synchronize:
> > > 
> > > - Readers set the wildcard, and then proceed to set the more
> > >    specific address to replace the wildcard.
> > > 
> > > - One synchronize alternates between two overflow list periods,
> > >    scanning each one while readers are added to the other period,
> > >    thus preventing a steady flow of readers from preventing
> > >    synchronize forward progress.
> > > 
> > > With this change, the scan on per-CPU slots don't need to expect a
> > > wildcard anymore, because none can be produced by readers. Wildcards are
> > > only expected within overflow lists.
> > > 
> > 
> > Ok, I was missing something, but I think it's better to call it out.
> > Wildcards can only exist in the overflow lists when the context is not
> > preemptible. In other words, there won't be a preempted readers blocking
> > the synchronize_hazptr() with a wilcard in the overflow list.
> 
> Exactly ! Wildcard slots only exist during the short time-frame of the
> preempt-off read-side code region (few instructions). And with this
> patch, this does not even happen very often, because the fast path don't
> rely on the wildcards.

One advantage of getting rid of the wildcards completely is that it
brings out hazard-pointers resistance to blocking.  Even vCPU preemption
would not do more than block reclamation of the nodes referenced by the
preempted vCPU's current hazard pointers.

							Thanx, Paul
