Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B7503BD6;
	Fri, 18 Sep 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747413; cv=none; b=JcfWRWUxuZIz2Cl519TuW55utkHaaIv2x8rW/8vlpSc31ZI56cHsd6ww4G8m+CZYyeqnYRy8fvcSU+61e2bLsax2X4q27dl96yHY4ChhG6yCGHieNdXNQr7NRmFOsH/9+FEBBjAuZuw75NIsQWYVEwsGGdHF/pgnuLZn08IiMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747413; c=relaxed/simple;
	bh=DB4URamTeFXA1F7Asd/w5fTl+Omd1qMaNbg2C0oPT+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDGgH/IcYldhN30UhnHKqLuhCvPI9qL3vCJIoMUY5DyFYdj5letiSvQUfczVLYX6jRGeqP4HxtqNjz7EEpLmvIqpzytPgrqyMyTtPHbz35tLriIK8eSP+h+vl7xT588ahYA5lEZDRdRTC9IjQ9f3fd5ij91YKayiwET7TCDQDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/H6NXfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/H6NXfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17761F00898;
	Fri, 18 Sep 2026 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747411;
	bh=uhfWBas+aqtYA6p5h+wAL5uuGsiab2VRuj8D1/t4R24=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=h/H6NXfsdvz/KKlkEF4Ez3OoVcqzU8D0r+lC6mbZ/sVBOtPg1IBdWjQVrXMRR0MdV
	 WKCHdLtWaMAu4LqPDfPUgPFiaAJ50PYIsaToPHvOLBbnbmmLfaFusDSzuBa+VHJ4p/
	 4PSWdzWXwNERKPCRSJ+jkh0MBLid1BWzeTrkPeYqgpmle41W2HSotCcVxrJ/BkEsx4
	 rDUQTZNu79asEOlRh2qFfuqevxNRSTzSygPZf5kkxurTp5uc+mVdMEjs9t7om4d483
	 2qNd8J8Waz4QWql6JlIO1IElBKpXAspEW5O9YkSefdEJwSUnqRawXqWbvELH+FiV9w
	 RkvJsC6BZd2pQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6ECFDCE08CF; Fri, 18 Sep 2026 09:03:31 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:03:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
	rcu@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	"Harry Yoo (Oracle)" <harry@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
Message-ID: <ede9d515-a103-461e-8244-656af641c6c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260915154248.3612028-1-puranjay@kernel.org>
 <20260915154248.3612028-2-puranjay@kernel.org>
 <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com>
 <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>

On Fri, Sep 18, 2026 at 11:58:40AM +0100, Puranjay Mohan wrote:
> On Wed, Sep 16, 2026 at 7:41 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > On 9/15/26 4:42 PM, Puranjay Mohan wrote:
> > > BPF programs that manage their own objects have no way to run their own
> > > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> > > free, but returning an index to an allocator or unpinning a resource
> > > once readers are done has no equivalent.  sched_ext's BPF library works
> > > around this today by pushing freed nodes onto a list and having a
> > > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> > > BPF program to reclaim them.
> > >
> > > Add:
> > >
> > >       int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> > >                        int (*callback)(struct bpf_map *map, void *key,
> > >                                        void *value));
> > >
> > > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> > > callback runs as callback(map, key, value) for the element it lives in
> > > and needs no cookie.  A head can only be armed once, which bounds
> > > outstanding work by the number of elements.
> > >
> > > struct bpf_rcu_head holds the callback state inline rather than a
> > > pointer to it, as bpf_timer, bpf_wq and bpf_task_work do, because there
> > > is nothing to cancel and so nothing that has to outlive the map value.
> >
> > I tried to fully embed structure back when implementing bpf_task_work,
> > Alexei rejected that approach, because some of the structures (irq_work) I used
> > are not in our control and might change. I think this applies here: `struct rcu_head rcu`.
> >
> > Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uNGZ3OBQh4V5Zt=WnQ@mail.gmail.com/
> 
> I agree with your analysis. Although struct rcu_head is unlikely to
> change but still, I will change this to a heap allocated version where
> we only keep a pointer and not the structure inline.

You can always use a union, as is done elsewhere in some cases.

That would preserve independence from the rcu_head definition, while
avoiding the need for memory allocation.

							Thanx, Paul
