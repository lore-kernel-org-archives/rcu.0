Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F693D3CEE
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852435; cv=none; b=CMFHGG/uKDetqxcwnkOcCrMLdPcOEH/WrzhjtdymCrVEUwKEc3KYLeqPfhO8vmgyK8yb3xj+UkGsnYhFRYKLrysnkuM61+RPWLVhOjrGUQA1VVHPIf7dfZMqbBIF8cN4japGrTuJiSKfF1QAuy7oBP7kkE2BRQe+17jXpRBtLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852435; c=relaxed/simple;
	bh=HfpCJhFyj6Y9puS8doHbaugVLDX3X1QFkcADA3vkWCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mt/S+zAYQbfq72qThPsF7ve9B/2mJU1/3Lxb2Ubp1v030EgO1QHTJysIrIk9bxAbX+t7c8aSIuyBQVtfq5KtDzRqGe6TwJsy8OMwt9u5yu7IK5xIE1021gDgECv48UHa1gltN3cAI+MO32b8JpP2+TGqEj+qUOLGnmqXEqJgZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQnBFaFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27VysrQ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQnBFaFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27VysrQ/"
Date: Wed, 18 Mar 2026 17:47:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773852431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aug5CrbJ0rw65zwnvPTMbySmL5KuBdq3cjYZNu0bCkY=;
	b=BQnBFaFFn0nFTDdncbGDq4ccmmu8vehRrocvhdq8c/wLxj6BSo6PFcVf11LCMw21vSoNjz
	G9zVtqoCY47eWuDbmd+x/hi7VKJe+QiacNT6RrVkOTHmulBTmORZ9zsK1mgIFYe5rJxhum
	ZzXxllFhRj5Ph4NLityjP1mdzmZkkFm5AfHHsQWFI1swFCkAXuZ68Oiwd/+K44Y/ArtHrR
	M0q9ApvIqF7XRqk+A1verfkx7Dojp2ADThMIMTNaPHaepbrRBY3cHOa4dnf24f0WClts55
	ufueiWcG1CEghXeT5MXN6ZmUe+q394iOrlWIcBTJGLco09NUExUII+XB00H4tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773852431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aug5CrbJ0rw65zwnvPTMbySmL5KuBdq3cjYZNu0bCkY=;
	b=27VysrQ/pzGntCvScHARDPIfchRgKyAp8NmxVSIyD0tBszsHuObg1WT0b41lABsu5ymAkf
	fjF/5SV3sr3b7fDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260318164710.gUolNYgg@linutronix.de>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>

On 2026-03-18 09:32:07 [-0700], Paul E. McKenney wrote:
> > What remains?
> 
> With that patch, we no longer have call_srcu() directly acquiring a
> non-raw spinlock, but as you say, we still have the wakeup problem.

Isn't this is just srcu_funnel_gp_start()? And where you could ensure
that it is always a delayed worked (delay always 1+) that is scheduled
so that it always setups a timer and never does a direct wake.

> > Popular? Okay. Keep me posted, please.
> 
> Will do.  Just out of curiosity, what are your concerns?

We don't have many NMI code paths and the possibilities are quite dense.
I would imagine having this possibility would lead to things that
wouldn't be needed otherwise. I mean we don't even allow allocating
memory from hardirq (except for _nolock() variant which I think is used
by bpf for $reasons) but need to call rcu_free from NMI.
This would require to remove an item from some kind of data structure
without regular locking. Unless RCU is used to get a delayed invocation
of some sorts.
I mean I am curious here who needs it any why ;)

> 							Thanx, Paul

Sebastian
