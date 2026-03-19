Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B13C3454
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917515; cv=none; b=t6pamn46pX62tHB2V6/eBp7jNBEB5d+BFB36SYAJrEQQ621UjJ0ciyD9+8jC0r9Mx6gUWra5zDnbBB9e4QQ+lWReyaMAnN1C/3rp77jdLQtej8qc4P+MGGdu1FWakp75+6A6LBrt0HWPg6z5WWINe7bmj14x87utPy1t0LsX3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917515; c=relaxed/simple;
	bh=SHqC21uTJzVWUAqsZTLf+LBIHXFxu1Nq29JWsvlpFaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSIr5gWy0qre6jq6yxNEfOKbXCQ/5ty8zNhzYmRwKRaJ2PJqOZWP2Nmt9dtfoVMUSpLXQCwwRHFyAYizOsUdcsOKZn1e/1V4IT7sSup8OOmhpUEqxvPhqMUAKKL49oKK1zEgdDn4D9bo7c768l2XrieBUqJ1MJ290498Er3bR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pg6BSmTa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rh/KwtM+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pg6BSmTa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rh/KwtM+"
Date: Thu, 19 Mar 2026 11:51:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773917513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Og5ICfxwisL/30lO+m4Jglmk8KEbH8GCARAGPI2ZbiM=;
	b=pg6BSmTaLGSgy8hpwhE41ny/As/aQ3p3/Gw0LEDQtj2bi88HqJOX6A9jKjOt7MWedWn9t1
	i5GXW9TCaI9P6A5TtUBFv+APw4RvzCV38SXTGep4pEeXROUBXhs01FKztlqFCIc0x74pEK
	2gIx8krnSxWSnQMZscxBadFD0oH3PUYTEBKpot6cFsZxPnnFwDsBbeaYU/BskXV23Frl+q
	vxF7T0WmXBNn/mFPJqIKkEg07vV9j2zV3EIx8tgpsJ+ZnoG1vxeVGGJXiGoNnGHUtGqwgI
	s21OqZWwxQXtqGj7NEKleYWXJ6keEoOEYNOq5c9JBJkNVhA/4u5uYOoJ8VyLlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773917513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Og5ICfxwisL/30lO+m4Jglmk8KEbH8GCARAGPI2ZbiM=;
	b=Rh/KwtM+YtxE4UH/oaWTHEFVzmI2TQCxhF0BfDfAvSFsEXRf7/e9bBvQ8mGofEFqrF/WhJ
	pXI1atyzGtGSezBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260319105151.Rtzk9nUj@linutronix.de>
References: <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
 <20260318164710.gUolNYgg@linutronix.de>
 <9b685d13-5496-4bc9-ab6a-508bd4bf0f16@paulmck-laptop>
 <20260319085548.UZQk1cyW@linutronix.de>
 <b449bfaf-9a52-492c-bbcd-4756c0a14eb4@paulmck-laptop>
 <d3d119d8-7e41-4f22-a3c9-f7feff059a27@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3d119d8-7e41-4f22-a3c9-f7feff059a27@paulmck-laptop>

On 2026-03-19 03:43:17 [-0700], Paul E. McKenney wrote:
> On Thu, Mar 19, 2026 at 03:05:40AM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 19, 2026 at 09:55:48AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-03-18 11:48:56 [-0700], Paul E. McKenney wrote:
> > > > We would need a lockless enqueue, which we have in llist.h.
> > > 
> > > Only if CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG. Otherwise you must not
> > > provide call_rcu_nmi().
> > 
> > I *think* that BPF is provided only in such architectures, so agreed.
> 
> Plus srcu_read_lock_fast() uses atomic_long_inc(), which is supposed to
> be NMI-safe anyway, correct?

I am not aware of any NMI restrictions for the atomic ops, just cmpxchg.

> 							Thanx, Paul

Sebastian
