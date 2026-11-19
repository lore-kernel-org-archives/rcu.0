Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081686;
	b=RN7Lm79k7eEgq2unnrZkuBF0RaGQLw85Eeo2LucVn79QdcpAh/Vcm0ZlIoujE22yKPV2
	 oMC3Of+bl95x0P/XorQch1Ch8ZEJmvI409AfOcLG3br/9Dw/KUJ765UxYkMPad8PIW19x
	 6RhYVAj+lx1kGwgTaqfxfv5kPaqHlCbaZZkpeICdKeiPZIWeSZtDtPkpvtjs2g+4L8HuI
	 Pr7unCRI+F/3kwKRauWzH4DHH/jRwDr5G0kc3e0t1cSR175vmmEUb3VJB+XNNjcQaQhL8
	 Koi2y2JD+WDdJ+zB0mtZl5pAtmUpiQJvGlCvSb0xoy3uXa3FSKSvERkCQLZ96RZjx2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081686;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KP9LMMCHlbLBMOkVCcd7UG8Nxwxf/ICjqXKfNPoI3dM=;
	b=KtsyKGk9IDaJDrVbfcJVBa0pDLsQ77HzSsIHgaOH5KtPrHpTBql3sm8el7zj+/5FQ3Cj
	 DYIbiGewnv3kLffEq7BXz4RyvG+WXc/YVY2WxHfNVpWlIORaaXfa8vYtrxNrEGwtiY8iJ
	 wssVlSyuilUIj64ViEB0ZJjWoj4B0hQWBecjuw6oBGkSGiF5MbvyrXqHChTkeuwnp+ueM
	 086wSs7XPhsz23+LNdVb4cwDDBkRScbjnEVAUNqx8q7wu/4ZH7NK3fcJ7BP20MDjvauOo
	 1uUAT2pxsWE6S2Rk0L7isJ1mM1Gn4GWgHhmWc7b5NMGcRdTZlnqKW4N2oWfTip+Oi3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Um8EXD33;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=b86u5k7w;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DED60A262F;
	Thu, 19 Nov 2026 09:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96DED60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Um8EXD33;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=b86u5k7w
Date: Thu, 19 Nov 2026 10:48:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795081683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP9LMMCHlbLBMOkVCcd7UG8Nxwxf/ICjqXKfNPoI3dM=;
	b=Um8EXD33M7Kvu6mhBAOuAlZJw9wI3HXyqR3HAuS1l4RbitbmO/oEw7dNSgfbmqXRSQfU4g
	0QepaSvM3Fq54lQesg16cTyULb0afzptbMEhf46/yT6U6CzgjSY9aa93utt7gQ7sxaAhwm
	4IG+QBxE26dVZNIT5Rm0ujA4n6ahRn7111WmQtCbQU+h/TMwJf5ZOVZJZF/z5pNsYyGf46
	sdzjifTKxdjToqSyTtdr/BJmxyEBSnP4b1yA0xtJVRR/mFd/a/+MBY4Iiszt+fFR7kVkQE
	NUYoNp6DC44pGA5VfpeK4nhUQKo+qO9zLio0JSHoo2DCmh2NSWqarOFprQVUZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795081683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP9LMMCHlbLBMOkVCcd7UG8Nxwxf/ICjqXKfNPoI3dM=;
	b=b86u5k7w9ZGTzxhGEOSQ0ycoX57vkQkatQj2pcYRKRi57XdXNKtPGAgQ7ibv3FLi0ncNdh
	v4kmn8iSq4gjjODg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <jfern@kernel.org>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/7] doc: Document rcutree.boost_disable
Message-ID: <20261119094802.qh6UUaw8@linutronix.de>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-7-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116194438.306618-7-jfern@kernel.org>

On 2026-11-16 14:44:37 [-0500], Joel Fernandes wrote:
> Add the new rcutree.boost_disable parameter to kernel-parameters.txt.
> 
> Signed-off-by: Joel Fernandes <jfern@kernel.org>

If you intend that both changes (adding boost_disable and its
documentation) are merged via one tree, why do you split it in two
patches?

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ac97cbd98b46..8f91499b3488 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5651,6 +5651,13 @@ Kernel parameters
>  			Set maximum number of finished RCU callbacks to
>  			process in one batch.
>  
> +	rcutree.boost_disable=	[KNL]
> +			Disable RCU priority boosting at runtime, even in
> +			kernels built with CONFIG_RCU_BOOST=y.  This is
> +			for testing the boost tests, for example by the
> +			rcutorture BUSTED-BOOST scenario, and should not
> +			be used otherwise.

If so, why not limit it to the test-module?

> +
>  	rcutree.csd_lock_suppress_rcu_stall=	[KNL]
>  			Do only a one-line RCU CPU stall warning when
>  			there is an ongoing too-long CSD-lock wait.

Sebastian
