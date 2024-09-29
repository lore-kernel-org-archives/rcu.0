Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FCC1C683;
	Sun, 29 Sep 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727625075; cv=none; b=TD8IDUMG4WBQGXqw3mWX4rMLqhup+gIhOStO848Dbqe0bOq6KWO3c6/Lvnoni+DoipaAT09+YpNXN25pM+VFhcN6MZXrnklMvrHGcacZ/NUOuBEJfCRpHLFM/uep3l2gYf+dxJhX2fGTjgfl2TDsJGHuc5A1X84RBZtlECvatTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727625075; c=relaxed/simple;
	bh=KT0NvVFCww9jUSGdpuipSki65RESc4oWk+fSOgC7mFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5iNnlMkV9bKPR48RkFhBmfG78xoSQN5QiR8E2VuFU4iAGuNQqX9/RAcJO1mJkS56J5qYko43i8n7iVzjMTD0ziGbVMzuQjDwyq66GjNQKchnmzmzyOegogfaFNGlOd6qAC/lp2+tiCK08bjgEg4pJPpsuOyidvNb6Bvp9aw/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+tU+dSW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+tU+dSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4607C4CEC6;
	Sun, 29 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727625074;
	bh=KT0NvVFCww9jUSGdpuipSki65RESc4oWk+fSOgC7mFk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=s+tU+dSWCQMuFEMfAoj6SdGdq6uzxmIB+i1vYvyJ/mgQM9ht7+PRH6/S6Et4B52lm
	 UzZOb1yYNiti2lZuGXB+Wv3XfqJ6shFc6gLasSBrA12nNupa7OqO9AnLHdfzldcI3N
	 Q2830MNNQqSD3EoiQJvUeNbtiCxCSWkeG8dcMe7gawztSDm1MMB9wGhr620n9eULbt
	 6bAVsPM9txJJLrJ4E7SWRcRaRuku7+2Ri7MyG7wQF+tKyiw+yhAwWvAWiWpzwAlatp
	 BPRlhX48gCpJYn9LzTD2h7lzLLH4MXvj1pR+GHJDCGqAzSmOfqFillipjwqriWwgcT
	 /tnmwtUVctdEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60CE5CE04D4; Sun, 29 Sep 2024 08:51:14 -0700 (PDT)
Date: Sun, 29 Sep 2024 08:51:14 -0700
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
Message-ID: <8153f0f1-fd18-4ae1-9dc5-f9b725429cad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240929111608.1016757-1-mathieu.desnoyers@efficios.com>
 <20240929111608.1016757-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929111608.1016757-3-mathieu.desnoyers@efficios.com>

On Sun, Sep 29, 2024 at 07:16:08AM -0400, Mathieu Desnoyers wrote:
> Refer to ptr_eq() in the rcu_dereference() documentation.
> 
> ptr_eq() is a mechanism that preserves address dependencies when
> comparing pointers, and should be favored when comparing a pointer
> obtained from rcu_dereference() against another pointer.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> Cc: Nikita Popov <github@npopov.com>
> Cc: llvm@lists.linux.dev
> ---
> Changes since v0:
> - Include feedback from Alan Stern.
> ---
>  Documentation/RCU/rcu_dereference.rst | 32 ++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
> index 2524dcdadde2..9ef97b7ca74d 100644
> --- a/Documentation/RCU/rcu_dereference.rst
> +++ b/Documentation/RCU/rcu_dereference.rst
> @@ -104,11 +104,12 @@ readers working properly:
>  	after such branches, but can speculate loads, which can again
>  	result in misordering bugs.
>  
> --	Be very careful about comparing pointers obtained from
> -	rcu_dereference() against non-NULL values.  As Linus Torvalds
> -	explained, if the two pointers are equal, the compiler could
> -	substitute the pointer you are comparing against for the pointer
> -	obtained from rcu_dereference().  For example::
> +-	Use operations that preserve address dependencies (such as
> +	"ptr_eq()") to compare pointers obtained from rcu_dereference()
> +	against non-NULL pointers. As Linus Torvalds explained, if the
> +	two pointers are equal, the compiler could substitute the
> +	pointer you are comparing against for the pointer obtained from
> +	rcu_dereference().  For example::
>  
>  		p = rcu_dereference(gp);
>  		if (p == &default_struct)
> @@ -125,6 +126,23 @@ readers working properly:
>  	On ARM and Power hardware, the load from "default_struct.a"
>  	can now be speculated, such that it might happen before the
>  	rcu_dereference().  This could result in bugs due to misordering.
> +	Performing the comparison with "ptr_eq()" ensures the compiler
> +	does not perform such transformation.
> +
> +	If the comparison is against another pointer, the compiler is
> +	allowed to use either pointer for the following accesses, which
> +	loses the address dependency and allows weakly-ordered
> +	architectures such as ARM and PowerPC to speculate the
> +	address-dependent load before rcu_dereference().  For example::
> +
> +		p1 = READ_ONCE(gp);
> +		p2 = rcu_dereference(gp);
> +		if (p1 == p2)
> +			do_default(p2->a);
> +
> +	The compiler can use p1->a rather than p2->a, destroying the
> +	address dependency.  Performing the comparison with "ptr_eq()"
> +	ensures the compiler preserves the address dependencies.

Bitter experience leads me to suggest a "// BUGGY" comment on the "if"
statement in the above example, and a corrected code snippet right here.  :-/

Other than that, loks good!

							Thanx, Paul

>  	However, comparisons are OK in the following cases:
>  
> @@ -204,6 +222,10 @@ readers working properly:
>  		comparison will provide exactly the information that the
>  		compiler needs to deduce the value of the pointer.
>  
> +	When in doubt, use operations that preserve address dependencies
> +	(such as "ptr_eq()") to compare pointers obtained from
> +	rcu_dereference() against non-NULL pointers.
> +
>  -	Disable any value-speculation optimizations that your compiler
>  	might provide, especially if you are making use of feedback-based
>  	optimizations that take data collected from prior runs.  Such
> -- 
> 2.39.2
> 
