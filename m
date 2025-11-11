Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A636656C;
	Tue, 11 Nov 2025 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875489; cv=none; b=n7USNK8WYiyyHUk/ONzIqFhWbvcZRq0RZ8mwux2Pt1xP9WdCxD+4e+lzkxgJlxBgkw3U1wtRHp4gtoAy3WNSMj+0x5gbIlDQDl3Ghm+Erv4dX+32UHlzIJ6IeAluxiLcTTsBNJNmIFZq4ZXm3oUJ2XwnBFnFtxgYS6rLuq351+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875489; c=relaxed/simple;
	bh=WjxBsMQB756k+JJn2YjbgttLrucVGxtl+hfBXR4VJL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt5+ENEFOp8ME4sbaK+WtfX5NIiDUJcYoUxvqPyUV7aCE6TA6pvlZY2stfzUbOWUjhD7mgxBF+AyewQsjbgBS6lGqOOi6r+2IwPjtXV1A2BXBMWog9MFpKpPMFcQAJUL+QKbsrNCLwJMrfhYXMAGsW/6p8YOoxRa7Ec8iSJE7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LiKLvr1F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fPr5YoNw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LiKLvr1F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fPr5YoNw"
Date: Tue, 11 Nov 2025 16:38:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762875485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJzPXx8DfhkJ4vlk0WVZfi/olj5IfC1SXcCW76gAJfI=;
	b=LiKLvr1FP8mQqUGlWSGM/ekHCnzkXCGJyNfwiioCnki3WH7rEm83moXFtu68z49RV+04VM
	Hrx66Z+IGd50fzSdiZhd3t/Jmu3kjV08XWFJ9bBYT2HT+KNzs+i3Rez1jasFgVexvhpr8j
	xF2d1vKelN+KvHfO3FbotR7AZWBbHe5s5SEqw3N3829/rodYsbKyh+Daxq62tjrIWxxmcY
	eBwBaBrNFGNxPvBwclSLmrHvgoBhMVuHm4d5S/JvxtH0u/c7tWjaMkV3FdbHngPgob97rs
	pzCc12HJfLm2ihC1c8o5ixDQQgiJ8aZMI81+6BMNmDXYC6lOE62mv6qYM1JXvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762875485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJzPXx8DfhkJ4vlk0WVZfi/olj5IfC1SXcCW76gAJfI=;
	b=fPr5YoNwdkrHVe4E6ttPKY028WdR6Yr+XGnH/DLsIdrCBGE1rDq1wBBQkJL8izwLcHe53B
	JtEwhmW7W+uQc/BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 3/8] refscale: Add local_bh_disable() readers
Message-ID: <20251111153803.5_08_ro2@linutronix.de>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
 <20251102224948.3906224-3-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251102224948.3906224-3-paulmck@kernel.org>

On 2025-11-02 14:49:43 [-0800], Paul E. McKenney wrote:
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -636,6 +636,37 @@ static const struct ref_scale_ops jiffies_ops = {
>  	.name		= "jiffies"
>  };
>  
> +static void ref_bh_section(const int nloops)
> +{
> +	int i;
> +
> +	preempt_disable();
> +	for (i = nloops; i >= 0; i--) {
> +		local_bh_disable();

This (preempt off followed by bh off) may cause warnings. That would be
bh is disabled on the CPU, it gets preempted by _this_ which disables
first preemption and then bh. 
I hid the code under CONFIG_PREEMPT_RT_NEEDS_BH_LOCK so it shouldn't be
a problem in the long term I think. So just if you see a warning here
under RT you know why :)

> +		local_bh_enable();
> +	}
> +	preempt_enable();
> +}

Sebastian
