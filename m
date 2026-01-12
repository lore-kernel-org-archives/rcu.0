Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488614BF92
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221842; cv=none; b=VcJu4EbRxk+EJSbidKRl7cBCVDvF1rD/4JhmyHe+EwWkaA1OANL43DuQ+Khbj6MPPVELHkXqYhLCNcHKOU3axJ8roNKhTf31Eklp5spEkMm73Imnf3Ayvcbujp+Bp8VW+G4ttxD3WdULzMTJvUbxmpnI8khPg4P04trTprXDasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221842; c=relaxed/simple;
	bh=IcDqJuUmSBDzlojdE+eJG3ZOB8F+UQZw/LVJhaSW0SI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFqeTk6wdjPn0NnbqsmLBaJYKOxUtS8cV9KpqJXpNBTZ/8kLCwy6UWUc5J41/noqqEVsHGDZOS6IYnpv/HPSSGcxC/Nb9V25MDFecMONUAKI/06NSsqBzZ9BVG2PaSgd3/3V1peUjK65m11L2Eb1/7kS9iIBpBuTfFfuJtOVu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK61K5Cm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK61K5Cm"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38320cd563aso32325841fa.0
        for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 04:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768221838; x=1768826638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMOr+8bzxaH8uH2WYMzUxbrZH7pO9zkA38LUqDoqkyA=;
        b=GK61K5CmJKZ5E94dsrS+Mzmkof7rjjsvOvoNMeFJkXeANN76+07CcRnYxHJn8VLduy
         UitPaaIBRMl2RgJzpxTFUwEd00vzl5KfalLsuj1WwrHXKouE1PlqRkOnSg7169xN6T71
         Cl75spJ8BWwhrk8/IrLqXBrLandJoovGR+nUV+Es0scqLufq3zYy9amkgUzQr016kQ3U
         35EQJ/bmOrvuQ6godp4SaiuniJm6DcxgUvi6K09rF9DAgQZCwlrCqevQYATDajUPstbm
         RT2c3GT9+8KdhBGn3NxpyMopHEBrxHvWfvejKJPAtbWBDnwQL0AXdMSHNCL+keAYvy6F
         VrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768221838; x=1768826638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMOr+8bzxaH8uH2WYMzUxbrZH7pO9zkA38LUqDoqkyA=;
        b=RukiF1Kubkie5tFnj8N2D4A4YHuGYpB6vy6ljk7DMImK5JR/sbcCN4g6jSuY07TQC0
         iAeU0xIYfw/fTMdf807CBAz6VbWYUpuBIiT0FQMLQBauqF1H9CqScZTATVZmO4CcvE+m
         kGkx1etXgm0WXWo2mWfVbpLmGoxrdG1EBwGN8AIBqWLG1an3Sb8eCBOCkLx32/todCNo
         7vEkenQfC1AGq/2AqAcpgoiClqtEHP64EZADx32ddJ3gRCoTa42v8ozzIDkcJIPZW9SG
         /8NNgx74zkivy3Si3cOIwAGkOgv7cEoXm5ZnMQLLp6stXNNan22AkKZoFwTMUcxdiDX/
         x6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUpEZVZ1oMzO33LINgDwWxrDDUmpwsgXBJ3at4NkC8j8k2A+gr/yafpGeZSIyA8SKMNfuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAW/MI8h0gyprzuXQUT+Po/nQtGuvutMOlBfIoKTfW+iP3E4Ge
	oo/mh/tF1FV0WoJ4V2ZUgqcKOQps6f2w867RdvCxj7y0QF0slpW1ZdjddWcm7o+3
X-Gm-Gg: AY/fxX4mYe+EEnTP4mrcn9+JhfamA3QoANoU3l9wo7/oBkAn8aP54IhWpl8pZN3mqg0
	Q0qWpTDf+ZTGxbFipu3wg7yZLlgg0+rIPwvRsHNXwrnEt/fJXIZl3xH1w8AgfcsY7ae4/s+643/
	X9p19oySlfIyNc6ajwk1M22HsB7ZeoNzi934isJYYOkr3heh0EwTlVW3kytKSvtX/HD3oYmkkF5
	S+60h80GNpTy0+aNChBGeaEhymz9dRf0gjoaIimW3sLR51Yqd8v1eggTH1QWz/PMbEEZCzvuuQG
	DHcPnEKBpyfqAi5gPGrEVXTpKXQJ9d1OD7xFM5Z6HagLDi2/zI9dKI3e6klboVyehHVTq1/OSZL
	VckzImLmQuXAg0v8eRJ47faKFim1uQnl0uevE7W9jGJtYVayM8dWxuVJpLOwW1rwcYRPlVOGBN7
	wSYmY+6eGrAVOm2UWxqFbx7SoIamJ3bj4uLB2cbA==
X-Google-Smtp-Source: AGHT+IGWn30SbT8NVHW3r8NR9FUU74ZnolIQmUT+SttfPjV0xySAAhvq74uh2qsybsJfClqjWhfpVg==
X-Received: by 2002:a05:6512:1084:b0:593:83c:b5f4 with SMTP id 2adb3069b0e04-59b6f04d64emr5539379e87.41.1768216053824;
        Mon, 12 Jan 2026 03:07:33 -0800 (PST)
Received: from pc636 (host-95-203-18-139.mobileonline.telia.com. [95.203.18.139])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6c1792a2sm4250608e87.25.2026.01.12.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:07:33 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 12 Jan 2026 12:07:31 +0100
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
	rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
	sshegde@linux.ibm.com, srikar@linux.ibm.com, aboorvad@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWTV86ji-uZZwzhh@pc636>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <e6efda46-2f47-4a6e-8352-4794479e4a1f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6efda46-2f47-4a6e-8352-4794479e4a1f@linux.ibm.com>

Hello, Vishalc!

> Hi Uladzislau,
> 
> On 12/01/26 15:38, Uladzislau Rezki wrote:
> > On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
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
> 
> # echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> 
> After setting,
> 
> # time ppc64_cpu --smt=1;
> real    1m10.726s          # Run 1
> real    1m12.530s          # Run 2
> 
> # time ppc64_cpu --smt=8
> real    0m36.661s          # Run 1
> real    0m41.401s          # Run 2
> 
Thanks.

"ppc64_cpu --smt=1" is the same, i assume it is offlining.
"ppc64_cpu --smt=8", whereas, onlining, sees the differences(~5x).

But your real "0m02.510s" is hard to beat event by activating the
"rcu_normal_wake_from_gp" option.

--
Uladzislau Rezki
