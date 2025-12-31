Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584712798F3;
	Wed, 31 Dec 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201227; cv=none; b=ASJ3rU1qc6L26hy8T6ldTF2UZEmIXuMNpQdgosnJFaF/2Z2VNNy/V3loBgM5IbnkcdRP+Ea74f1ikgCL44JJvmG0zu5tK1dXPbw7MXkeDwG5oEVMzExRFapB+/VRMgbq13cvCmGGZZbQTC+3xcr/BQHbMeAVQoZRn6FZoAdrxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201227; c=relaxed/simple;
	bh=1XadhEuR2VsJTbFXegv14gLCVxhAt6I2wZoD9qp9GuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWdrTd5C8eQYIyTkqepEbs+fo8E9mpuUU7QhypxIvF6FhiV+5EKNlKZAORYieKGKaDUS4e/L5Twzz/2zF4DIuzLoGk91wo+ZU77Pfju0U1zkDgVX7jK3Ak+FSH55hIIYp5ZQHutHqnRyOMgjrlIN9T7LukQwLVBg6x/j4O35znc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hv6eelmS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hv6eelmS"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6D31A40E0173;
	Wed, 31 Dec 2025 17:13:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n-OA-mU1FlqT; Wed, 31 Dec 2025 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767201209; bh=RyfAaYuEEZrJ3H82B74fcLS7Oxet/UVYoW8ry1R4raI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hv6eelmSn4fj4di7jcYxpEiNKeOknQZO/tCbP0uASSzwoe45dxolscBYGNl7qp6y/
	 yK8gji4m+ah9scUMNKdND7Mp5k7U7/eqAmQLgjH+yW4K0axSQzK3N/sKrhZEYT/42T
	 nua5yFeXZdBp2FkN7WNVKnR0EyGatV7EunYotwO4iZjaMmxHU2cGKdJaUBVoNexlLd
	 x5d4UdRo/RzveNoluEC1vu0IJ0IxlZNibCb9chAYE/gbTcqa2y7dqLZgNNNff5/vlm
	 EuuKbjE9Nzyy0RNSNO+zdAzPqP2cfVuN9NPT9LlMpRo7r5FrCr7bZNaXJWBuM7z8U/
	 V60t16pAQnHEhiAx7geRhxWU6E1Rtf5YDx7mN/5fb4T3L6vz6+0uxzy0CcunUewl+i
	 8llfIKkDNxQR46hT83pyZ0ueXmBVMa2+PTth479Dr+24M8IA2Fo5jXrVk+6APv7AaH
	 iBA3GtLeG/mCMqYdEUHp/r5P5nRwIf6vj3nmPCfilLZvO2nMrb+yCOAAdiJSPYwjW8
	 m4zQOmi9jRJZAaHngesuoZPaXaUswXGQDEXWPALWC4/6h8l2hNbkVTNtoESQMLSh9f
	 zy6TL+njNq6MIBRuP4piHL1sZQHoDJ1vrTq1O73t8PLTtRnEbGicf4wIvwQFqlPLZ9
	 KFVOdS+SU/AL4gP348BsHVnw=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B468740E01A9;
	Wed, 31 Dec 2025 17:13:24 +0000 (UTC)
Date: Wed, 31 Dec 2025 18:13:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v4 1/2] rcu: Make expedited RCU CPU stall warnings detect
 stall-end races
Message-ID: <20251231171317.GBaVVZreLiknrb8zWT@fat_crate.local>
References: <2ca142cc-0487-45e2-830e-8ece0fcd72cb@paulmck-laptop>
 <20251229191616.693898-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251229191616.693898-1-paulmck@kernel.org>

On Mon, Dec 29, 2025 at 11:16:15AM -0800, Paul E. McKenney wrote:
> If an expedited RCU CPU stall ends just at the stall-warning timeout,
> the current code will print an expedited stall-warning message, but one
> that doesn't identify any CPUs or tasks causing the stall.  This is most
> likely to happen for short-timeout stalls, for example, the 20-millisecond
> timeouts that are sometimes used for small embedded devices.  Needless to
> say, these semi-empty stall-warning messages can be rather confusing.
> 
> One option would be to suppress the stall-warning message entirely in
> this case, but the near-miss information can be quite valuable.
> 
> This commit therefore detects this race condition and emits a "INFO:

s/This commit therefore detects this/Detect this/

> Expedited stall ended before state dump start" message to clarify matters.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_exp.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

But yeah, makes sense.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
