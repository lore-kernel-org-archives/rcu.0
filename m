Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4A2FF65F;
	Sun, 31 May 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250690; cv=none; b=UsxrmHFdlZEBLveltVZRLQV6obMDub4EcLj9XC44Osu2lo3Cje4AOlD1WFg7UGwwODSGVa29V3oACNQZYOzgJSiYdL+XY2bFy22HK6wlByQQjmo0ST9E7TzvtFZUY5M0SWddwMOJudtP/tSZlQc2IEZQde08JapubZSgrApbFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250690; c=relaxed/simple;
	bh=eK8YsPISMZ6RI30bL6A1g3kQKH48uqzrK7slQ4WYoSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DULE85ZCaFc9q1yHdovpH+fAA+6WF4E20bUpFX7ReQh9p/GHi0GMsjreYj7sb4USfDPWccqYbD3H26B6DWPffQpwobY+X0EJ8yckFT4trkkuKut36IVIm6sp2A393hkaPIIPKe05MP6uZGemTKKBvFzPW01rFoZyN5b4o6qBqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH0WSZL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH0WSZL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD6B1F00893;
	Sun, 31 May 2026 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780250689;
	bh=ha2Cf0OUua8qCF0XsSP/PrfjG7bokXOqzpOD85zMH3k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XH0WSZL6wLVSPDoRMQNrNVTGOX5lx8p86CjKM99Af014tqy0PokqC317t6QOA7fKm
	 IYyUUWo347JQoXc/cwmu+rj/SE6sw7mae252swXMDZz3x3KUIpu6zUDLgHfY32+T7e
	 wwX7j7h5t2LdFqmhwgy5N4ys8B9ZtJxmuiiIG8HsNnQUquVHIYzFK0NUuo39OM3tLV
	 WY9mifzttzjhu93xRnE3/ApOqzdOqieTdIkyi9N/ePAVFFRXlfphg+zanzgk+mvu0N
	 5kZ9oKOJmZyXuRm1Qkw+tDiFyvVjuDG24iFXhsaCacUQyt6cY5UHTVdrObqysuJyla
	 sQv320iJEiUlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1B366CE04B5; Sun, 31 May 2026 11:04:49 -0700 (PDT)
Date: Sun, 31 May 2026 11:04:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Message-ID: <4c03540b-8a80-46a5-98b3-dc16ee160cfe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260528062810.256212-1-work@onurozkan.dev>
 <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev>
 <20260528083518.66203-1-work@onurozkan.dev>
 <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
 <20260529065744.59786-1-work@onurozkan.dev>
 <DIV5CERB9OTK.3VBQ0NUPD1FZ2@garyguo.net>
 <20260529122920.175997-1-work@onurozkan.dev>
 <DIV62C2KC8HW.1KB4JAT9SXCRX@garyguo.net>
 <20260529124934.205738-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529124934.205738-1-work@onurozkan.dev>

On Fri, May 29, 2026 at 03:49:31PM +0300, Onur Özkan wrote:
> On Fri, 29 May 2026 13:41:10 +0100
> Gary Guo <gary@garyguo.net> wrote:
> > On Fri May 29, 2026 at 1:29 PM BST, Onur Özkan wrote:
> > > On Fri, 29 May 2026 13:07:18 +0100
> > > Gary Guo <gary@garyguo.net> wrote:
> > >> On Fri May 29, 2026 at 7:57 AM BST, Onur Özkan wrote:

[ . . . ]

> > >> >> > Actually, now I am now thinking about whether we can come up with a better
> > >> >> > approach when we detect leaked guards. Initially I came up with the
> > >> >> > synchronize_srcu() solution because it would handle leaked guards automatically
> > >> >> > without requiring any additional checks. But now that we can actually detect
> > >> >> > whether guards are leaked the question becomes:
> > >> >> >
> > >> >> > 	"Is there a better option than effectively sleeping forever when leaked
> > >> >> > 	 guards are detected?"
> > >> >> >
> > >> >> > I have no plans for tomorrow other than finalizing this series including the
> > >> >> > question above.
> > >> >> 
> > >> >> The best solution is to proceed cleanups anyway, given Rust rules ensure that
> > >> >> these are actual leaks and not just srcu read-side critical section that failed
> > >> >> to synchronize with the destruction of SRCU.
> > >> >> 
> > >> >> This obviously require changes to the SRCU code though.
> > >> >
> > >> >
> > >> > The issue is difficult to fix purely from the C side. Once drop returns Rust
> > >> > is free to destroy srcu_struct. If srcu still has pending callback associated
> > >> > with that srcu_struct, for example from a future call_srcu() wrapper then
> > >> > returning from drop while readers are active can turn into a UAF. There is also
> > >> > no way to handle callbacks in a reasonable way in cleanup logic while there are
> > >> > active readers.
> > >> 
> > >> Callbacks should be flushed during the drop due to srcu_barrier. Am I missing
> > >> something?
> > >
> > > No. Callbacks can only be invoked once the grace period has completed [1], which
> > > can never happen while there is an active reader.
> > >
> > > [1]: https://elixir.bootlin.com/linux/v7.1-rc5/source/kernel/rcu/srcutree.c#L1452-L1454
> > 
> > Well, then srcu_barrier will not return. When `srcu_barrier` returns all
> > in-flight SRCU callbacks must have been executed.
> 
> Yes, or there weren't any callbacks posted.

Just to be clear, this all requires that Rust is preventing any later
calls to call_srcu().  If there are later calls to call_srcu(), then
the earlier srcu_barrier() is not guaranteed to wait on them.

							Thanx, Paul

> > Best,
> > Gary
> > 
> > >
> > >> 
> > >> I'm pretty sure that, if we disregard potential misuses from C side, removing
> > >> all "leak it" paths would be fine and won't leak to UAF if all users are from
> > >> Rust side.
> > >> 
> > >> To be very clear, I am not advocating to actually implement this way. I agree
> > >> with your conclusion below that this is broken code and a warning + blocking is
> > >> good enough. This is really just my thoughts on your "is there a better option"
> > >> question, and I think it's better in ideal world, but I think blocking is a
> > >> good pragmatic choice.
> > >
> > > I see. Maybe I should have phrased the question like "Is there a better option
> > > with similar complexity" to be more clear.
