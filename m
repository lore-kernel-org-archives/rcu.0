Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20308346AE6
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222651; cv=none; b=D5WtNSObWGR5TGMY2sfKXWFFCk9osDSFCR7IASoKNDzGUhoDQ7NQYCnWR/CDHB7DAAXVdTwgiSzf8iup/B2qE/ZL5dNrWsHek6SPT5dhBdAil/GeglgbfCSHpsWG75syUfWLyb+lmVjIMFiSKci3uVuO6X18toyTEI1MomAd4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222651; c=relaxed/simple;
	bh=zFgm2vYxRqINt6erFcw86ykrENaWfXFz5MHspS0kE74=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmpFmbTArN51JKBXA8Lu2p76KFgxTwADKMSq719aJjbhRQg4W93td4blAplqyh548LQg/iJSmyS0FFQk/TnawE7pAfVWaUBvCOJ0u9x0fEnLfr9ZcELVFmss4j0kpJ97uDuLhHdW0k6s1LZFsoMV/hDB+PLsMYDxwwPAF1WzseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBS6k30F; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBS6k30F"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-598f8136a24so6868710e87.3
        for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222648; x=1768827448; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k6W1vW7YyTZJ9RKKihBrvv7xY//2b0fVqhtiT/deWqY=;
        b=SBS6k30F++bLJ17BOh+Vj3D771m49I8FiZYzFVcH8gLI6byZ5JkaoA9aEr44QAUxY9
         /1WarPsMVCMKFOF1e821Aw/CcZJ8PlhkFjC7rqrRl6l+WLLP3qs25LSkOEIZdVAshRur
         KTe12lm+oCCEK0bvxrqIHS0eKFYqzfzXwVt94gD7AuH9CUk0SKntzvQX0TUC9jpkRMTd
         J40BdVOpEj4n0LsetO6wPdK4er+mRAZLGXxH1dnIpnt3zpU1/FBM1EZWbjUHsz5Gv1++
         s/jymKrnEJk9OqPVGw1QCHqqdqPu9cVcn/oKARGkuKyN7B16bkztWSEyWQdDvnF9FPNQ
         ff9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222648; x=1768827448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6W1vW7YyTZJ9RKKihBrvv7xY//2b0fVqhtiT/deWqY=;
        b=Zir+1aj43uqpbad+2MdHLjieEB2jkFpTGk/hZWeAR5M4wNm+xk4Jtzn++lO6Igz5NZ
         B76QXEn9M/umAj27EnR7gKsYeDLBmArRki8qDW+jvEIJy/p0AEd28AJrTAyfY3Ho2ZyD
         KpvDH1DMXH6XzfsbD5g/+fYGLK15mD/KZG85AhLfYVCZoh5gs4QuAKpVaIw9DLd0eemC
         o/S9sIJVCIBDyCJ7HWZR7BMafE+JP3yUGCOEEXO60NWszSep8JuRnHCL6ROHT7LZE7Mo
         1JVviItNtxrKZfoSgKQn/EjX9fvDEtwe9ce72/gZw0mZPBVlcnQYv7HDFLzGO5sv+mhS
         4Hww==
X-Forwarded-Encrypted: i=1; AJvYcCUFacuOjRcY2bfnOlqTa8JalMsRgSwHzzesY++/Mbcj8rhjo48TIVFQBMtkWXI/LdeITrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0EoA085fDhWzSJL9/hZ2OyDut7ApodisoemjsrWY9O81JOxp
	UvWJMdksrwVSuDqXEwjiBWbDfgKG7xJggWMlf/TWjNr4cxwwNn7dz69R
X-Gm-Gg: AY/fxX44rZRW/HDB4l2xpzhoF2ZwoEbnVXbLsLlJXZ5NDKBN80si6I6dnbAjEwf1dW5
	4fG+YejLtjR5fvG/2002P89x3oo615M9n8FJLEHaAdSHBGpBPbHwQOgUVDRyUZhMixCWy4/nRsD
	bt06lb/5RrcXcQjb97WIHmVPA+A2KtLoAkrkUnKdCK4qtXT9Ds90l64VhZZysVwnbTcQ6EOL6Jh
	iG8Y+pVqAYCBDPNpwinwgPlO3TYVii17S92LZcIi8dMjlM7ZbHjeNmT2TJYTwU07VcT+9oIinuH
	freWgWKQ3Jzkyc2APuAFJv2lj/2jVRm/NAl/fco1zYElDSrZAQBYwv4jHOPy6T21DXMNWShhYcE
	Mrd7Aq2Fa7nXEDigqCPE/H/kDV4ifr7ODbecXiuCHnPhoOdQNFOl3
X-Google-Smtp-Source: AGHT+IE+OLIvkn24bosYYZh2o2pPxnXluGjI++O0ltbiPWNcj5MAbgA0rPYMFoHQjdAkDBAmvA4eIQ==
X-Received: by 2002:a05:6512:3a8d:b0:59b:83fb:c6ba with SMTP id 2adb3069b0e04-59b83fbcfe6mr3325742e87.51.1768222647958;
        Mon, 12 Jan 2026 04:57:27 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b7100527asm4018348e87.37.2026.01.12.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:57:27 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 12 Jan 2026 13:57:25 +0100
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
	rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
	srikar@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWTvtVGe8un5xtTn@milan>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>

Hello, Shrikanth!

> 
> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> > On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> > > Bulk CPU hotplug operations—such as switching SMT modes across all
> > > cores—require hotplugging multiple CPUs in rapid succession. On large
> > > systems, this process takes significant time, increasing as the number
> > > of CPUs grows, leading to substantial delays on high-core-count
> > > machines. Analysis [1] reveals that the majority of this time is spent
> > > waiting for synchronize_rcu().
> > > 
> > > Expedite synchronize_rcu() during the hotplug path to accelerate the
> > > operation. Since CPU hotplug is a user-initiated administrative task,
> > > it should complete as quickly as possible.
> > > 
> > > Performance data on a PPC64 system with 400 CPUs:
> > > 
> > > + ppc64_cpu --smt=1 (SMT8 to SMT1)
> > > Before: real 1m14.792s
> > > After:  real 0m03.205s  # ~23x improvement
> > > 
> > > + ppc64_cpu --smt=8 (SMT1 to SMT8)
> > > Before: real 2m27.695s
> > > After:  real 0m02.510s  # ~58x improvement
> > > 
> > > Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> > > 
> > > [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> > > 
> > Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> > your "expedited switch" improvement.
> > 
> 
> Hi Uladzislau.
> 
> Had a discussion on this at LPC, having in kernel solution is likely
> better than having it in userspace.
> 
> - Having it in kernel would make it work across all archs. Why should
>   any user wait when one initiates the hotplug.
> 
> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
>   though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
>   We will have to repeat the same in each tool.
> 
> - There is already /sys/kernel/rcu_expedited which is better if at all
>   we need to fallback to userspace.
>
Sounds good to me. I agree it is better to bypass parameters.

--
Uladzislau Rezki
