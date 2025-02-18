Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4948467;
	Tue, 18 Feb 2025 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838347; cv=none; b=jZZl8c2STeq+bCXOP6gKZgTy/Kq2O8He+myCw0kKTIlcJR2GEM41muccr8D9VCdjyWKYXU9/UfRDj1Fp/WbQ8b7bSEC9zFbXvFUn8GB2+u90M+79tR8WJfviNShyZ9zYiJFzpQUx//yWhX/h3gOLMSPu5NKztEaoTHFTIriny5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838347; c=relaxed/simple;
	bh=E9hvgOUIgiRUb7KRvtyAfMqOE8J7c//JpvPgWEg9fSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK8Yqz7R0KMl2/yXEYN4Kvk5J+c7QsuzN1wzJs58+icNiea1vmjzd1XH7lZgGZaoV9xjbCFkqH44LWrkI5EjTsr5VJLe8OcMGUH1DKYpHIKpsaY+21IVwgpNqRhMXlJz4zk+xCbe7PuBTrmEY3lPTHwrtsTjDwUYznEFx+Cs67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUwo5cej; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUwo5cej"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so6250271a12.1;
        Mon, 17 Feb 2025 16:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739838344; x=1740443144; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtxrxzkh+d7yquGYVEY4pLXa1+51NmxSqd9OKtvqwSc=;
        b=cUwo5cejI/90Fkrlyj2M9EwAZovN1wGRGJrLnaWi/rtGyduP/ZcYzK8znN7gzS5bHf
         XWjdeb3GYhMIIeE8uUgQWZQHJkQosPXM3eBOJfA0C226uGwuk4ndVpipMKfrZewP6+cA
         dkJRqvqEz5CT9tBQ8n6S9W7FdbNTO7+aU3E8UiEZUXINa1u4oNkrKTts0pXWF+k0VPhl
         1yPkqplFJwOCHc1ovFeDkIU/QvqcOlkRioKELf5e6uxxcXYcAWPxn7oGUtfjLslAVfmt
         wu1nh1in2Bw8HsemAE6amoMD2pWqmyFnWY3LIlNVy/oqhD4wNYSxwo/kl5noyXeCrO6e
         MKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739838344; x=1740443144;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jtxrxzkh+d7yquGYVEY4pLXa1+51NmxSqd9OKtvqwSc=;
        b=MtkOuX6IiGPF1IXcw64bab/85l1X1db8oViqbAj+fWPDVEVFyIaRNWomHvJjE4kH/b
         HYcflaQjOGBnnd42r0H+5tDwbYOCg/REzMisT0n9WIOJ7zPF+5cNM9haG6zDEUdnT/wv
         vvhWKWqIuD+UquPUealqQ5mhtJNEJEKs4LMmsnwVDShzQVmyipCeKeNeKscYiLL49+7g
         VeoNSBtyj8clC75fFX+ciem2uAcrcPZLKjCwveBhTMf9i29JRA/+lvuDIHYQOyJbe5Mw
         QETzUVw+3RghnTx+QW0qp3+HUIDLrlSG3z7Lu1u2hkp3rHWHai9PZ5j9fifg42uaxxIj
         h7sA==
X-Forwarded-Encrypted: i=1; AJvYcCUMqMZeIlUgaVkzmfi2chuBpg6lOnVLVO4tbOAlxVPvJzFJJ5fluAVEThICMO3v4/0UhLWxddf3Feg=@vger.kernel.org, AJvYcCWQfg1HJHvDbvISZfD9KPYdCASm7wsSWlC91yjUg1gPNXRonc2F6gjbuR2t4zCREQmF/P6h@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+92w/FXPI9hdnGudn/U+79DuWCJIuNah3mujnNI1d5Q3gG4P
	aQItWr9LmQpKEf5m5GjnjtuTuBLcslWPjYMvsycxLlV1s//8L6y6NBmCtio2
X-Gm-Gg: ASbGncux/jVgPLK5+pjeNwfSZ9F8bop8E4zC6Sh4V2+Yo8Zs80IvwyAvZEG3ttiSPNO
	EZQmNU05o0k5YFBafmkty+VrKGyzHLoSH0FAfeOO14qhdltsak8GCL+Dj2szRjnLh8Do7KL/Pgs
	N+vmCtJsLVKkgde1pMF66P+sZynkc+vt69ZwbeHFwm/3ZoPvZyrBCmG3UD0NuyCLLP5b+n/7mlK
	xEEUGo5tG6MtozkNfudGljQtc8knPIj0ZC6lcEiAPJRKk4Ku2fNQtGFdHJ6HXWu4XJjMNBvm36v
	380tK+FnECQ8ht0=
