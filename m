Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951A27B34D
	for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313865; cv=none; b=mGJfNmJKAou0/g0KEH4FAmElikLS2MyD6wUlHUzLqv5eJJ+dHvkQGfzf6uQeYoARFAU+q03FBU0HgdWs+WEkZTYhtEPUufB/1PCAcgFBCVCBen2Ywnk/0NgGnbPQDWJ9w/SHJmML6XdaIQFMrnK7cSloqFAIQ9Lq3AHvA11u61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313865; c=relaxed/simple;
	bh=v1GXmDnpJ99Cfwj0itmON7BQzKyMWoe90G3uocpU7Hs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTfgmT7qoXHjbQW9ucBHPzDQ8ydl8RAteN4yktmYWDh9ydZVWq/DWMOPLGk6IBePhrXQZsW008Q13p/Yk8E7ozfUC5pBrYcT/bwCfInTNQ4fLvRkDpnX+riZtlVSqb1xZic5CHiFDMhsUs6LdgPD5ArSFSsebBboeGLQNH+rwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS0AuIec; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS0AuIec"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b79451206so4813240e87.1
        for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 06:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768313862; x=1768918662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5LqThlxJWQjBCoDfwlFPjt5RvxFdzcbyGwP2nvu+lE=;
        b=VS0AuIecSWbMrZsei4X5VwIM2etz8CMnH3YU5srTzksAWxejGozfyZO721W14eg8dM
         156WGTCspPCr/S+xjTx5K8BY1JuoUVg9vD43TUiiOHoMGUvFvchqGktVcqIdiFmEYHMY
         qqcCcGi4CJGLccRedfK/1LzjE/KYqUbr9gcgnad6h+tCqsirutvUPfX0e20U5Y8UjETk
         9NDyC1w9hrZPQwgz8hWBHN8ZTDpm/G8hDlz968KOqb1ZUe0F+OPCbhgLmuGBlaO4fKGY
         1B9RrnwLQCHt6MyBo7tG3bWLNl6EzZ083dp254k6yGA6GMbgSYYhWgvrl/DIFmFOaMM+
         eAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313862; x=1768918662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5LqThlxJWQjBCoDfwlFPjt5RvxFdzcbyGwP2nvu+lE=;
        b=JvuaSSLow/DiFopQgEB3w/X/uz3LsCErIRSfXEHkaSJb7LhQJQ47lKTd7mOuly5iZz
         Py0k94q+SzlHotuyYltITtjy+VNEqK2/sy/vBtNwIpZ1XdNJ+v3O1xEATHwnIRqfKeqM
         Lhz/U0NgzvkHdc90G8Re3RfwQlOupW4npawP6xwYKr7fzFmMIAd65tFUyhJakbUKCjJt
         jCUerb8/gAgUgDHampMVHOjt66Pc0kQr2A7xgXoOgEWOipkIzjDKYZwc3uD3qrvpXbWW
         NGfT4BiCPIMaVLOacVRSBd1q9739nzC2+XzpJKR2QCwoyW57/WpceaCyN1WT+VeCzlGg
         gVDg==
X-Forwarded-Encrypted: i=1; AJvYcCXgNI86fHX87J5bXJaZ6HF4sjU4IySnW11jaeevXmKBlSZwYEkOT6m6f5ZQAt7xOD7snQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqaij/zmz72q8OgBm/htKWrjzqJjQeSl5xOTSPSiNapkWjbhyL
	KCXO2erM9zjyAGdh+LtRvozOudIH2UXkXXOVhYv1SrcWe9F52SWIhN5V
X-Gm-Gg: AY/fxX6kSPBfY0qd9I9z1HvfBwP5eX1DkTgdQrGJ4CQBjX/2CYlAW9RsnMOfVPuUN16
	fcVLz99shC+tRn/S8+ur4gYPj1Hi0bhHAMmTBWvktIGMfYJZ3QEpz8gxBaUdOGKF0eNLzXOn7kV
	Y9l2me0whm0EWPRtN+XiLuXLaz12HMNtDcVNGSbx+jLLVMt5OL8sJQwaaIE9ezdM0sMXRb6zXiL
	rPIVi3JGLLGFN740o848Z342+Wpr54S/JVF+8U0n4+JWadign23rhHVCQP6HZNEW6uYzp2isTF+
	Cnjw3gKIDLXnRq1WQJAAfRf6h8fa3GU2B2gK45sivkpmLnPUC3HVdfyfZmCRtj0AFCdR79YoP/Z
	iGfF+p7aB/ifLLRqDBV+yj/JtSshQOZbxyn3dfCQbRAcJUIWrpuVi
