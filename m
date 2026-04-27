Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9633EDAB2
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315861; cv=none; b=NejaEEDFk1PWFlaF61on62diWFHwFxWs6IoC327ahD3H+ljKzPrCrJ6VvSLwYRumJEUMrrwBj3mqZpNdYlEa3V4Ry4C6WWjODpu8t5jSUXmHindRkBdPLZjri2TuHPVjyOTe/sMI6VN+k+99DWxvI0UrV6IsdMqUet4kh+av2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315861; c=relaxed/simple;
	bh=v55i0w6M0EcnzLsslbo9Aiy+5pDv63hc63AF66VcSWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpDUdrcXMD/2F3P0X7IYyLkdcLSpOxfI9TWtNWo5y9Q0uRz5s11VhX8IedQc3wmLXJVhZCkqoFiTIrlyeD8D9t/53+dAQRgAIPCkK9esdUhceAC6XwSugFsNvdc/G5G3AK1LbBAoOWeWnDBZC7R9RoATqgJvEqYmwj5sUq4pa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0L0AZP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0L0AZP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4D8C19425;
	Mon, 27 Apr 2026 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777315860;
	bh=v55i0w6M0EcnzLsslbo9Aiy+5pDv63hc63AF66VcSWA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=a0L0AZP98abJNOh6BidmAL1LYYkuUK5S75umWl97+QgD6zA2qkGPYHs9hphVGG6Fv
	 6GqWxjWhwlPoj7tsvz62+3peBqK74Hhkw69GSoNtQy1r64Fy+EeCJLVNduxMrujur7
	 eqw/8msUeVFfU5P89Lir+TIColzTYCrfeIyNxtpf3rEEB7qYchzRuapU4G/TGXqknJ
	 T78/cbnkD46LwN8NhuShusptW8ho2zushibx2uY20CtJ+WCENi5BLs2mmakjIopk5V
	 m7iX96x775m8EOThSLL/hNKgVx79C1B3AuQzeKEVJVzlqac+we54AEumElnIQAjp+V
	 JoPVZuNIQXUKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83F12CE0DD4; Mon, 27 Apr 2026 11:51:00 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:51:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <efef0b9c-1b1d-47b0-9c73-b2f9659ec635@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
 <aelxH--hZkCahPv6@hyeyoo>
 <ael8R0vOeZ0Xbcoe@hyeyoo>
 <7526f30a-a008-49bc-a064-07f4e4a7920b@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7526f30a-a008-49bc-a064-07f4e4a7920b@kernel.org>

On Mon, Apr 27, 2026 at 08:08:43PM +0200, Vlastimil Babka (SUSE) wrote:
> On 4/23/26 03:56, Harry Yoo (Oracle) wrote:
> > On Thu, Apr 23, 2026 at 10:08:49AM +0900, Harry Yoo (Oracle) wrote:
> >> On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> >> > On Thu, Apr 16, 2026 at 06:10:18PM +0900, Harry Yoo (Oracle) wrote:
> >> > As discussed or noted earlier, having third argument and check the
> >> > entire path with "if (allow_spin)" is not optimal and is not good
> >> > approach. I do not think it this would be a good fit for mainline.
> >> 
> >> I understand that this pattern is pretty uncommon and adds complexity.
> >> But there is a reason why we're doing this. As Alexei pointed out
> >> earlier, even rare spikes of irq_work hurt performance [1]; that can be
> >> avoided in most cases where the lock is not in use. That's why buddy [2]
> >> and slab [3] accepted this pattern despite the added complexity?
> > 
> > Perhaps we can avoid complicating existing kvfree_rcu batching
> > (and still avoid hurting performance).
> > 
> > Given that kfree_rcu_nolock() (at least BPF) doesn't need to free
> > vmalloc objects, we can make kfree_rcu_sheaf() handle most of frees
> > (slab already knows how to handle allow_spin = false) and fall back to
> > a simple irq_work as Ulad suggested.
> > 
> > But then we need to make kfree_rcu_sheaf() try harder (currently it
> > gives up when it fails to get an empty sheaf from the barn).
> 
> Yeah, if there's a burst of kfree_rcu_nolock() calls, it might exhaust that.

The usual trick is to do an irq-work or similar and have the handler
do the allocation.

							Thanx, Paul

> > And I guess the tricky part is making kfree_rcu_sheaf() work on RT ;)
> 
> I hope we're close to that, as discussed on patch 5/8 :)
> 
