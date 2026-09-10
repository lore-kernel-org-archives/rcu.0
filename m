Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF73DCD95;
	Thu, 10 Sep 2026 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041833; cv=none; b=qagqsIlTXGREzxWEUTUASQLhHAkGOZnrFKC3TUDkZ8ueJTcFczaKoImyG9+z/Gmljui3DLpaxZhBq9ui/3f4BiIDkwivv4tao6sXCgL95fIPoOZSwTeQl4kfXIIAwnvMVFXQgq3tPV9eHX9CULN41R8lRmCh35FEwjvYb31vLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041833; c=relaxed/simple;
	bh=0CCF0TP1FETNi2uAWTVMBOarnS3/c/OQYtVLcYaZZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIqt81b7fn/njsQ0UDqfgh45HUrWWOmc+8zwzN+MjskTfVsLYRTYzWvBpHWsNJUqzikoRIyKGv1qwEMMGvLPyW0V0b9pQ7VRdfrsHdzmvgp8AR1z0fRgR8d+iGtsDddtubzYUkzQ5g4j6UZA1u/dFdkmx3ZqpE8tg39f3stFwYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCr+Jak8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCr+Jak8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE221F000FF;
	Thu, 10 Sep 2026 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789041831;
	bh=oCGcFuT2iDgzr5S1IgNo13ZKvL4482evnBdgXEPE9IA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NCr+Jak85cDYzsPnfsyla0J46HSMAlnAzomJZaoiTbkZlvd1igyT4jPflVjjV1zuj
	 h0G62cCI2H51Huy2B/+TJZWEtpslY4DWMnfZ0+vKTiifD7kuo1GhieDz2neAGtUsfd
	 u3HAFOyFnxkfvr4ecgxSJ3p3ji8kN8atAJxpteaZ7KT16D1bAvSSTbsC8Sl70zfBJE
	 OEugSagnTDoSVpm342p6dbCchLlLbgF2MY94pUdG53J9JYuCyrVE+XgpCfmrh3JAFA
	 uwLybJ1qRIssTZvNo0edoMzYU/NYGJgDzCAuyhss5UiQJqt9yMnixaTqeZ/yG7AsJP
	 4b0sxGY+Q6LDA==
Date: Thu, 10 Sep 2026 13:03:49 +0100
From: Harry Yoo <harry@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	surenb@google.com, vbabka@kernel.org, rcu@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rcu: drain kfree_rcu sheaves from the userspace
 barrier hook
Message-ID: <aqKZXmlRGsmJPl3r@thinkstation>
References: <20260910101112.1648978-1-matthias.goergens@gmail.com>
 <20260910101112.1648978-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910101112.1648978-2-matthias.goergens@gmail.com>

On Thu, Sep 10, 2026 at 06:11:12PM +0800, Matthias Goergens wrote:
> The rcutree.do_rcu_barrier test hook is intended to prevent deferred RCU
> callbacks from one stress test spilling into the next. Since kfree_rcu()
> sheaves were added, an object can remain deferred without appearing on an
> ordinary RCU callback list. rcu_barrier() therefore no longer fulfils the
> hook's stated purpose by itself.
>
> Drain kfree_rcu sheaves and kvfree_rcu batches before completing the
> ordinary RCU barrier.

I'm convinced that the behavior of "do rcu_barrier()" knob
to imply a kvfree_rcu_barrier() is the right fix.

And also I wonder what's the user-facing problem you are trying to fix.
You can't pile up unbounded amount of objects via kvfree_rcu() to cause
an OOM during the userspace tests?

How did you discover the problem?

> Keep the explicit rcu_barrier() because the hook's
> original ordinary-callback contract should not depend on the current,
> undocumented fact that kvfree_rcu_barrier() includes one internally.
> 
> Keep the existing throttling because this remains a deliberately expensive
> test-only action. Do not coalesce requests based on the ordinary
> rcu_barrier() sequence: an unrelated ordinary barrier does not prove that
> sheaves were drained.
> 
> A reproducer creates a private SLAB_NO_MERGE cache whose first allocation
> populates a 60-object slab. It queues that object with kfree_rcu(), invokes
> the hook, and reads the active-object count from /proc/slabinfo. In four
> fresh VM pairs, the parent retained the object (60 to 60). The patched hook
> drained it (60 to 59).
> 
> Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")

This Fixes: commit is incorrect because the problem was introduced
by kvfree_rcu(), not sheaves.

> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++---
>  kernel/rcu/tree.c                             | 27 ++++++++++++-------
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 

-- 
Cheers,
Harry / Hyeonggon
