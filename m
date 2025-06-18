Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726C2EE98C;
	Wed, 18 Jun 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267305; cv=none; b=DQ2GIHXUAKXpZaIJFeixkTVCTI2dGqxoCHksypV/o2ourTL2VLvUvVuxGWt6vLuR/u+FmxT8EZ9mXAgs3+bE3bgLE7JRciV/b+o+N2AFUEgyS/RNwj8bRX1zu3+Dg8BVFvqS3d3YyvQ3dNcwxQE5HhBS0lJ76fAh9LemTYf6zMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267305; c=relaxed/simple;
	bh=FkWozodUKen40StoXQS1uyQvcdO2JECfQGlSZypGNZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gghwq1RnD9hs0uetGO/q2JVgbO5FWnZyxzxOYMZUM3KdVPiKY5hvpDg3LNJ/CkVu6L6UJzgWPxrG0chy5usvFA2LJ2XJeYjvQm067Sh/KGrhGjdN+5yGszqfM7lEyczetvKlDLxo6+skDEhom0M6jC9WmzuoFhJrlTihM0Bje2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdU8ZFBy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdU8ZFBy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so94910326d6.3;
        Wed, 18 Jun 2025 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750267302; x=1750872102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0u+i+peyVQga0VUutMCyFjioDjdoFJwmIZs7VrpQUg=;
        b=BdU8ZFBy6I/i4WP4xi/EuqeRrVRbxexyMA2KS4E8egucCulgJErxoaQxjtQ3SHYvjI
         q6GOVr2q0cXxEq5RQ6oPn4oKQ6WGTMkUPuJPASAUG9jbH87iv2Mcw8iEvfOYvvxN7Vqr
         f7w5NCaO/a45NI4kJhbUTSTVYjRuzM29XgUa4b5d/CC4pC+5Ro5BKrjgTlFYZy4lgHdJ
         1h89qULjB8yv5Wd0c1Jp0aXufJxCYekzVge9RXjDrw/8JP/QslHqiqqzPLbQWzGCfior
         6W/cSLTg0vCrtM9lAXywruqGU0HqREsk2VDRqP9Ov137lu2Q8gooFML84ufkI8bsshgg
         /LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750267302; x=1750872102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0u+i+peyVQga0VUutMCyFjioDjdoFJwmIZs7VrpQUg=;
        b=gn0YeRfkRCFOuPMsE2CVUuqSgY09cuXk0XH8FKASbWvkUBscDHDVkLDNl+DYBx27ZW
         JwssY95z4uThKcjwX8BVSEt89xroI4+0MkNyzxaS+6xbjBwUOFI8tMf+3V1IqKkcinaA
         Dex4kGsrlh9UJEUojHX0wJU6wSzMQ/tRoyDrtrnYl7gfnewfeVc+rgQ31ou++MDO8tAY
         +Ne4gck6LlPvQ4NLAos1O9uYnnyKP/ANBcEs62DWsGLE2IZ1rgJQU3K2wTzRL9GHaNEf
         5wF+WAIX8ohPZBzxfIrIKpLmgxSUzgiiZWIgR5Rz/ihG32eMHaoc7cdvsPsdIdbKXDho
         /hgA==
X-Forwarded-Encrypted: i=1; AJvYcCU6v6pqOjEGcvFl9mVbSWsHU65CA/WtNfZNwvjb9VIS625lyiCY1FKcDP+91l/7bWzkdgwj9WN4NSterI/2vteBDOg=@vger.kernel.org, AJvYcCVt7aUFN0C2FrGwmhQ4dEgQrOLTx1SSqSC2V5bxcyJqmz7yRXKSzSaHCdQ9Fpw7g8LyycmW@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxY+aRX05eapzBBXo/EgjiixVekIEhieukwMs1uDKbnSs7XJL
	jr2hOo2FaJaMzBDpgtSyyagPIgASyvsgoNGwkE0cjBDY7zuI3ngyPpUp
X-Gm-Gg: ASbGncuHLvbOR269rc1NOZ27UasHmih+LoGaLo7CKo4bFjGbmMH4N1lzz80DTMUPuWY
	U6OmZZentoAYZkRKXmCXVyKJPYIhZg9UvDIMlt7A+LUvr13QY2ri+uE6yWvI0Ab4i2bcRbiNeLF
	3GWf4FnSCkSRILo1oJNTjWWTU/7EqCUTzaSq04ls1A+06R/ytmYLLGs6BuIr0covmW8wOwFbTkB
	qhW7do25i/SItOr+RCDqoHdO86+YZCDzFokAsFNmR7h+HtSFnSARy43o8ZXVKlonDg/h0jTcw41
	TprPJmZDL1DDlEVzio3UypGiTR1vufXpSyOYU2PAX4gOGFAzHL/X2n+9G/iNIhebUFLnc/LUHsd
	JBrM3snAbQc6lQeb8hdCJDauhqcEqdVYckXatlXUzXRzVzKKzHVHZd+vnxVRLDmo=
