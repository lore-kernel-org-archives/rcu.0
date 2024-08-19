Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437215A865
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110682; cv=none; b=da8uuWCU7T74y+vj6SNVMfHoghEcwAfNZfUhYzkUTorH0j4IjZ2IV/ZIRJ02osFsWB+tE9f6EaMGcbOk/PVHjNhpwCD3YUJFXfYlkoEicrkpPRE57UOgGQJfIpf+NPTQ/WU+WbRil+9JM15MZed7XNsnVRExuZKipiF9Vxwbr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110682; c=relaxed/simple;
	bh=Ms7a7ycxa5hpbjfl4RAngu0hPcsvWueasbSQm2KVHfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN9Ozq/0zjMa9daqqUxrXCl9iu6n+j7DLGxJrknDYKlxm+i+FYFJ0TbSKt1UFIGHfvYpXeX5wohLkUZwUCY8nAHgcxK3KXzeH10gWyeqiMgeb1tJH06oPgbxjxRGLf0fIZhuJtgLChJ+ossI3R6cidgcG6iEjyRQLZDGVBOaiUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nissSM6v; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nissSM6v"
Date: Mon, 19 Aug 2024 19:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724110678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tmoQq9S0Gg3CvAjBdnSbiaQowYoRPScBKlV06p/uuc=;
	b=nissSM6vf9Bdecc1Z2JJQKoKcjKCmJ1CJnqq+I9xwQHDS2m4dvL/XLhh6Bv635jkAJ4xb0
	ZExFGYfk7hH6G58ghbiMdYjOL/PKmYBSaVgAHs/H4UC0S/PabwPzfDewb+Wa1bbR1f+d+l
	dIaP6syG9m/d9YZu9Mq9YLdnXuVnEU4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <uy4ovnf7rkrhpqoj3zo3ky34qv462ttltvyp37ncxxfhz3awkq@cp7rcg4v6qzd>
References: <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
 <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
 <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
 <6pqbszwxjby3cu7yfep23zrnfff4f5cnh5f7npxlpim7jhiuq7@4keumf66hfot>
 <e86fc94e-0151-40ec-ae6c-dd5991756905@paulmck-laptop>
 <bkqpx3rbhbz2jw52ugubyjyr4eyn2pkkpzsiczz5emtokviie7@hh5yrqjysacw>
 <6c35998c-a35d-451b-b698-f1613bd8a2a2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c35998c-a35d-451b-b698-f1613bd8a2a2@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 04:10:23PM GMT, Paul E. McKenney wrote:
> On Mon, Aug 19, 2024 at 01:09:09PM -0400, Kent Overstreet wrote:
> > On Mon, Aug 19, 2024 at 08:49:26AM GMT, Paul E. McKenney wrote:
> > > On Mon, Aug 19, 2024 at 11:14:02AM -0400, Kent Overstreet wrote:
> > > By "number of outstanding grace period sequence numbers" you mean
> > > the number of outstanding grace period sequence numbers that have
> > > memory blocks that have not yet been processed?  If so, how could that
> > > possibly matter more than the total number of memory blocks that have
> > > not been processed, regardless of which grace-period number they are
> > > associated with?  Why would a huge number of memory blocks fail to
> > > cause an OOM simply because they happen to be associated with a single
> > > grace-period number?  Or, to put it another way, suppose that same number
> > > of memory blocks were distributed over a large number of grace-period
> > > sequence numbers?  How could this possibly cause an OOM to be more likely
> > > than if the same nubmer of memory blocks were associated with a single
> > > grace-period number?
> > 
> > We just want a callback every time one of those grace periods expire, so
> > the pending objects can be freed as soon as they're ready.
> > 
> > This isn't _fatal_ for the kvfree_rcu() backend, since we have memory
> > reclaim to fall back on, but it would still definitely be preferable for
> > rcu_pending to be getting the notification from core RCU and avoid the
> > more expensive memory reclaim path.
> > 
> > It is more critical if we want to use this for a faster call_rcu()
> > backend.
> 
> I am still missing why the call to process_finished_items() from
> __rcu_pending_enqueue() cannot cover this.  Given the way that RCU works,
> that has the potential to notify you *before* RCU's grace-period kthread
> would get around to doing so.

Not with any kind of bounds, since there's no predicting if that
enqueue() call will happen, and not all potential users can process
pending objects in enqueue().

Like I said, this isn't the most critical issue, I'm mainly thinking
about if we want to use this to get rid of linked list overhead for
call_rcu() processing itself.
