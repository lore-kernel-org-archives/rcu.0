Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F1372B29
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911002; cv=none; b=d0iAWw8EYfQF3ilbhS5Es1n+ecBbdkV9ZDoKBFFRSxiAqtDJ7fXHw6I8aH19FAJyNZS09NnfKkY1ExzTiZq0kRN9v2PUuJ+s1SDJpLdm97vkanw0EwZEck1Wx4r7ZpluZtP8gjYXD+8oanvCYnbpTp6jNic/aziXXjDxrnzrH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911002; c=relaxed/simple;
	bh=9URztzmG5mRXYSOEt5LAYqwJG0PBC5ryHRIp8u3P8sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAfsbg6B2H1H4ilVn1NxzC/hwUYYq8Cq7XY/wNkIKbowXeWp0xpOIvJ24/al2/2IO0wRBcHn4EJSHotXDm8pYLKjo1LG6e9KxWwRaKOGwz+0LbF2/MFOnWaBJbqttZOxhK9wJrFXcEVkePvPhV1qNOASIBniBA1KxD+LFDDVNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lx6S87us; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7UsooBmj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lx6S87us";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7UsooBmj"
Date: Thu, 19 Mar 2026 10:03:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773910997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3SZ4R1wBvMuzmwwXoiQLjjI7cLZEURNOjniKgjrDGo=;
	b=Lx6S87us5cZFqUFgaGBcsflyuy8AFwtA0kGS2/NWg6EnNDboh8Y6VSjOH20UlbMiozS0ZQ
	CFyrPS4xb+Kjm4SIJfEtaP3YVBd5MHhj/D0dghSltZ1VdOgTXrnGPHERwSVSlV5YwtIEsO
	11BExbGn4SFHo81QYD+W+vhws9dzX9irFEkzpTCZnuyndtgD6mlluL//bX3zVQnwJe2k9w
	mSo8YGKr1foLDzPHVbwfVaUFC/dWnNC3axhczAPf4zZkmp5OVmYpscwymUsgVDtCEv08/3
	vi4jqU1Z3mzVD2PYU9VGY61zZAqsFV1RSLmWkxkCYz+NCsRKmZfKn3t2jUQ2jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773910997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3SZ4R1wBvMuzmwwXoiQLjjI7cLZEURNOjniKgjrDGo=;
	b=7UsooBmjHD1S/OdsV82Xrk8iOgGiVcZklmjkUhwFbh4K/ZcpHDJm0TltIcxoImfIBn1zkD
	57+qd4oYMtBb8IAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260319090315.Ec_eXAg4@linutronix.de>
References: <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abtMhd_LVp3uL_pA@tardis.local>

On 2026-03-18 18:08:21 [-0700], Boqun Feng wrote:
> @@ -1979,6 +1986,17 @@ static void process_srcu(struct work_struct *work)
>  	srcu_reschedule(ssp, curdelay);
>  }
>  
> +static void srcu_irq_work(struct irq_work *work)
> +{
> +	struct srcu_struct *ssp;
> +	struct srcu_usage *sup;
> +
> +	sup = container_of(work, struct srcu_usage, irq_work);
> +	ssp = sup->srcu_ssp;
> +
> +	queue_delayed_work(rcu_gp_wq, &sup->work, !!srcu_get_delay(ssp));
> +}
> +

Please just use the queue_delayed_work() with a delay >0.

Sebastian
