Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89226A29
	for <rcu@vger.kernel.org>; Mon, 10 Jun 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717980741; cv=none; b=BQFsGEJ3ogUTHGE3ABYj7b+LMq1TsW+ZdWi6neU0VNI5OFlNdVHyA0doItN7QD51gon3/UkwOCU0IjuoP2ng9Zm+RF/0dMhAdGJ3pdmtrkI48/vb2Gz6p16syVeQfIOklDKEE4ex18KrQsjkBm8WK6qd95/mP3rMMvURrGh8ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717980741; c=relaxed/simple;
	bh=PpPAfIrSPTpwoT/qKPUT/AS1frojMNS524vqZzA9ToM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toIn8Soc1R2ibSYtXmpOWiVXZT9jN1IkOSaYvowkFahTOdasrCzgMjw0BLxeBG2Kn6l2ZZf2tRbzkoicceFpLU81Zp94VewCu35fyNqKecoXI2e6zqYS56jPmvIkO1TdxR6L0gbhATh+58KRCwmue774cm8/YHDduVqvO5Ws8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAF+WkG4; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAF+WkG4"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717980737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8e/nZx2clS5oTz8ovHQHA3tx0aMmiEyC6dg3QhyZo0=;
	b=TAF+WkG4VJOxlUYAV0XBorySC5vvvWRAtswWB9oLQHE7Wz9JAodQ3v+57Pn0+U93qOUb7o
	AWMD1hzkhZzoJnV7YyeLNC2OFR8VlH7EN2ngm/cc59LaKHo/t2a7Cvay6ZFgrR2yrQ4Mmf
	CttBCXBHxuPgMVe8Y3YJxOSNK5WDBks=
X-Envelope-To: rcu@vger.kernel.org
Date: Sun, 9 Jun 2024 20:52:14 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 09, 2024 at 09:55:30AM -0700, Paul E. McKenney wrote:
> On Sun, Jun 09, 2024 at 11:37:45AM -0400, Kent Overstreet wrote:
> > On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> > > Could you please try something like this just before the call to
> > > cleanup_srcu_struct()?
> > > 
> > > 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);
> > 
> > Which seq was this supposed to be? All keys have been freed by this
> > point...
> 
> Or, alternatively, where in the code is this supposed to be?
> 
> If there is no convenient point in the code to grab the most recent
> return value from start_poll_synchronize_srcu(), another thing to do
> is to invoke either synchronize_srcu() or synchronize_srcu_expedited()
> just before the call to cleanup_srcu_struct().
> 
> Another approach is to use get_state_synchronize_srcu() instead of
> start_poll_synchronize_srcu(), and have a self-reposting SRCU callback
> to keep the grace periods going.  Then you would set a flag that
> stopped it from self-posting, then do srcu_barrier().  With careful
> memory ordering.
> 
> There are quite a few techniques to shut down the self-reposting SRCU
> callback when there is nothing for it to do and to restart it if need be.
> 
> But just doing a synchronize_srcu() or synchronize_srcu_expedited() is
> a lot simpler and probably does the job.

synchronize_srcu_expedited() seems like the simplest solution, yeah.

Thanks, I think I'm starting (hazily) to get an idea of how the RCU code
is structured, but I'll have to dig more when I have more time, this is
interesting :)

I am wondering why you couldn't just have cleanup_srcu_struct() do the
appropriate cleanup (synchronize_srcu_expedited?) in this instance; if
the caller is tearing down the srcu struct they don't need srcu
synchronization anymore, I would think the only safety issue that would
need a warning would be leaked read locks.

Another question for you: is there a limit to the number of pending
sequence numbers from start_poll_synchronize_srcu()? (e.g. 2?)

That affects the data structure I use for redoing this "track pending
frees" code.
