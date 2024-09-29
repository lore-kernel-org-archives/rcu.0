Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1CAD2F;
	Sun, 29 Sep 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629656; cv=none; b=SJvT0L8H2dvkGlYpLFfS7giKHcqWpsuRkxMS72K7E58iEC9LWuAXoisIuwUkk1+tleR/1QltVBGl95v3kWdll45CRNaVdotQiHgDVcv6VazklEoSXGEwuA2cVK4GD+bZzD9hgbuVeW2zgfUZkk3egDEdTd4L9DmpohnwG1GIVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629656; c=relaxed/simple;
	bh=O7w8DeVwq7CwRT5PMbyZVQpfUrTlDNjY5NwQLo7OfxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSyab/T9By/OkF3HaKxHchwl1d+pAJ3R+HaVgOMxKHVpz/06uFGgeEGiycXcEortQ4f67rQ5TpAfo8y+KkRPGOBR0z3nKgu8qy8vHmYHYD9yTrZBZ7xFKS9QDjQqycq2rQUbuIx7dMAM8gbbsXW5HP9ZPPMFVm9NsTVU3Ylk3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2LXR/Do; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2LXR/Do"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DBBC4CEC5;
	Sun, 29 Sep 2024 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629655;
	bh=O7w8DeVwq7CwRT5PMbyZVQpfUrTlDNjY5NwQLo7OfxA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t2LXR/DoOMh4sF/JbbWKkcGIj78RzUgUI8rsWOJITBhe6S9skX8osKV86lRHspwJ1
	 tpYMKTXppM93TfsEcEru0yQz8rxkPjYPl4118Xa1M5HI2aNeEk8rT+kcdN7sVerTyr
	 kswROxQkl3RFeliMR9ybHJXeo0nBBiUCG8izn5VsM/7D1zw8pNkpZIopW7RMUcDoSh
	 brhwrd6Y+uWwi2vxh8/4YGF/vfJBmQ9NqpQ1uZyHOLc1UAxX7FJeaq0hutwHTzJK6a
	 eCuUCucuyXbHZ6AF6OH/7t0czyr5NEN5GyAHjun6Ksb3yzjwHYT+zXBhgOIEVyvsuO
	 bNImMGb9NCvtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6E859CE04D4; Sun, 29 Sep 2024 10:07:35 -0700 (PDT)
Date: Sun, 29 Sep 2024 10:07:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev,
	Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v1 2/2] Documentation: RCU: Refer to ptr_eq()
Message-ID: <cf2139e2-41cd-4213-89e9-c10873498edf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240929111608.1016757-1-mathieu.desnoyers@efficios.com>
 <20240929111608.1016757-3-mathieu.desnoyers@efficios.com>
 <8153f0f1-fd18-4ae1-9dc5-f9b725429cad@paulmck-laptop>
 <3a298b64-dd7c-4a0d-950e-8e5b98b39fee@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a298b64-dd7c-4a0d-950e-8e5b98b39fee@efficios.com>

