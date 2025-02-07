Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF271747;
	Fri,  7 Feb 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961340; cv=none; b=lRkYLbOJaR8xoAk5lVHBEh620a+5Wp8mjq9kJG6437/hfptmAZEWqfqEX0uGaKQPlBRvkKhykX2BjYFunfu1Y7OIGFgCLor3xHqaNFep65EBhOjWDwyGeBeGIjOwj/ActEQg4gn7/xyeo6CXlECbpQSmgdxgd3boHX3ZOR+R2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961340; c=relaxed/simple;
	bh=fxs3Ladaqx9hAPGmjStpxDMTcfm0MGzLrWGwbcct67Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW1yUOJcCPk5wXa4wsYoxFAxG0pSzKFa9PCI3j5v4kQcrFNgIaUErq6HTBEbZGd7VLBRfV4uleo1qSFcaCHWoUkZGy3WtPtzb3CXTKr1qiF3ttMocuYqWTNO21gTDWRPBT4oh4KLNQtSOwnJ+nreuyLg5TDmT7SuGx0ao1J6tMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=skxUQ3N6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=idZeBYCn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="skxUQ3N6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="idZeBYCn"
Date: Fri, 7 Feb 2025 21:48:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738961336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxs3Ladaqx9hAPGmjStpxDMTcfm0MGzLrWGwbcct67Y=;
	b=skxUQ3N6IngdazJl2CWa2kuGyfUkCvtPwfykwSkZEBWhfBUyrNTyBQuZDtc/qU6E1fgZvp
	kKRnDRcn08FRe5KHGReoPpbOt/ymhKelYoi7J2EDsw1ybUTjgRM22oEUBwVtf8Ktdz0jwS
	YgRhhgCJjkzjGPyzUDlQU2pkLTg6XoYlX0Z8R+0Sq5V6O2JzYmowMgGotwZr+VD3qzlYd1
	6/NyFWxCpmQx4Z11eauKLWW0OovRfrop1DEu1banVfJmakFsn2fWg3t5K7RaRPvsqGTM0j
	dpI7S7g6MCVgerXAqqkKRjDxLp5pxBEi21rV+AquFOTMjUZqjFU/SMpc5sw0/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738961336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxs3Ladaqx9hAPGmjStpxDMTcfm0MGzLrWGwbcct67Y=;
	b=idZeBYCnVnbPpH4AnZRlzwKGYDeWLskvn24We1+RQ7WpbKq4SeeucsCSa/ZFMrIjAgQtmp
	XcsTYD9kMLYSWlDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: MengEn Sun <mengensun@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	YueHong Wu <yuehongwu@tencent.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 0/4] ucount: Simplify refcounting with rcuref_t.
Message-ID: <20250207204854.rc1gron_@linutronix.de>
References: <20250203150525.456525-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203150525.456525-1-bigeasy@linutronix.de>

On 2025-02-03 16:05:21 [+0100], To linux-kernel@vger.kernel.org wrote:
> I noticed that the atomic_dec_and_lock_irqsave() in put_ucounts() loops
> sometimes even during boot. Something like 2-3 iterations but still.
> This series replaces the refcounting with rcuref_t and adds a RCU
> lookup.
> This allows a lockless lookup in alloc_ucounts() if the entry is
> available and a cmpxchg()less put of the item.

Andrew, could you please take this series?

Sebastian
