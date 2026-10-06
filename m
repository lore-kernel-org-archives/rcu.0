Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6A286D70;
	Tue,  6 Oct 2026 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309804; cv=none; b=PF0YUoa4HV4B1v9EeeaRCAmX6j2lBebeA0Hg7l9vMlzQxHGio135h2mPzsAUa5YGRqESiXubNDLpx8HRnu0YYhmzyOS7+RyvFsMezg2AGnzhkZp+ztbTVnIlBNlTCwX+u8XRgeIhmI+fgbbBCSca8fUthmWczAb3ACqEwpv6JY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309804; c=relaxed/simple;
	bh=Vr8UPPhc/3LHeUxJYs/Dk6TYg9+1w2W65a17uHf9gFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb+XXUw4+nvJDgoHtIOFJV9GEXOaHHOiE73SdHkohmD8TJ03kGvF9+2Ok4WROZTmdifByDUylEF8HkM3hpmn7TZrgvDbYVkP0g7TyvRHDjA/spDVQW1llRq6kxqEC44dptpGcTJZwyzGtf04+eqEOGqdO09QvmgckleB0Q7S/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBj7NBLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBj7NBLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE48E1F0089B;
	Tue,  6 Oct 2026 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309802;
	bh=T6bWreWqdh0pxVBLeOkV0ABsGL1g0LmIaRnT5mBAf/I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=UBj7NBLsDZQ7ocM6BqdUOe2qYlzd5UPczmWKeTyKc7x9lQT/P9PU6B2fhBaMotm9P
	 hFS0/uZYTdS3R78ivjW3f0/+wXC14eF1JteAxM6nwiquiciaPI2PWBGRYD2gns3vXN
	 bahxojohxkT5+i61pURXc5eXYBj5+MQ28w0oHsSivLsfWviLGZtYziyjmJYT9SDn8x
	 MPM7C2a7/31AIPeq4xE4xlMxRIpfN6LyZxxMNknGwFVqLWISWO5SHf2KEYA8Wcb5n8
	 R1bKFMGdAgEgqzdZY2GYres3ccB1gvZkGuxLAXyJa252ltttZ5BI6zeV4Jl2X0F8j/
	 dUcMAEkf046ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8FB01CE3A08; Tue,  6 Oct 2026 11:03:22 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:03:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcuscale: Consolidate per-writer arrays into struct
 writer_state
Message-ID: <46027df6-75a9-4a6f-b6ac-b8348ed8ed8e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261005005642.2312272-1-joelagnelf@nvidia.com>
 <20261006104154.xflixj46auqpstff@offworld>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006104154.xflixj46auqpstff@offworld>

On Tue, Oct 06, 2026 at 03:41:54AM -0700, Davidlohr Bueso wrote:
> On Sun, 04 Oct 2026, Joel Fernandes wrote:
> 
> > The writer kthreads keep their state in five parallel arrays indexed by
> > writer number: writer_tasks, writer_durations, writer_n_durations,
> > writer_done and writer_freelists.  Each must be allocated, NULL-checked,
> > freed and cleared separately, and the cleanup path needs several
> > guards to cope with any one of them being missing.
> > 
> > Collapse them into a single array of struct writer_state, holding the
> > task pointer, the duration buffer, the measurement count, the done flag
> > and the existing struct writer_freelist.
> > 
> > This reduces initialization to one allocation and one out-of-memory
> > check, and cleanup to a single kfree().  As a side effect, this also
> > fixes a leak: cleanup only ran its frees under "if (writer_tasks)", so
> > if the writer_tasks allocation failed while a later allocation (for
> > example writer_durations or writer_n_durations) still succeeded, those
> > already-allocated arrays were never freed.  With a single allocation,
> > that partial-allocation state can no longer occur.
> > 
> > Assisted-by: Codex
> > Fixes: 8704baab9bc8 ("rcutorture: Add RCU grace-period performance tests")
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>

Queued testing and further review, and for v4.5 (the merge window after
this coming one), thank you all!

							Thanx, Paul
