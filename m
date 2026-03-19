Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71E34405C;
	Thu, 19 Mar 2026 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939769; cv=none; b=dzz7UJeLx+rWpXyAvPmg3q1f8Jt06qt/t7fVv6DcKjnbA6/swHw8dsd2KWvdcRUfGz0TYGEOl3+ids3dj2dB+nZACP2XNiQEJCmd4nbT5e4E3z+tjhIsDWp5hgeirAZmcd6j9OiBaPDEmEvA2im3S/n/AcKkYklTtGF9CzyoZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939769; c=relaxed/simple;
	bh=r0Ahq3w/O/KZVFscHyNoVMAzYOx/M0uAydBxYDaMkRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eofp0g117lsOMH2t4H8NG5H2nxIACIkG1F+eAqPUGyve6SFOygbNUFlijPsrO98brDa5zkOLABNgSPT/O+A5Pe3AI5/ofSrIw/kZCNLQ2yfQQrqrrxtlz4Vi9ZTEZqPXM+sz2eTByLxpu0g+RUkwLk5tfjGEqqghcRvrE9we088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CqAiRr/N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EXdcPhL2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CqAiRr/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EXdcPhL2"
Date: Thu, 19 Mar 2026 18:02:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773939766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTrfk1lO+3TIcYC769IPgBivOfGSUU4zhF7LrDU0YwI=;
	b=CqAiRr/Nlmo9mBt1Moq6B5urx1syXcbXVCHQuSQ4GK6RWvxadKBQEgDiMlxmU6cNug/42P
	MgbYhRYrP028mJfKP+hnYY/CE7vrNfruFLYEJu9X5je679njS8dmXqNabJ6leQ3FLbecnP
	XShbR4SC0sXImEWWWDNHDaox0q3LRt8ObfCHEVcTADk1lSs2TyQyxge9bNnzC4DYRBvXlo
	X8SlMjPKbo1FA8bzOb7AfOMWW0He4+gDrYf+gFvGU6/gHfQnQnVEfwZQzI02SHAQqBHA+2
	k1Ot5dk/EeTCKir/Kettou3BMZyruSU4JlmtD7/4Y9LQqsFLE8K3CN/NhVQn/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773939766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTrfk1lO+3TIcYC769IPgBivOfGSUU4zhF7LrDU0YwI=;
	b=EXdcPhL2m2u+ritj99L7GrWG9fghkl7Z9/v7KgZ3fYrOHTFF0fV/PUT7CmbWqq2MnbMxFN
	2vHrQCs0k4G4CcDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260319170244.jqndSwct@linutronix.de>
References: <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abwo0I_mu94t5Ews@tardis.local>

On 2026-03-19 09:48:16 [-0700], Boqun Feng wrote:
> I agree it's not RCU's fault ;-)

I never claimed it is anyone's fault. I just see that BPF should be able
to do things which kgdb would not be allowed to.

> I guess it'll be difficult to restrict BPF, however maybe BPF can call
> call_srcu() in irq_work instead? Or a more systematic defer mechanism
> that allows BPF to defer any lock holding functions to a different
> context. (We have a similar issue that BPF cannot call kfree_rcu() in
> some cases IIRC).
> 
> But we need to fix this in v7.0, so this short-term fix is still needed.

I would prefer something substantial before we rush to get a quick fix
and move on.

If we could get that irq_work() part only for BPF where it is required
then it would be already a step forward.

Long term it would be nice if we could avoid calling this while locks
are held. I think call_rcu() can't be used under rq/pi lock, but timers
should be fine.

Is this rq/pi locking originating from "regular" BPF code or sched_ext?

> Regars,
> Boqun
> 
> > > Regards,
> > > Boqun

Sebastian
