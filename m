Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C718C03D;
	Thu,  6 Feb 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863489; cv=none; b=TJkdq3O9JP0cZkJMTnnNw6b3ezi3yVPnaOAyu0rhHzXzUmgq1I/+gw/DQiFvLOtbew1Y6I7Gqlo6cJ7to9xEQysSZvT3cpF/euhGGKgnspqTmQba1/I7h0iaukHoH+QZmrWA4Y1vKJ1NFsWectuwvLRdSHAX8Mz5QjxU0HQHxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863489; c=relaxed/simple;
	bh=dqJ4n9Q3ZVtMUaFbbzHiUawoZJfE32xuznAZa6at1pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubRQgBj79RkoLq7Nl7Maw0e1nW6QahBdOyLoBv5pM9r1lfkmHRM+8UorplqW69qmgcvVtSa3RWPKasHCtpG3OxamTGqgSSJ/yaFgbVxP0gfbwaUmF96NmbE8UgaGdKlcVl2UMo8dZd6nJRXZa7TOMMvCEQ4sIF5fX6xfLT5PXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0WQuEwY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0WQuEwY"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4679d366adeso11687251cf.1;
        Thu, 06 Feb 2025 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738863487; x=1739468287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXvQ5Oc/m98jyk1RhupMsIszSXWKUMyfwetIuKs4jAA=;
        b=a0WQuEwYlC9s+M6ng+X5psGljcNmNrrDwdtAwavWpSrYaCixt8NZD9y5crvGfvYXq+
         5KmZCH32gvMiQ6xxsz2YV8lJNf4piQfA+S1Q4lQtGBCIWm+1sdsojFSbzBIWwZP4Cw2X
         7kEwn/4lWEAbU6xIQQ07dOL1maAl8LMv81zYZmNG14pDf66jwzjkoqEHfmS9UB3Y7281
         8F1x4lvFx+IjwtLAe9PIsT3PnnUOz7Yk0XaHo2QkRvY91zUPecelUowGvam4BUz2T5ex
         ZgV10Qasd4uir+JBW6oH2b9F2vR5xxXElAAwdRC1A5PPGMi7buWW3ZRc2pvp0Sac0eHW
         9J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738863487; x=1739468287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXvQ5Oc/m98jyk1RhupMsIszSXWKUMyfwetIuKs4jAA=;
        b=u5TIIo+oUYcZ/CcZhm62YlgNEAFyrcDzT/45stQVCa3VdGHdncha5npP9sfcwLETlY
         aTGbHCa7AMusO87H5pf7Xm+rCksC+E1U6A26+Z02BNJrr+5X8QiSQYz5Kp0x+fnPCYao
         YlPvISmA1qCDDAt/R2YJbFYWOy5iaq2qmg/8mqJBvLBizBj3HohpJag2hqvLkuzhk82W
         x907UmcSzgoWq1cQOs9jpPjaFQ2jg1J/zIOJSVWzEplWm/BVR1S9lskfq0p+RVOqZ6ST
         MAjy3mkJvdl/knv30Lf+04UlPK+49pgl9D7Mu3/8WXr/ff8w++7ad/W8EDswp39FQkR+
         daWw==
X-Forwarded-Encrypted: i=1; AJvYcCVLYsehQ3f4OAzKta91PDyowdH0sIPPLh+Kji0+bl7lTs0xhrzrUHIyQqTA+53XzYHf8Ac5Th57m5ohA14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqoPDr+fDcuq+cZuBr+7yYKjBmEr6HMdSYENCZP4enHHW/445D
	72EIswz1oENB/bbPJj6dLGd59Ruk+0FanMaQx3bCz3gANkOF1mNL
X-Gm-Gg: ASbGncsW9SQtlqsTbBBswBMngGVr2VeGfdg24iftZDJ1GkVaXYV3t5uYXrGjBh3zwjj
	WWKCNPaEP7pVVIZeW5WTuzk/fRH121ioBAr0AfdxBD+kQpuPm5N3ZXWdpnHtAPLsQAfrdQgWfMn
	6U5o/l42Fk+1MvHrsZguUuJLhAik9gqOdICbVH4I/v9yCwMbCwsqEp3jcG6klMzh8JodL/kuETS
	d6Kxxkb42pB8i3bMplDT+lUSRAG2XNb5sfo6d4cRRVODI0BouumWo9bqqPBCVal3/CcUdALbi+p
	LIP18oL0qWV7R2EwRdJsrX7iAnX+bFFPod0HFGTT2kZPiB6jNKda1mkXG3OPEi5T9h1jzaoASLH
	dRx/J3Q==
