Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76816DC3C;
	Sun,  6 Oct 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247173; cv=none; b=kq32zrIQtl1thf8tbn0bWrUwKcxDs9I4B2GOTKWaIlPLM+6ZcOgLzCELu8pO058Yov6uEW26N0rq/1fbk0/HrTu4I7fM2nkNrRMGDlQwjUsfu3SHvyzCbdlRSRBSc4BMIatSqoNLgsTcrral8Cde64YLvOtPHVUD7MXQh7BOBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247173; c=relaxed/simple;
	bh=uvcPrAbHbiaDImYhVusfABjiDJeHc/gUavwIa8OLfBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV7okSvHf147HbKwaBmaOmkW4wyMgOWp0H/3vHF0CitJIfn6p8qspEKJSo/0KVwS3VBxJ4Wt/rzXPesP8+cqP+tog/6eruwMGBgAZgbLLReQ8qokisYNdFsb2cz82R7RngKO+ebnGu9EeDq8lYVuwJh0okdV21V6uYqbSX4HMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSmFUlv0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSmFUlv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09FDC4CECC;
	Sun,  6 Oct 2024 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728247173;
	bh=uvcPrAbHbiaDImYhVusfABjiDJeHc/gUavwIa8OLfBo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lSmFUlv0C4p33ry2q52EFi9b2nAhonpNcPanfJ65jyMalZJ/CQeTWSFr3zOSeIcgp
	 lubrQtb45RzbKV74YTbIrp+xd2qxURNkZE3xgK+vUIVN22qDvuWfaKvcWXJtE0wRN0
	 JAUv2wRT/e2i/mGld176Gvxk9voUxNRE6kAVACOv2QigsRGLNbRuXhrb0O18hpeF37
	 Q1Z5lzGNgPghyGOPAmOCdkULCurrnCRA9LnGg3OQgLjps/xpn8eyKrFMAYZ9w6xfqC
	 9KRZsRxTvlDPJm39wV39UnNI0famAItlSOXuxYzyq6KZniQEhCdn9Q4panjqmnpl7r
	 8tzLbyROJoLWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7B3E1CE09EE; Sun,  6 Oct 2024 13:39:32 -0700 (PDT)
Date: Sun, 6 Oct 2024 13:39:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
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
	Vlastimil Babka <vbabka@suse.cz>,
	"maged.michael@gmail.com" <maged.michael@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lkmm@lists.linux.dev" <lkmm@lists.linux.dev>,
	Gary Guo <gary@garyguo.net>, Nikita Popov <github@npopov.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH v2 2/4] Documentation: RCU: Refer to ptr_eq()
Message-ID: <f2297002-457b-471d-88fe-5c8d31b16523@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-3-mathieu.desnoyers@efficios.com>
 <72af935f4a2a4e23b68845d2f6855103@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72af935f4a2a4e23b68845d2f6855103@AcuMS.aculab.com>

On Sun, Oct 06, 2024 at 07:52:49PM +0000, David Laight wrote:
> From: Mathieu Desnoyers
> > Sent: 04 October 2024 19:28
> > 
> > Refer to ptr_eq() in the rcu_dereference() documentation.
> > 
> > ptr_eq() is a mechanism that preserves address dependencies when
> > comparing pointers, and should be favored when comparing a pointer
> > obtained from rcu_dereference() against another pointer.
> 
> Why does this ever really matter for rcu?
> 
> The check just ensure that any speculative load uses
> a specific one of the pointers when they are different.
> This can only matter if you care about the side effects
> of the speculative load.

It can matter when there are static variables used during OOM.  The code
must check the pointer against the addresses of the static variables
to work out how to free them, which can enable the compiler to do
specialization optimizations that destroy the address dependencies.

Which is OK if those static variables are compile-time initialized or
some such.  But not if they get new values each time they go into the
list, as this can result in the reader seeing pre-initialization garbage.

An admittedly rare but very real use case.

							Thanx, Paul

> But rcu is all about (things like) lockless list following.
> So you need to wait until it is impossible for another
> execution context to have a reference to some memory
> before actually completely invalidating it (ie kfree()).
> 
> And that 50 line comment is pointless.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
