Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827974A5C45;
	Thu, 10 Sep 2026 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054668; cv=none; b=iiceRBQVVaShCGL4ns4W2G5M3vwJeyZd6Q0e+BdJAdxSzy1Gv/ZghEJe7GCcPjejq8Wz9K/6VwlfPqED6ZhyNfqvyGZ9x0Xm8F2EsF1R9V+uRK9R5faCkFntD91Q3HiGpCnNUxgJ9gYDgHdCx/YyOXjiQNXCEJgqXyFjt8r7Kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054668; c=relaxed/simple;
	bh=0k/4ax+osrPo62uCJ0EU4cIAtOvs8ABizI1aXz+Izp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOT0H2tcpvt9y20csLYHB6txK1fO0gaHt3HgX6/nG9BlGAiVXBvgkYV8PW0aCtUmNDQtj6zXo4vOkYQGtJ+oTHMfQpj5bWiR6A4Qha72Tdlq8DtB1g0s5fet1G/b6OQtjGNy+M3VwpKiVTDBy5OPPpO9zcHybYkz+CpZpQO58js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VriTx0Z1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VriTx0Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB7A1F000FF;
	Thu, 10 Sep 2026 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054667;
	bh=4uOGjkG74Wm+sX78i/4FEm2X06d3znZeXMj2+quY1Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VriTx0Z1+6noD0EQGTM7piUYegRAzgJglduCw1RaeMRZlbllz9xSu6yTnZ7UEl5vl
	 whotd+qlDoIYpr4JsafDodioJXAfzTnoS+qbpjRJzc/OxjYEhx8gw8U9IWoPduEJES
	 GsbH24vd4H2BQJcTReYZXQzsCboLjQmeaf1YRWd+PN/f0xlLAGjn4dssHdtwrJBrLm
	 /Om5WFlQcP0nZgu6w4psdpdIBUGUPr4RBeLvFwz9r8GjzRCSJ2z40osegFFjsWW5Up
	 fCb763Q961+NqPZqATF4UMLemfu+ZgJRqQsHx39Rylc93r7sclhafHytagYY0eqxXr
	 ffcKt16uIxBdQ==
Date: Thu, 10 Sep 2026 16:37:44 +0100
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
Message-ID: <aqLI21uo-UglU6XP@thinkstation>
References: <20260910101112.1648978-1-matthias.goergens@gmail.com>
 <20260910101112.1648978-2-matthias.goergens@gmail.com>
 <aqKZXmlRGsmJPl3r@thinkstation>
 <20260910134640.2044424-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910134640.2044424-1-matthias.goergens@gmail.com>

Hi Matthias, thanks for reply.

Would you please wraparound the text when writing a reply?
Each line becomes way too long on text based editors :-)

Anyway, moving on to the topic...

On Thu, Sep 10, 2026 at 09:46:40PM +0800, Matthias Goergens wrote:
> Thanks. I ran into this while testing bcachefs performance changes.
> The bcachefs ktest end checks write `do_rcu_barrier` before reading
> `/proc/allocinfo`, with the expectation that allocations still
> reported afterwards are leaks. Small objects released with
> `kfree_rcu()` remained visible after repeated writes to the hook and
> 20 seconds of waiting, so otherwise clean tests failed their leak
> check.

Thanks. Some background like this would be nice to be covered in the
cover letter or commit message :-)

> Strictly, that ktest is assuming a stronger contract than the hook
> currently documents: `do_rcu_barrier` promises an ordinary
> `rcu_barrier()`, not a complete drain of objects still held in
> `kfree_rcu()` batching. I nevertheless think the stronger behaviour
> is useful for this test-only quiescence hook, because it lets
> allocation-leak checks reliably separate deferred frees from genuine
> leaks.

Ack.
 
> I followed those allocations across repeated filesystem lifecycles.
> Their number eventually fell when an RCU sheaf filled, so I have no
> evidence that this path grows without bound or causes OOM.

Ah, the reason I mentioned unbounded amount of objects was because
the commit 16128b1f8c823438dc that introduced the knob explains
what can go wrong (e.g OOMs during the test) without the
rcutree.do_rcu_barrier.

> The problem I observed is limited to test isolation: the hook can
> leave deferred frees behind and make them look like leaks. With the
> proposed change, the same unmodified bcachefs workload passed the
> leak check.

It'd be more convincing if this part is included in the changelog ;-)

> I also found that this exact follow-on was discussed when
> `kvfree_rcu_barrier()` was added in 2024: Paul proposed calling it
> from `rcu_barrier_throttled()` for clean userspace benchmark
> baselines, and Uladzislau agreed that adding it and documenting both
> operations was safest:
> https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/

Didn't notice that, and makes sense given the purpose of the knob.

> I will omit the `Fixes:` tag in v2 and present this as a strengthening
> of the test interface.

Makes sense to me.

-- 
Cheers,
Harry / Hyeonggon