X-Google-Smtp-Source: AGHT+IE/T1iJfMIA7Ny4O9BU26t2PQGA+GPpXb+horMvZ5RLwwFKNFwQrHf7A8Z4FzIk9Lmssyt/SA==
X-Received: by 2002:a17:907:2da0:b0:ab7:d1d0:1a84 with SMTP id a640c23a62f3a-abb706ff7bemr1059495866b.4.1739838343326;
        Mon, 17 Feb 2025 16:25:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337634bsm970235966b.91.2025.02.17.16.25.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2025 16:25:42 -0800 (PST)
Date: Tue, 18 Feb 2025 00:25:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Alan Huang <mmpgouride@gmail.com>,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
Message-ID: <20250218002541.sxj3l34gv256pkaj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
 <Z7Ka8Z5RS_OwyL_G@Mac.home>
 <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
 <20250217074100.2wyy6akdr2j464wx@master>
 <C6141FF0-5892-439E-9475-43BEF31DFF8E@gmail.com>
 <20250217091842.emsz6graccyjkzgf@master>
 <Z7O4owmajnmtqh2x@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7O4owmajnmtqh2x@Mac.home>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Feb 17, 2025 at 02:30:59PM -0800, Boqun Feng wrote:
>On Mon, Feb 17, 2025 at 09:18:42AM +0000, Wei Yang wrote:
>> On Mon, Feb 17, 2025 at 04:02:53PM +0800, Alan Huang wrote:
>> >On Feb 17, 2025, at 15:41, Wei Yang <richard.weiyang@gmail.com> wrote:
>> >> 
>> >> On Mon, Feb 17, 2025 at 10:22:53AM +0800, Alan Huang wrote:
>> >>> On Feb 17, 2025, at 10:12, Boqun Feng <boqun.feng@gmail.com> wrote:
>> >>>> 
>> >>>> Hi Wei,
>> >>>> 
>> >>>> The change loosk good to me, thanks!
>> >>>> 
>> >>>> I queued the patch for futher reviews and tests with some changes in the
>> >>>> commit log (for title formating and a bit more explanation), please see
>> >>>> below.
>> >>>> 
>> >>>> Regards,
>> >>>> Boqun
>> >>>> 
>> >>>> On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
>> >>>>> The example code for "Eliminating Stale Data" looks not correct:
>> >>>>> 
>> >>>>> * rcu_read_unlock() should put after kstrdup()
>> >>>>> * spin_unlock() should be called before return
>> >>>>> 
>> >>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >>>> [...]
>> >>>> 
>> >>>> 
>> >>>> ------------------>8
>> >>>> Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets
>> >>>> 
>> >>>> The example code for "Eliminating Stale Data" looks not correct:
>> >>>> 
>> >>>> * rcu_read_unlock() should put after kstrdup(), because otherwise
>> >>>> entry may get freed while kstrdup() is being called.
>> >>>> 
>> >>>> * spin_unlock() should be called before return, otherwise the
>> >>>> function would return with the lock of the entry held.
>> >>>> 
>> >>>> Hence fix these.
>> >>>> 
>> >>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >>>> Link: https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com
>> >>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> >>>> ---
>> >>>> Documentation/RCU/listRCU.rst | 3 ++-
>> >>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> >>>> 
>> >>>> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
>> >>>> index ed5c9d8c9afe..8df50fcd69fd 100644
>> >>>> --- a/Documentation/RCU/listRCU.rst
>> >>>> +++ b/Documentation/RCU/listRCU.rst
>> >>>> @@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
>> >>>> rcu_read_unlock();
>> >>>> return AUDIT_BUILD_CONTEXT;
>> >>>> }
>> >>>> - rcu_read_unlock();
>> >>>> if (state == AUDIT_STATE_RECORD)
>> >>>> *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
>> >>>> + spin_unlock(&e->lock);
>> >>> 
>> >>> According to the above quick quiz, we should return with the lock held.
>> >>> 
>> >> 
>> >> Thanks, I think you have some reason.
>> >> 
>> >> If my understanding is correct, the example here is to emphasize we could
>> >> still access the value out of critical section but with spinlock held.
>> >
>> >This example is intended to highlight how we can eliminate stale data.
>> >
>> 
>> Yes, you are more accurate.
>> 
>> >> 
>> >> In current example, we don't return e(struct audit_entry) from
>> >> audit_filter_task(). So no one suppose to release the spinlock again. This
>> >> looks to be a mistake.
>> >
>> >Then the example code should return e instead. ( *key is also undefined)
>> >
>> 
>> So you prefer a version with e returned?
>> 
>> Boqun
>> 
>> What's your preference?
>> 
>
>Yeah, I think it make more sense with e returned, and you can add some
>comments at the return statement like:
>
>	return e; // as long as the lock of e is held, e is valid.
>
>, but feel free to use whatever you see fit.
>

Thanks, let me prepare one.

>Regards,
>Boqun

-- 
Wei Yang
Help you, Help me