X-Google-Smtp-Source: AGHT+IGMkqZ89ihj8ugCuPYfIGdOfyar11u68nXEwEXSKQEgU9BnoCP9kqRwqbrvC2a/GH3iDHpoOQ==
X-Received: by 2002:a05:6214:2527:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fb477d995fmr296774456d6.23.1750267302291;
        Wed, 18 Jun 2025 10:21:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c55ff4sm74731226d6.92.2025.06.18.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 10:21:41 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 717E41200043;
	Wed, 18 Jun 2025 13:21:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Jun 2025 13:21:41 -0400
X-ME-Sender: <xms:pfVSaAw4X12WcYUMSJe7e4uOeSOpRVNzeeqDtPrQprrTseQ7U-QzAw>
    <xme:pfVSaETB66gPgWNezDZbL-3GnUO3IxPlHsCXAWAJbGPPj14UGEAzElBQmP9gm8dlj
    7_vbP3iYQPQJIbLYQ>
X-ME-Received: <xmr:pfVSaCW6FNZMl2SkPsmLG37JGibqWdXE2klFIJkc3Piqo2QKTbGuFcLY_z1xQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtoheplhhinhhugidqrhhtqdguvghvvghlsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhtrhgrtggvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghl
    rghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhshhesjhhoshhhth
    hrihhplhgvthhtrdhorhhgpdhrtghpthhtohepjhhirghnghhshhgrnhhlrghisehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:pfVSaOjrD7t8ihquIN_wdaBaQ_pQy09DADhtsqpE9A2AsUB5KTqneQ>
    <xmx:pfVSaCCm3dnKo6sHwvLx3UpPOLkUfFlk068b0ZN9N0LcQ_ezYYmdbQ>
    <xmx:pfVSaPIXB02zpSRAI-h5AzKWHMQHko_N_QKvp4yrsiKv5HGs1NFjOg>
    <xmx:pfVSaJAvPo32qj6ssNo0y1_T9wlCm5fbJHKGe2iI-EY61DNBhpfdGg>
    <xmx:pfVSaCxtpsN63EVstI6VOCPUQ2-JdQzRw-foJJ255sG5J1OwZAPmh1gA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 13:21:40 -0400 (EDT)
Date: Wed, 18 Jun 2025 10:21:40 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <aFL1pIGMDX5DG9f_@tardis.local>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613152218.1924093-2-bigeasy@linutronix.de>

On Fri, Jun 13, 2025 at 05:22:17PM +0200, Sebastian Andrzej Siewior wrote:
> rcu_read_lock_notrace() follows preempt_disable_notrace(). The idea is
> provide a rcu_read_lock() version so that the preempt_disable_notrace()
> user (which use RCU-sched under the hood) can migrate to preemptible
> RCU.
> The first user should be tracing (tracepoint) which is using the
> _notrace variant.
> 
> rcu_read_lock_notrace() is a slim version of rcu_read_lock(). It simply
> increments/ decrements the counter. It does not emit any warnings if
> RCU_NEST_PMAX is exceeded or patricipates in STRICT_GRACE_PERIOD. It
> also does not participate in rcu_read_unlock_special() as it would if
> invoke from NMI.
> 

If it doesn't participate in rcu_read_unlock_special() then it may not
report a QS in time, right? For example:

	CPU 2			CPU 3
	=====
	rcu_read_lock_notrace();
				synchronize_rcu();
				// need all CPUs report a QS.
	rcu_read_unlock_notrace();
	// no rcu_read_unlock_special() so QS will only be reported next
	// time we if another RCU read-side critical section exits.

Wouldn't this be a problem?

Regards,
Boqun

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[...]
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0b0f56f6abc85..02cccca917a22 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -420,6 +420,13 @@ void __rcu_read_lock(void)
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_lock);
>  
> +notrace void __rcu_read_lock_notrace(void)
> +{
> +	rcu_preempt_read_enter();
> +	barrier();  /* critical section after entry code. */
> +}
> +EXPORT_SYMBOL_GPL(__rcu_read_lock_notrace);
> +
>  /*
>   * Preemptible RCU implementation for rcu_read_unlock().
>   * Decrement ->rcu_read_lock_nesting.  If the result is zero (outermost
> @@ -445,6 +452,13 @@ void __rcu_read_unlock(void)
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_unlock);
>  
> +notrace void __rcu_read_unlock_notrace(void)
> +{
> +	barrier();  // critical section before exit code.
> +	rcu_preempt_read_exit();
> +}
> +EXPORT_SYMBOL_GPL(__rcu_read_unlock_notrace);
> +
>  /*
>   * Advance a ->blkd_tasks-list pointer to the next entry, instead
>   * returning NULL if at the end of the list.
> -- 
> 2.49.0
> 
> 
