Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741F355814
	for <rcu@vger.kernel.org>; Wed, 27 May 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921125; cv=none; b=OpGdxFw1zwnWkyoxwHBuWf4/pBFJ6oa+e/Gpl/zfEi8Xz8wggKtDweHFJegr6emMhzzKFXkySH5DRV1PE9QskRWpCzZGlr3TLrtTYI6/TUSyF5CHeDlm9ceXucl8CzN/YUBj4ZsOq9YLJDMuCEgeLt6itWy0voVLk0xpKmejWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921125; c=relaxed/simple;
	bh=VdUeSchs86f9vX66CZ+VXMU8lHxefT2hr+9kp/9VJxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQuW5d0eXDZEj5ElfCWds3TFOAvtHZ408unScukkA7+TPne2Fjto7FqKkEZ8QU4/PdnPgXAUQQ9be+lBmZXDbh0LPKEP2I2KIRtI7oCqwPm+xCm38OavXsTjxsLbtr4+ZcoDqYISKpkOIbmKBfdTZi9YWVCaGaA46YVAcJxXyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtRG6BQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtRG6BQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919501F000E9;
	Wed, 27 May 2026 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779921123;
	bh=uim0KUHhCNW4Xk1ujwk+EFCfNqh592TrXY+yicd8b1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jtRG6BQxBggCFNdT/SUT9c2KSaQWemWVqvbV4AL3fSyMkqp1+hw6p9PwQXCrC6eB8
	 V2xohyp1+dOIRpvTwODJpoLWtqYqX2hRz8jxepmYDlmhEVIwQ/a6IZmy8YMs81AZfb
	 I6E8W0KoL9M4B6S8OZwI501J6Mxk6x6IJv/+WBA0Hrb/6NH7Bzrf4EpPuT4oguU1JA
	 uXOFYNK+6ZnuyGmpKnLnHyUpKOVgd5S+1b32QebS2rKmw03QwEDE06/w24Oeexd/rn
	 m4noR6jm66tIbpS+wr943Hg6JEWrkJBrnKQ2vFjF/WtJc6d4PQhwbB9lQc+zRJcDDN
	 W4+UDvMI15PKw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id CFFD2F40076;
	Wed, 27 May 2026 18:32:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 18:32:01 -0400
X-ME-Sender: <xms:4XAXanf-jEtty9DVdZGY3xyHAFM7gJlaO3Pv6KGIQH0418sVJn6PcA>
    <xme:4XAXakTZtl-1Q9JOt1mUdCetIO68lr_mZPk7udBa1Bj2JYg1iLAFBHw5ZiIzwYXEG
    xeskeV5DXU1J7VwwOz4CmGbfQ9nP15CbDSkH5AIWtxXirZgtIx3WQ>
X-ME-Received: <xmr:4XAXaoO7h1RzDRur_quYeieWMgpOPH_PGPyJ7surWpv3J0nLaH1gKNjlp_19Cnb7Btt42TnYRd1xAVAnZiR_2pvMENevrfKr>
X-ME-Proxy-Cause: dmFkZTE0lWlpMSJl6yooUuHXke2rrr1vFNBjrC+xN8K8sAsiNvprLQA56JgFjAEqUx4HhA
    OiKz3M0t9XLx9Ccl4N9lrqFKvonyje+R6snitOVHTsAsPcnsMaehtREuAFzsDqlBZRssYG
    lMyS0rwX1UxpfevmB5tg7pv5mNViiIwCWCQ2vik8kMUnX1xWWiU3gxr/bdyCEJjRfPh8Ti
    Y1hAFbZv59L420LwvAGCouKgYWg8ToPGYCiUHH1dLUb8FNKFKAiKWz3AQsYe5JtPbKz9+J
    A/rV1H0M78VGBrIL5n9XNtRJksPQuMf4+bufm1cYcnmvGneoDkNLtR1X2G+PIWe09JhLaO
    Ph8ajQazRsV33CfebnA/mWHnipB/C93688/EVtgkPB3of83ThECAsaBlXQkbrcUnlMgcRU
    fa44VTKAqz92rjeTU8+p68k+J5ipHgSEQJ2gcy6K6NPB84DigdjzGSINKV8CV0Q8TCCg0a
    MtYlpyPZZLkJgcD+bXOMDhsV+xeJJU9zBFmhPAqz3KL0PwdByUT/YexYVlRhfbI2TRJEGW
    jK3RsDmPZ74rllZ5gr6n0lRQXQ6Qxgq6JS1/Nb0kJLUCTxrKnu31kNN9bckrUj46zdE8FL
    Vf/ICxSF8yiuz1TMNCzijBTcTPJDaD1x/ztV+ZrGFMYgEiEvxHdBboAhMbCA
X-ME-Proxy: <xmx:4XAXavU8FTFh-9-3Zt9wNp6JhGea3_mq_miVMyU7v0mt3g28dxMG7Q>
    <xmx:4XAXagYgZSGvU9CEkDj3q73r11hTmr9HGOKJZ89xpW8LefwQus0poQ>
    <xmx:4XAXasu3LWo6z4pj20mUOE5li9_QTsF16qPvR8ArTzuB7jj_d2TTCQ>
    <xmx:4XAXavmn6lw6lSgENuJ7e6VAeieg9Xbf-qlcw1OBQySG8XsaOkNJAw>
    <xmx:4XAXatXiGtX2JrpiWO-o-7sqYWkue601OEyICT-88EGUx79E3WUh0BhP>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 18:32:01 -0400 (EDT)
Date: Wed, 27 May 2026 15:31:59 -0700
From: Boqun Feng <boqun@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	peterz@infradead.org, fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v6 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Message-ID: <ahdw348VjaX70b2x@tardis.local>
References: <20260527203615.163688-1-work@onurozkan.dev>
 <20260527203615.163688-5-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527203615.163688-5-work@onurozkan.dev>

On Wed, May 27, 2026 at 11:35:35PM +0300, Onur Özkan wrote:
> Include Rust side implementation files to the SRCU maintainer
> entry.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>

@Paul, could you help review this? Also the patch #2 since it changes
the C side.

Of course, your feedbacks will be much appreciated for the whole series
as well.

Regards,
Boqun

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0b307b2108c..7739a435f258 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24624,6 +24624,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
>  M:	Lai Jiangshan <jiangshanlai@gmail.com>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Josh Triplett <josh@joshtriplett.org>
> +M:	Onur Özkan <work@onurozkan.dev> (RUST)
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  L:	rcu@vger.kernel.org
> @@ -24632,6 +24633,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
>  F:	include/linux/srcu*.h
>  F:	kernel/rcu/srcu*.c
> +F:	rust/helpers/srcu.c
> +F:	rust/kernel/sync/srcu.rs
>  
>  SMACK SECURITY MODULE
>  M:	Casey Schaufler <casey@schaufler-ca.com>
> -- 
> 2.51.2
> 
