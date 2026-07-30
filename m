Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C028423783
	for <rcu@vger.kernel.org>; Thu, 30 Jul 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413958; cv=none; b=Ozj1J+SZPHoWnp0DkZ0a5JCF+QiUD+Dfpz/n48p6OjmZR81BOsNhTofmMJgsygbgdzOBJ2sHofeCZxzJxjE6lRXZBnwl5HbHoRHcL6OcueISE/s3jVBXQRTj50dtC1BCNSQhNpFEBOjoAnnQfoculMpfHZstU7FAkzYVh/6/juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413958; c=relaxed/simple;
	bh=ChwpBgvydSRCyl30CYsOXGRWljoGGY9h81QLREQDLPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw2et1Bk2ksahCNLOiRmbEDLnJOyQg3PMmlOYB3iSYvM8/DVWdrgEpgqVj/VdvPj2k7Vh7mkzQYawXC8RasQFZfHDLLL6TqIAdaAOI2yDhpY0dvVgymc/R0N8b5O5eVfWERaFS5lqWUzuDEtsXgqlLX0jRYq8OHwC4oZolf2egI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=f6V3VpJq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="f6V3VpJq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso13859755e9.2
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1785413954; x=1786018754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aGfVWtxrVG8Gs+fqhc2m5PVIKlSxiEIBozWBl1vrMD4=;
        b=f6V3VpJq0HGmnMSl04/RHdEnlAxgcPgjXxluE/FnFhlJR+RX+juRF/IubAyb27buJH
         sgmoGZyPhzCr285CYwPrnYs1eLutvIHxfBQEnkn0OdVLR+psUXBt7Ul62AaJCIa/SgfY
         N9Ul7Q8BjOKVbFJMnYYo5/qcZ5xH1Hcb75oskLa23tvzvLFVhUT6WYlhlV+5o8BdbA7J
         pUHKp/ZbL3MD1MpY3MAmyCnIdGB+bA7O3BWdaDo4+DMPOVybo0KPBOZg3CQ0zpRLLxUy
         i5Raw3SVZZw0tKnITWTkNxIUiTiyWQlwJoVMwB0jFxRnGroI40xV/0JG/yUAfXQxvlxi
         f8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413954; x=1786018754;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGfVWtxrVG8Gs+fqhc2m5PVIKlSxiEIBozWBl1vrMD4=;
        b=VVBcQeUtKE3p6O1RrEn4titwfqJ3KAvN0NB0lrHP4Ivy0bxAfZA0DGDj9RY5/HnDGt
         iCRYvt3t5hcoAiORosP06oLwxiQv9q9rDRD+9fuvXbVte80wSeV9b0huDkZyl3IAcj6U
         Kw/sSbxM7OXiipVZ0ZZehTLs/puMxrQwrxGRLyv1bzpaWs3+a2zxW1lhA17ZKkdnAo+4
         eP91pjLUt9pAmyb+MC9HiMTY6T+boaftreScwBb8XrdI/Z0dhVG8I6JWNidA5EozFJHj
         jfebXzcExxZMFa/bbWNDMDFbyLEUY7buV6JAz3GFOjYbYXsA1NqaonFUNEfLZg2K9k0n
         CmpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPxVFO+PolDqmqZ4xcIfhbGKhU08YE7h2o5BxLarRtNGc31ziccbMsZ37toBvbme9pOnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/pAMPd5c9d+En7e8Q+QN10LHSZniHCsWR1GViMXRpYDmSWtZN
	DbQnkU2lYcM9eEGRlmvsNwiuSwPgC0Fif9NuD+TVKul2ykE4qHGNebzIMpyAuM5kOz4=
X-Gm-Gg: AR+sD13x4mgw25fiHo1VApzy55os9j52covHSeAiByv5C5Xgv1pZlGn0h+quYW5Gx4y
	KzSSrjU8Lbc2yTWdNa7eH7NU4VH7pYjqQKQ2JlKhXD+jFCr6JdCci5NxRRAKw4bIFsuMZV2sLdW
	UgcxaKOJAmh0qCxIa263HiBUIbUsUUW+W8Vty6i/rQqweegJpmtTRExzp/Yb7ITsjsXS20HB2J7
	VlVQnstonWSwtFFiiU1ThfOqYDk7u92mfLvX5auC1rurXIPqHVNrQLgD8mlDilX8y5R9mEKNRKS
	NM+d1xInuYhacjJy1SdOYuAi3c9un9Qd/XLiAPHKBKblzUlXfOPxK334V0f6PKhmZT+vl6aYDCY
	OgFVQhLZuOCK4GYfzXujgR6duslXlT6iSpj3J0JSEffZFIR13CzfGikubkH+b4RgXyy+AZ36B3O
	4taca13UlZC69L6pd1zwKclS+/DgZejvkN6DvHtEbftT8TWx0=
X-Received: by 2002:a05:600c:e548:20b0:495:6022:5a14 with SMTP id 5b1f17b1804b1-49800eb98b3mr22025465e9.34.1785413953494;
        Thu, 30 Jul 2026 05:19:13 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:ebe::178:11c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aae15sm58243785e9.13.2026.07.30.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:19:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 13:19:11 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <amtBE9JlGBPwsIuU@matt-Precision-5490>
References: <20260713101245.3207634-1-matt@readmodwrite.com>
 <amiGJWJ-tzUMYizu@matt-Precision-5490>
 <6f002779-3607-47d8-af61-a74eeb987e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f002779-3607-47d8-af61-a74eeb987e6a@paulmck-laptop>

On Tue, Jul 28, 2026 at 11:44:04AM -0700, Paul E. McKenney wrote:
> 
> Apologies for the delay!!!
 
No worries :)

> Alternatively, please do feel free to hold off until we get the public
> posting of the call_rcu() and call_srcu() deferral patch series.
> It will likely provide a helper function that you can use.  To your
> credit, your initial definition of the irqsoff local variable within
> call_rcu_tasks_generic() is what we seem to be settling on.  It should
> also clarify what needs to happen when a CPU goes offline with deferred
> callbacks.

Sure, I saw the patch series and will piggyback on top of it.

Thanks,
Matt
