Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987A198E81;
	Mon,  7 Oct 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298883; cv=none; b=l5uaz6WsI6EjWBgx9NDUYmIeCEPnHwGnZW72VnoOPQkdD9C4wNAIDTwGODEnKuCq820YOXuvXoZF2DZaKYiYZI4MS9tB8tTj8q/SnivegSjWB8447GOTuc6o0lfZXcNEZrbVYNTOvjTlpf5rtGLR6wWnA8DSDfGzCoSU2Vlu7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298883; c=relaxed/simple;
	bh=EsNyz/6NmQGIF7jRLtLbDpUUSAfjnZ0U4efmqd2xUf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZfoYGxwdhJZtMxE3bR1dHqAhhbHbkwwrQVuEBLl3rGoN0/BfKpbB5DqDj0ULP4Q3D/AQgdnFWEYjYHJEWOyGYVa25ewfqiFPphjJqeOICXsSEzMGcF3Jt+uZSOnaPV7bNpkJH0QQ4efa7FJw9hRKl2NpE64lT7V4oPNnA36PrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GvTaX+lQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nR9JB7F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GvTaX+lQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nR9JB7F"
Date: Mon, 7 Oct 2024 13:01:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728298879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c4gRHCcLb4jbQI6d/h1siM+v84iL2e+zAz1uss1+vmg=;
	b=GvTaX+lQ3NFJaSD+N6WWBhRg2nHwOXDlCfeAs7i0mcIjLclUNFJo/jPF4FdOG1gOMhcqWO
	Fnv568281VwxHzgCXFCxyX43gL2iWgdqLFWkI7Wi/lGFKkzHmg5cRP0yvEunImGAkl5Sag
	vUtKBFVtaFrPqj7ePow9Mqmp1IR/Vm5ertGBjEXYCoBHJXhoLhjUR7YhklKST6C5a/loZj
	U2vpMNH6ji0kD706Ne1F0UvXmvLQXz/otlk5pJY5ExiSpmW6wtF1uk6Yvd3h4uL1rm8+zn
	JIlkUu059Vt9ILYFyGTIiEGjEVTk/1ZRA0YM8Na4rADk9GRmvIF+zNB4OOeKbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728298879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c4gRHCcLb4jbQI6d/h1siM+v84iL2e+zAz1uss1+vmg=;
	b=7nR9JB7F/MR7pVgKbZWbz84B8/0uzBBvbTBoD4XEWdCFiRynDn+RBHbKDPmLk1OFpH6Rba
	xGqMTFDovGI6M5BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: RE: [RFC PATCH v2 2/4] Documentation: RCU: Refer to ptr_eq()
Message-ID: <20241007110118.RJ7zm3ie@linutronix.de>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-3-mathieu.desnoyers@efficios.com>
 <72af935f4a2a4e23b68845d2f6855103@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72af935f4a2a4e23b68845d2f6855103@AcuMS.aculab.com>

On 2024-10-06 19:52:49 [+0000], David Laight wrote:
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
> 
> But rcu is all about (things like) lockless list following.
> So you need to wait until it is impossible for another
> execution context to have a reference to some memory
> before actually completely invalidating it (ie kfree()).

Not always.
Non-RCU could would have locking with a barrier to ensure a reload.
RCU would not have the barrier. Assuming the pointer, points to a
struct, the compiler could load an element from the first pointer and
keeping it after it ensured the pointer are equal. However based on the
logic, the content could have changed and the compiler would not load
the new value but keep the previous one.

> 	David

Sebastian
