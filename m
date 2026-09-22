Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF21CD2C;
	Tue, 22 Sep 2026 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121305; cv=none; b=dZg0vicHOU81yxBTJg12vt73AUVJ7YlAj/N7UAjTKCeJxfcytFGNN7sXuEgGKIXecQSDBzaJp/yYTPlpJZ0Ka6Qq7kvHFYiSTqnS58ztv/7m11cNxm/uzXpUEIi2LElHrz6eEmcNtQl+Oz+ZBHvnt8D7iY5oX/Vkwtm4RKMXZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121305; c=relaxed/simple;
	bh=qUucEC3m8jA5FRE2ynavWEU57gXSZqMdFgKpTLSGFmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbfKVcQ0DVpzUqTH7NDaehnPPU/ExbKMp2M1pwiPCzj3ACDOs7PG+FFEQA00/CWYEgmeO1WTtuVYyOi+d/d/RLR26uIK7Xnfjq1UgmtmynwhyDLCtPF+bqHwzKdDpqdxpIqXn1MMv/chYAkT/m6b/KDJDQucA3+bg16K3tgiq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jybksMhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jybksMhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC931F000FF;
	Tue, 22 Sep 2026 23:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790121304;
	bh=HSTbpdipWqzMRlNg31tKiDfkkvrvRX8g7W+v/s5ldjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jybksMhSR2L1IPgBu3PyRqTJhE1dojoiw0vrVjUpoSEschuSADng1ipPUD+5n3hu9
	 l6ienfou/gpwzOR3CP/ZgnQmzc9taCVZbyUkSEWRWM676dSwHFaRoO6ve4hzZq50+K
	 C//0mcMpIdu67TH54FJzGzmrP/O0ZM5P/0txFroM/uLgmSjTbcpHs951qkQfkIQ74T
	 ybbhy8pprRNahyLiDlLCAZI1E6K7FLWk1J4uWM9Evwt6iDBpQj3rlGfFx2kZCylgZN
	 6Petvi7nZTWhFYI/ABQ/SnaT8tJfyifBEUq2qJrUsRGDHo2zaHm5haYdxvBnesUsmp
	 lBTlUNdSj9pOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 25833CE0A73; Tue, 22 Sep 2026 16:55:04 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:55:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	rcu@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	"Harry Yoo (Oracle)" <harry@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
Message-ID: <5100e6d4-8595-4f74-beb5-75512361c2c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-2-puranjay@kernel.org>
 <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com>
 <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>
 <DLM296AAASVA.3IGQUR5NOALQ6@gmail.com>
 <CANk7y0g7ZiF5x2j9hZxc4OqFBOFRSWGj6Y9zj5NrX3M1+L3mQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0g7ZiF5x2j9hZxc4OqFBOFRSWGj6Y9zj5NrX3M1+L3mQA@mail.gmail.com>

On Tue, Sep 22, 2026 at 08:09:44PM +0100, Puranjay Mohan wrote:
> On Tue, Sep 22, 2026 at 7:35 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue Sep 22, 2026 at 2:17 PM UTC, Puranjay Mohan wrote:
> > >> > +     prog = bpf_prog_inc_not_zero(aux->prog);
> > >> > +     if (IS_ERR(prog)) {
> > >> > +             WRITE_ONCE(rhk->armed, 0);
> > >> > +             return -EBADF;
> > >> > +     }
> > >>
> > >> can we drop prog_inc and remove prog pointer from rhk ?
> > >> with something like if (prog->has_call_rcu) rcu_barrier() during prog unload?
> > >
> > > That could work but we would need more than just the calls to
> > > rcu_barrier_tasks_trace() and/or  rcu_barrier(). As the rcu_barrier
> > > only waits for callbacks enqueued before it was called, the registered
> > > callback and re-queue itself and cause problems. So, we would need a
> > > flag that is set before the call to rcu_barrier() which stops further
> > > queueing of callbacks from that program. Also, assuming we add these
> > > barrier calls in bpf_prog_free_deferred() which is runs from
> > > system_percpu_wq, it could make this run for much longer than
> > > expected. What is the motivation for using rcu_barrier() instead of
> > > bpf_prog_inc_not_zero()? is it the 8B pointer in rhk or the atomic
> > > operation in bpf_prog_inc_not_zero()?
> >
> > ok. fair enough. let's keep prog inc.
> >
> > >> > That avoids an allocation and a state machine on the arming path at the
> > >> > cost of 64 bytes per element, 48 of which are used today.
> >
> > What was the thinking here? Why ask all progs to waste 16 bytes
> > for future extensibility that may never happen?
> 
> My broken thought process, rcu_head won't grow anytime soon, I will
> fix it in the next version.

Just confirming that there are no plans to expand rcu_head.  Furthermore,
in the past, such suggestions have not been warmly welcomed, especially by
maintainers having small highly-replicated structures containing rcu_head.
Alternatively, you could say that they were welcomed with considerable
warmth, but of a different sort.  ;-)

							Thanx, Paul
