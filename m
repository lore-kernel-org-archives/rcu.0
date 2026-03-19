Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375673EDABA
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938040; cv=none; b=NSatDagM96z+qRON50THYVeH+GoAdnBZ0EXm1mBKQPgQyLrp1WZXsoFMN/E+xlymmh4rDSeNRf87tVyssJwPBIul8vDjJEfHumOxr2BZGAIqzltwTilhi7TmbbGK44pu1b/lkpRpF6OnCEmAgA0Cbiy1Cu3WXY+FDT6hgTYOVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938040; c=relaxed/simple;
	bh=C9WtI20esgsdzGbMDW53jYOK5cB+qj2aXqrgX2E7ru0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVP8T8GCAWfR7QpyeCIYICa7pYxTUkBLf7/4p+im3l1lULKP988Q3UaSQY/6PP973uZSGlAICDFt50iKOXWROjm2Aiebp0GP36IXzY1zNGKeH4TJiaWOv1znSA5Q8N2TEcC1mfCkVFKrfoqWbSbh4/JPotO0Il0yCHTwPQ/8aOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XzNjCLxk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GWaWVwQh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XzNjCLxk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GWaWVwQh"
Date: Thu, 19 Mar 2026 17:33:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773938032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHAOC/TSiz1utrYR6p+w7bvxe+DaFPen6V99JQOQlaQ=;
	b=XzNjCLxkewVUdeotckkspAwqae2EP5rnxfoPTH/EmcAEyJq9G2VK0ucUT7fWksbWazte9G
	v2u7MgGGkPlcVzy+r0ElI1R2cGt9Wx/vmrDRQWklk/O/wzxWRko2OGsORpvXeE2taWTcDs
	NrXYOFaZmAv5f7HLHGWAMLl2UknVcYDpE6ts9AAClyTOjj/VXqiHU93E10pv4GwUuB64nC
	cuisLhZ1vRp6DPvD6U22X+pjjovTvZUjliAMriUT6FfAPqOlrLQXvwb79R5uMr/mkGx47X
	x10OGO5sVKU86s4Xp1DDW30TLCfxscbDKIsEv7M6pSHN9/y5rAXZ19pdl1TkaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773938032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHAOC/TSiz1utrYR6p+w7bvxe+DaFPen6V99JQOQlaQ=;
	b=GWaWVwQh4NB1EcQ1xTRMW1ydSnv01ibTV0Ox6XtaO7DOYZp4Ye6qzOJo4IU0pYspLZo/mF
	znWJL/vZ2W78LEDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260319163350.c7WuYOM9@linutronix.de>
References: <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abwkD0mOdAbD9ENJ@tardis.local>

On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > Please just use the queue_delayed_work() with a delay >0.
> > 
> 
> That doesn't work since queue_delayed_work() with a positive delay will
> still acquire timer base lock, and we can have BPF instrument with timer
> base lock held i.e. calling call_srcu() with timer base lock.
> 
> irq_work on the other hand doesn't use any locking.

Could we please restrict BPF somehow so it does roam free? It is
absolutely awful to have irq_work() in call_srcu() just because it
might acquire locks.

> Regards,
> Boqun
> 
Sebastian