X-Google-Smtp-Source: AGHT+IFzwIat12wI/zpa6cZf7XjFOO+p/98ordKeVkTu/KP2O23RX3u6+03GYe3oGIQayjNBOgcYwQ==
X-Received: by 2002:ac8:5992:0:b0:467:5cd2:4001 with SMTP id d75a77b69052e-4703357d6eamr51550521cf.3.1738863487082;
        Thu, 06 Feb 2025 09:38:07 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4714928d97bsm7390491cf.19.2025.02.06.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:38:06 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 02CE7120006A;
	Thu,  6 Feb 2025 12:38:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 06 Feb 2025 12:38:06 -0500
X-ME-Sender: <xms:ffOkZ5gLbdOvBP-vbsuD5FkPs-6Cq9msxRJIUqvcZHmDDDoLWyZaEg>
    <xme:ffOkZ-Cb7sVIqf_LFl-sJ8XzduwYlmcto-VOi1_DDhTMZiXACeRadT5WtjvqWyoyx
    zOebxEzrXu7v1mtIA>
X-ME-Received: <xmr:ffOkZ5H2g5B_NEjn8iFDUdkiFiAI0d4WUvk06K5miySZTgSXl_yHyY8vYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvght
    rgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtg
    hpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopehvshgthhhn
    vghiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ffOkZ-StRWhvSY4jgcthUiD0F45GOrDEUjLnkmTywveChLT8P9L0TQ>
    <xmx:ffOkZ2ymWUIXuSqtaw9lnKW6p7jqfturDaqUQMVhsJcuwp_hSwcFrQ>
    <xmx:ffOkZ06AJ2AmCWvVtDYn3N0e6t2rSC43h1kvDFPmU0R6Lh5XbwYAKQ>
    <xmx:ffOkZ7xGnczSsikgIjzOGrJ9J64pwF9RRg5YxtBLgi04rqjBj1KYNg>
    <xmx:ffOkZ-jShLKmQh8YHw9IV_uZPq8RaQaykbYYIEOtK2S3fWtlf4ixqYPG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 12:38:05 -0500 (EST)
Date: Thu, 6 Feb 2025 09:38:04 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, leitao@debian.org, vschneid@redhat.com,
	frederic@kernel.org
Subject: Re: [PATCH rcu 6/5] Make RCU watch ct_kernel_exit_state() warning
Message-ID: <Z6TzfG4UZyKcpRzB@Mac.home>
References: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
 <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <bd911cd9-1fe9-447c-85e0-ea811a1dc896@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd911cd9-1fe9-447c-85e0-ea811a1dc896@paulmck-laptop>

On Thu, Feb 06, 2025 at 02:15:09AM -0800, Paul E. McKenney wrote:
> The WARN_ON_ONCE() in ct_kernel_exit_state() follows the call to
> ct_state_inc(), which means that RCU is not watching this WARN_ON_ONCE().
> This can (and does) result in extraneous lockdep warnings when this
> WARN_ON_ONCE() triggers.  These extraneous warnings are the opposite
> of helpful.
> 
> Therefore, invert the WARN_ON_ONCE() condition and move it before the
> call to ct_state_inc().  This does mean that the ct_state_inc() return
> value can no longer be used in the WARN_ON_ONCE() condition, so discard
> this return value and instead use a call to rcu_is_watching_curr_cpu().
> This call is executed only in CONFIG_RCU_EQS_DEBUG=y kernels, so there
> is no added overhead in production use.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 

Queued at:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git misc.2025.02.06a

I added the "context_tracking:" tag to the title while I'm at it.

Regards,
Boqun

> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 938c48952d26..fb5be6e9b423 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -80,17 +80,16 @@ static __always_inline void rcu_task_trace_heavyweight_exit(void)
>   */
>  static noinstr void ct_kernel_exit_state(int offset)
>  {
> -	int seq;
> -
>  	/*
>  	 * CPUs seeing atomic_add_return() must see prior RCU read-side
>  	 * critical sections, and we also must force ordering with the
>  	 * next idle sojourn.
>  	 */
>  	rcu_task_trace_heavyweight_enter();  // Before CT state update!
> -	seq = ct_state_inc(offset);
> -	// RCU is no longer watching.  Better be in extended quiescent state!
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
> +	// RCU is still watching.  Better not be in extended quiescent state!
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !rcu_is_watching_curr_cpu());
> +	(void)ct_state_inc(offset);
> +	// RCU is no longer watching.
>  }
>  
>  /*
> 
