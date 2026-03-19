Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9003AEF2B
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910554; cv=none; b=KSKzY1hmEHZCRoLumNed47IRZRShuBRtzjfZyIk9kBwx/pkIyyFQ1a+P0WPVCjZ+6n6pl4WW/Wpfjw1b5bzhJFhsa19ZhE6ygDYj/a4o7z/LhZoN4Fsxta5Fw5JbZLDCAup1jOdyog2YyR+JjB2WMYsZGVHI+QNHN/VbLMil7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910554; c=relaxed/simple;
	bh=vKZ+9LuApyI3XqByfvlkZsBHReacjiGEfFSRdwvj0eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8oKXUIgxKikHz3mp48fxQGRDUcN9GVj91F99ocW55PvI3d2F7iYQv6tx+WsWxQeH1feTFiE4mZSso4lBnWktpMlw+fcZ578WIOS45j3MTTWMjw8okGOiQaTgHi7uokxwa6Y0QMPTe6LdcXNXpzqAF70+TRnSDyC+vrF2gsfOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtR4bD9E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SM3NZRra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtR4bD9E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SM3NZRra"
Date: Thu, 19 Mar 2026 09:55:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773910549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZFb4WS4Gr4h5BF+zJIFWWqiuFSBdiKDJXSRz7oqNnw=;
	b=wtR4bD9Euzpr7RRv8SzjlVeJ5/9O0DMwhp9t+PAQ8lNsHad2FxU4kgo7JDgkJ7Bd9Z7PRu
	p0ZmMcnXzPN/BtDohBmiLPKbTT+pzTymJpqUGYdpFZ64RxBgDauNz81+49iW/WYIRx+qi6
	vwc9Vk3BVRl1+oWew6gQbh3s69wp6cvS+mUqmUhMRZ+iVMQA5oAKbH16Bze28FDSfcRfRd
	OD+R8RbozecTauU3Ta0s39deSTxmCRgUATnCteHP4JBEtJlYsez1lRU5slgKYXzOf8yBLB
	Voi6NKb6qoBsxMf2U4c1sGgEcy0JLgVuaYXpB29xCFNiCewYy/vckJM3xbs+VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773910549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZFb4WS4Gr4h5BF+zJIFWWqiuFSBdiKDJXSRz7oqNnw=;
	b=SM3NZRramZE0HMUh1UAakoj9YTqXTKuaIXY0plsUgsdBJeRKUqoIVztprvyhT5+rTqG9bm
	iBbuCGgZZZSk5xDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260319085548.UZQk1cyW@linutronix.de>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
 <20260318164710.gUolNYgg@linutronix.de>
 <9b685d13-5496-4bc9-ab6a-508bd4bf0f16@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b685d13-5496-4bc9-ab6a-508bd4bf0f16@paulmck-laptop>

On 2026-03-18 11:48:56 [-0700], Paul E. McKenney wrote:
> We would need a lockless enqueue, which we have in llist.h.

Only if CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG. Otherwise you must not
provide call_rcu_nmi().

> The irq-work to actually do the call_rcu() or similar.

reasonable.

> There would also need to be rcu_barrier() changes, for example, to
> drain all the llists.
> 
> > I mean I am curious here who needs it any why ;)
> 
> You got it right above, BPF.  ;-)
> 
> They currently check in_nmi() and to the irq-work step themselves.

Then it would make sense since you do actually have users.

> 							Thanx, Paul

Sebastian
