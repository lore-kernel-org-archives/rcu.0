Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69F8625D
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180146; cv=none; b=LpzOoL1lwiPH4uwy52w39UZmjJEh3MhplljYQjslQeQIZ8Sc4AF/tyq9w13OKyZOV0j5nBUxOaxPy3Z+d/eiHqmHgev59AJkknuG35HrY8HmgeGqHkMVEzzdkFRXmqPpEA1u4GRQKRF2alG55KMCbIiEYe5HnBlYJvUjpmILcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180146; c=relaxed/simple;
	bh=0sXRAeD+zWS3zc0mEn+opPlzS+BvgcmDIqaSwXibnDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crxRd626L1aajQ1eclN5WJPHvenXvOQqQPAfEYSdQUDqS9f9vF5/Fji2Eofj3Eh1nBdXtXDwP1cZSrMJUUQrPaao9OUkdLLibxPiTsUBu17PYX0i6vD4WrqfE0QyxGK+NA0i8donz8MmqtWftKTy5WE7rjObU6i2aWQQsnaSJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QgELaaJJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgELaaJJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a0013d551so113379766b.2
        for <rcu@vger.kernel.org>; Wed, 08 May 2024 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715180143; x=1715784943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOFkQKLtVJwGAT68/GiH82uJIbWHRwsw2d7t/rwl000=;
        b=QgELaaJJ++uvhnbCIw0cqcOymJp5PEoA+1heOIlCJkYZ2z9421hhPiWQvwbtZH2IzM
         9VLhBm+Hpiku81XtI8DAh7oBl12u11hkLrE2GyKFsUs8uvou5aL9HWmuA4zlJ7jKbwwT
         cSIJMrWUpSkG2vLK9kiya6+NfZmBix+Md3yf1DGRGaKPy6JzYrqHMAOMuDKV5GfjVAjZ
         Fm+8lHQ6Oa7ooqEizgdmUErcyHjYKpWP0RP+9/DBBW5ISISHIGldQ0nOk8Xhr9aHlmiX
         Yeh3xRIOLBU+WLtWj33Vn4kjU668oML4yGOC1SGqpAM8V1HdkvWTXZkmIuMSO4KKzbsW
         sHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715180143; x=1715784943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOFkQKLtVJwGAT68/GiH82uJIbWHRwsw2d7t/rwl000=;
        b=ovXjVY9mvJ3ycnBNRk/pCjC0Ur2vx9B7dtyIu2qm3fFOFVuxYSytmJl6Iiggxnrqi5
         du5I1HRz5+A6wAg+aa0M2VI+xkQVvWRrYqPCMrgv/HkNLsPVBOWTSl9ShgqnA1EKE+CD
         2z8dPIls0ghXPOFrSb2Rgmlmq33MHDs9oAhp1PARcK2r5rvko3t4Z5LQSeYeL7mHIo9h
         +NliBXRWYrPgrutw0I5ym6i2Vnirr3gpo8MtfgMtxHacT/XMLdcOIXAiHI2uyd0KqQbL
         LBCkkAPXPf5mKdAXAnyOCMFUPncXiOea4tofTAo0/Zco3c4nashtSq5X6znmuolpwNcN
         TWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWspO/N7hLku1ystYOQjW9YE7yHUNd/sKz7B1zFq1/rUitPT75ZzQFD/DIkIE9MsyPv2kjMnJfVWGK1PHq1/PWREQng
X-Gm-Message-State: AOJu0YwEetumnfsrglv9944gyYH7oLgOMzgxn/SOdD27/z6SksqjCQgC
	sLBEEzT8aDr64woePz7YLuyzxqoa6lX0QPoElCQoWmsGBZrt5fzaICVVFz2WTGc=
X-Google-Smtp-Source: AGHT+IGigxDBKq5sRrbe4HOOv1ZfmO3btgl9iP2nipR3ixL9sGi++QqEg6mFbH3HXLcvy7rs6zrttw==
X-Received: by 2002:a50:d519:0:b0:572:d536:5d9a with SMTP id 4fb4d7f45d1cf-5731d9d1c87mr2574263a12.23.1715180142755;
        Wed, 08 May 2024 07:55:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e22-20020a056402105600b0057300ba262esm3587827edu.34.2024.05.08.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:55:42 -0700 (PDT)
Date: Wed, 8 May 2024 17:55:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: dwmw@amazon.co.uk, rcu@vger.kernel.org
Subject: Re: [bug report] rcu: Kill rnp->ofl_seq and use only
 rcu_state.ofl_lock for exclusion
Message-ID: <edfea2ff-d73e-48aa-83db-96daba77c500@moroto.mountain>
References: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>
 <cef46486-ac26-495d-bd2d-1e998a73a421@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef46486-ac26-495d-bd2d-1e998a73a421@paulmck-laptop>

On Wed, May 08, 2024 at 07:33:38AM -0700, Paul E. McKenney wrote:
> On Wed, May 08, 2024 at 03:29:12PM +0300, Dan Carpenter wrote:
> > Hello David Woodhouse,
> > 
> > Commit 82980b1622d9 ("rcu: Kill rnp->ofl_seq and use only
> > rcu_state.ofl_lock for exclusion") from Feb 16, 2021 (linux-next),
> > leads to the following Smatch static checker warning:
> > 
> > 	kernel/rcu/tree.c:1844 rcu_gp_init()
> > 	warn: mixing irq and irqsave
> 
> There are actually cases where this does make sense, one example being
> where some called function (for example, rcu_report_qs_rnp() below)
> needs a flags argument.
> 

I only found one false positive which was kind of related to that in
__run_hrtimer().

  1643  
  1644  static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
  1645                            struct hrtimer_clock_base *base,
  1646                            struct hrtimer *timer, ktime_t *now,
  1647                            unsigned long flags) __must_hold(&cpu_base->lock)
                                                ^^^^^

  1648  {
....

  1678          /*
  1679           * The timer is marked as running in the CPU base, so it is
  1680           * protected against migration to a different CPU even if the lock
  1681           * is dropped.
  1682           */
  1683          raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
                                                            ^^^^^
We potentially enable IRQs.

  1684          trace_hrtimer_expire_entry(timer, now);
  1685          expires_in_hardirq = lockdep_hrtimer_enter(timer);
  1686  
  1687          restart = fn(timer);
  1688  
  1689          lockdep_hrtimer_exit(expires_in_hardirq);
  1690          trace_hrtimer_expire_exit(timer);
  1691          raw_spin_lock_irq(&cpu_base->lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Then disable them again.

  1692  

Of course the other warnings are mostly not "bugs" because the callers
haven't disabled IRQs.  They're just in need of clean up.

regards,
dan carpenter

