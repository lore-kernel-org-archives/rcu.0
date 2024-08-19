Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474C13C3F2
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087355; cv=none; b=kSQLDgi08zKtWMEyenxjj/LmPd5NN5X4onNuefLBNmt/hU1MYxEkOhptzV5EGLn1dS2kk1Rk2TS1hMMqSyIxM+CYDha0iRUFbsuqBVezLf6NTjl/NVnSyazhIk+swVFBnVszQrxdY1d9xXGpSLnJ8jr67V53yyqwLYnHrhqGRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087355; c=relaxed/simple;
	bh=gH6tH2I5S2us3KgeXmW3JgdTnxdzPnZInjB9IKwOaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBXadjqaFPVgGp1ksWRU47Jtg5MtpmHN2qmYhOZ7324rpmZILl6PTYP3Zf4OCChpLzkmuYMMomji/R2liP54Wh0BSXI8m4028AG1RC+hOSNlqYJJ81uf0vUg5wFJQMJdkEwxibNRJJgg/vPQaZD5T0ymhfO8xnJIlAKkucCYC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ok6fw1kx; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ok6fw1kx"
Date: Mon, 19 Aug 2024 13:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724087352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hozC7SSMxdwWeCkGoeTUrKTkWUOu4Mj1hs/r5+BaY8c=;
	b=Ok6fw1kx32V+xixi6O9Bl6V72z9qjfaDeMKJFUjWwM8j3FHmRvPj2WYj7MzHXNfRn/aUx+
	o+3X92I0NY5pL7RqQKPyeMABJ92YRylpWqviB1Tu0hHTF8cV7oQXVoInLhy1t2k0Q8Fpqr
	Hw18M5FDC+UsaDEaPheee9lDGR4F8Xo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <bkqpx3rbhbz2jw52ugubyjyr4eyn2pkkpzsiczz5emtokviie7@hh5yrqjysacw>
References: <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
 <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
 <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
 <6pqbszwxjby3cu7yfep23zrnfff4f5cnh5f7npxlpim7jhiuq7@4keumf66hfot>
 <e86fc94e-0151-40ec-ae6c-dd5991756905@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86fc94e-0151-40ec-ae6c-dd5991756905@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 08:49:26AM GMT, Paul E. McKenney wrote:
> On Mon, Aug 19, 2024 at 11:14:02AM -0400, Kent Overstreet wrote:
> By "number of outstanding grace period sequence numbers" you mean
> the number of outstanding grace period sequence numbers that have
> memory blocks that have not yet been processed?  If so, how could that
> possibly matter more than the total number of memory blocks that have
> not been processed, regardless of which grace-period number they are
> associated with?  Why would a huge number of memory blocks fail to
> cause an OOM simply because they happen to be associated with a single
> grace-period number?  Or, to put it another way, suppose that same number
> of memory blocks were distributed over a large number of grace-period
> sequence numbers?  How could this possibly cause an OOM to be more likely
> than if the same nubmer of memory blocks were associated with a single
> grace-period number?

We just want a callback every time one of those grace periods expire, so
the pending objects can be freed as soon as they're ready.

This isn't _fatal_ for the kvfree_rcu() backend, since we have memory
reclaim to fall back on, but it would still definitely be preferable for
rcu_pending to be getting the notification from core RCU and avoid the
more expensive memory reclaim path.

It is more critical if we want to use this for a faster call_rcu()
backend.