X-Google-Smtp-Source: AGHT+IHrWM1MpNEhtnK57jg3l0Ph0b/YFdT+/1Ij/m9LfpD3F5SPyEXpZ4PBFjNKqUXZR/rzoAjxYQ==
X-Received: by 2002:a05:6512:39d1:b0:598:fb04:246 with SMTP id 2adb3069b0e04-59b6f02af35mr6513428e87.32.1768313861262;
        Tue, 13 Jan 2026 06:17:41 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-383062cb5b8sm35845011fa.39.2026.01.13.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:17:40 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 13 Jan 2026 15:17:38 +0100
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWZUAhbMV_BHamr_@milan>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan>
 <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
 <aWY4LQZrudJ4SB8G@pc636>
 <B077EC99-57EC-48B8-9B71-237A7A95DFE2@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B077EC99-57EC-48B8-9B71-237A7A95DFE2@nvidia.com>

On Tue, Jan 13, 2026 at 12:44:10PM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 13, 2026, at 7:19 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Mon, Jan 12, 2026 at 05:36:24PM +0000, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Jan 12, 2026, at 12:09 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>> 
> >>> ﻿On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> >>>> 
> >>>> 
> >>>>>> On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>>> 
> >>>>> ﻿Hello, Shrikanth!
> >>>>> 
> >>>>>> 
> >>>>>>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> >>>>>>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> >>>>>>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>>>>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>>>>>> systems, this process takes significant time, increasing as the number
> >>>>>>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>>>>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>>>>>> waiting for synchronize_rcu().
> >>>>>>>> 
> >>>>>>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>>>>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>>>>>> it should complete as quickly as possible.
> >>>>>>>> 
> >>>>>>>> Performance data on a PPC64 system with 400 CPUs:
> >>>>>>>> 
> >>>>>>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>>>>>> Before: real 1m14.792s
> >>>>>>>> After:  real 0m03.205s  # ~23x improvement
> >>>>>>>> 
> >>>>>>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>>>>>> Before: real 2m27.695s
> >>>>>>>> After:  real 0m02.510s  # ~58x improvement
> >>>>>>>> 
> >>>>>>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> >>>>>>>> 
> >>>>>>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> >>>>>>>> 
> >>>>>>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>>>>>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> >>>>>>> your "expedited switch" improvement.
> >>>>>>> 
> >>>>>> 
> >>>>>> Hi Uladzislau.
> >>>>>> 
> >>>>>> Had a discussion on this at LPC, having in kernel solution is likely
> >>>>>> better than having it in userspace.
> >>>>>> 
> >>>>>> - Having it in kernel would make it work across all archs. Why should
> >>>>>> any user wait when one initiates the hotplug.
> >>>>>> 
> >>>>>> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> >>>>>> though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> >>>>>> We will have to repeat the same in each tool.
> >>>>>> 
> >>>>>> - There is already /sys/kernel/rcu_expedited which is better if at all
> >>>>>> we need to fallback to userspace.
> >>>>>> 
> >>>>> Sounds good to me. I agree it is better to bypass parameters.
> >>>> 
> >>>> Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> >>>> 
> >>>> I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> >>>> 
> >>> IMO, we can increase that threshold. 512/1024 is not a problem at all.
> >>> But as Paul mentioned, we should consider scalability enhancement. From
> >>> the other hand it is also probably worth to get into the state when we
> >>> really see them :)
> >> 
> >> Instead of pegging to number of CPUs, perhaps the optimization should be dynamic? That is, default to it unless synchronize_rcu load is high, default to the sr_normal wake-up optimization. Of course carefully considering all corner cases, adequate testing and all that ;-)
> >> 
> > Honestly i do not see use cases when we are not up to speed to process
> > all callbacks in time keeping in mind that it is blocking context call.
> > 
> > How many of them should be in flight(blocked contexts) to make it starve... :)
> > According to my last evaluation it was ~64K.
> > 
> > Note i do not say that it should not be scaled.
> 
> But you did not test that on large system with 1000s of CPUs right? 
> 
No, no. I do not have access to such systems.

>
> So the options I see are: either default to always using the optimization,
> not just for less than 17 CPUs (what you are saying above). Or, do what I said
> above (safer for system with 1000s of CPUs and less risky).
>
You mean introduce threshold and count how many nodes are in queue?
To me it sounds not optimal and looks like a temporary solution. 

Long term wise, it is better to split it, i mean to scale.

Do you know who can test it on ~1000 CPUs system? So we have some figures.

What i have is 256 CPUs system i can test on.

--
Uladzislau Rezki