On Sun, Sep 29, 2024 at 12:09:54PM -0400, Mathieu Desnoyers wrote:
> On 2024-09-29 17:51, Paul E. McKenney wrote:
> > On Sun, Sep 29, 2024 at 07:16:08AM -0400, Mathieu Desnoyers wrote:
> > > Refer to ptr_eq() in the rcu_dereference() documentation.
> > > 
> > > ptr_eq() is a mechanism that preserves address dependencies when
> > > comparing pointers, and should be favored when comparing a pointer
> > > obtained from rcu_dereference() against another pointer.
> > > 
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: John Stultz <jstultz@google.com>
> > > Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: maged.michael@gmail.com
> > > Cc: Mateusz Guzik <mjguzik@gmail.com>
> > > Cc: Gary Guo <gary@garyguo.net>
> > > Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > Cc: rcu@vger.kernel.org
> > > Cc: linux-mm@kvack.org
> > > Cc: lkmm@lists.linux.dev
> > > Cc: Nikita Popov <github@npopov.com>
> > > Cc: llvm@lists.linux.dev
> > > ---
> > > Changes since v0:
> > > - Include feedback from Alan Stern.
> > > ---
> > >   Documentation/RCU/rcu_dereference.rst | 32 ++++++++++++++++++++++-----
> > >   1 file changed, 27 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
> > > index 2524dcdadde2..9ef97b7ca74d 100644
> > > --- a/Documentation/RCU/rcu_dereference.rst
> > > +++ b/Documentation/RCU/rcu_dereference.rst
> > > @@ -104,11 +104,12 @@ readers working properly:
> > >   	after such branches, but can speculate loads, which can again
> > >   	result in misordering bugs.
> > > --	Be very careful about comparing pointers obtained from
> > > -	rcu_dereference() against non-NULL values.  As Linus Torvalds
> > > -	explained, if the two pointers are equal, the compiler could
> > > -	substitute the pointer you are comparing against for the pointer
> > > -	obtained from rcu_dereference().  For example::
> > > +-	Use operations that preserve address dependencies (such as
> > > +	"ptr_eq()") to compare pointers obtained from rcu_dereference()
> > > +	against non-NULL pointers. As Linus Torvalds explained, if the
> > > +	two pointers are equal, the compiler could substitute the
> > > +	pointer you are comparing against for the pointer obtained from
> > > +	rcu_dereference().  For example::
> > >   		p = rcu_dereference(gp);
> > >   		if (p == &default_struct)
> > > @@ -125,6 +126,23 @@ readers working properly:
> > >   	On ARM and Power hardware, the load from "default_struct.a"
> > >   	can now be speculated, such that it might happen before the
> > >   	rcu_dereference().  This could result in bugs due to misordering.
> > > +	Performing the comparison with "ptr_eq()" ensures the compiler
> > > +	does not perform such transformation.
> > > +
> > > +	If the comparison is against another pointer, the compiler is
> > > +	allowed to use either pointer for the following accesses, which
> > > +	loses the address dependency and allows weakly-ordered
> > > +	architectures such as ARM and PowerPC to speculate the
> > > +	address-dependent load before rcu_dereference().  For example::
> > > +
> > > +		p1 = READ_ONCE(gp);
> > > +		p2 = rcu_dereference(gp);
> > > +		if (p1 == p2)
> > > +			do_default(p2->a);
> > > +
> > > +	The compiler can use p1->a rather than p2->a, destroying the
> > > +	address dependency.  Performing the comparison with "ptr_eq()"
> > > +	ensures the compiler preserves the address dependencies.
> > 
> > Bitter experience leads me to suggest a "// BUGGY" comment on the "if"
> > statement in the above example, and a corrected code snippet right here.  :-/
> 
> Changing for the following:
> 
> +               p1 = READ_ONCE(gp);
> +               p2 = rcu_dereference(gp);
> +               if (p1 == p2)  /* BUGGY!!! */
> +                       do_default(p2->a);
> +
> +       The compiler can use p1->a rather than p2->a, destroying the
> +       address dependency.  Performing the comparison with "ptr_eq()"
> +       ensures the compiler preserves the address dependencies.
> +       Corrected code::
> +
> +               p1 = READ_ONCE(gp);
> +               p2 = rcu_dereference(gp);
> +               if (ptr_eq(p1, p2))
> +                       do_default(p2->a);
> 
> > 
> > Other than that, loks good!
> 
> Let me know if I should add an acked-by from you on this
> documentation patch as well.

Much better!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Thanks,
> 
> Mathieu
> 
> > 
> > 							Thanx, Paul
> > 
> > >   	However, comparisons are OK in the following cases:
> > > @@ -204,6 +222,10 @@ readers working properly:
> > >   		comparison will provide exactly the information that the
> > >   		compiler needs to deduce the value of the pointer.
> > > +	When in doubt, use operations that preserve address dependencies
> > > +	(such as "ptr_eq()") to compare pointers obtained from
> > > +	rcu_dereference() against non-NULL pointers.
> > > +
> > >   -	Disable any value-speculation optimizations that your compiler
> > >   	might provide, especially if you are making use of feedback-based
> > >   	optimizations that take data collected from prior runs.  Such
> > > -- 
> > > 2.39.2
> > > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
