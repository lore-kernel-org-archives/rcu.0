Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC238F230
	for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306741; cv=none; b=TIVP4sVF1NzK6zYfUi1A6MQA/V7tV52HwYny8/RRKWWQncjwSaMRbDN2VFlwwh0qMolL3LS9OrBWZAa5xTTJ+lm2OdfVJvDhMUOdQxfaGgJ1noYucNvFottG3+egLsmsHMuDdyU6/Hb95MXprmE35zfMliabP/7D2o8/CpkIJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306741; c=relaxed/simple;
	bh=ncgyEwPDNVPYcjMVwZ7h1A0seyYkP8iBA3xNasKKHGw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC/r1WgNoqtYSWRoEYSMo+tas78GH9SAudPrz6g2VmcLHXt8M9cNbThx8J4pLlcWixD7fQiXAM/KD0rp1oZyF7BXfi7urgYcepYzjs7/Fogdlc3y6pSGU524W+oeVaJoIB9XH81Hn2RRBLE7iUYOD+egZ/zEoBaP41PQdMhLuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9bCBfh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9bCBfh"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b7b27ebf2so4441766e87.1
        for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306737; x=1768911537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tI9yXGO6dzXhzNiYW61aS5a3OGj+G+TCRZHIgPPDUqY=;
        b=Lv9bCBfhQACMPEfs+kPZTn9I8cUG2T33k17kwqyLnkw6D6oEuMkajGB4llutfHI/rs
         JNMM3KyMsXqMmAToZ4d0HrOIyF0bAgHM2qTx3UJccfSMxq8WFgwKidp6oiXxcGBWvfws
         loFeSiLJdGVh/FrfoI8pQJCEkuT+Sjq2O+550MQQ8cWODx599xCosLrEg7fD0On3yj9Z
         laMlM9EoC1dZHgrQXAhCgcu/aBOH94/t6yA+dLdyYaDyHRoSatkKC73jawC8NYqBiAUs
         aODvPhxbTySJ3/RbBQN2cfER7YjGvDhKc5DZK6f6PpNLR5VuRZcqIINv2UXZp1RL7hhm
         OfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306737; x=1768911537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tI9yXGO6dzXhzNiYW61aS5a3OGj+G+TCRZHIgPPDUqY=;
        b=LvIzW0WYgcXiZ8GYSr5E0uwnkIVAt/guMwH6p4Vg/1F9EF8I8yqPDB/mpJQb0h6B1e
         kIIApAMqUyji96961M3imoB7bAAkfwisSUojZFETxyWyzxLT+82YHQNms32w8Acn184I
         n/0EG9bYwdS+kwnuqWQi5dhFxgo7YUU2aecZcasOO4jECx7qCj6X94TyQkK7eZ9QboDb
         ujftL1ugi50OrxFZAfO0Q3McHQD4nZBBCchtIuHh/o9AavI3aPC5eVry3hO1PFnFDCz/
         q8GtBv06WEI95SRaBmhn8JVYNfqfxtLiG/TleoTapDGM4qJSp6LJInYN59Ph3NCYqxUz
         SQdw==
X-Forwarded-Encrypted: i=1; AJvYcCXHilij5ybsJbBuMjyOaE5FmDWRNVqg8ojp30J1KU2WqT/NXMRFWE955mLkBz09HTj4KKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrzkUqi6FRn5+lEkmEk/5Bhgk/badvOUC0GTzWtqr5YidvtpB
	hQ0aiaK80uSS4l7pYYqigW6rmDzZ2vwW+AfgTpKVicuL1OywYp9+ANVv
X-Gm-Gg: AY/fxX7weumA3OMvjt49aIteTY/CGc4ggXvHTLYaIRob+uw9/PJfAh4edkTwtIDNfsI
	2OWH8NX1heGH8ZfhgIRiitmLYFxTWwF2D5UhKt82Hf+QLyJSnlY5ButV+nUA8711QNXYc5McZ9Z
	Qd+fYHlQ5vD88zELK3Xt8FUv8akXzpfmoSWt45pyd7CViSoWg6UbVM3Pwpaw2ssm+KGRir7Li90
	Pr5Y1pq3tNqD61o9RWFhRhbmf3JZxpgPj8/XcdHsPdBTcdkA4ztz9zJ0/NxNwA9RbIBlCZKr6VP
	YxHMakkR5tGtV4rsJQLJD0nd/v6+0EpkO1WxDtoGPdd1iOXBVZ95SCDovCgk/nBDTboeilK/Qxr
	5tGSxg5/TIAlVigsgeTxSXWgQdHyzQKky4Fc0CAn1BpKwJs77rKT3xs0iokY9QlstDiMxzZ2iJK
	RHTpUn1xPRWOh2gbfWnBk15vt5Mlo8ZkLlYnDH/A==
X-Google-Smtp-Source: AGHT+IGVhARLqlfB4wu7e386cdEoE6kn/ckGH/qN3S6DPtqKvVRIt96GkWzgHeqUvfF5MEsai9hT6g==
X-Received: by 2002:a05:6512:3c9f:b0:59b:7947:f420 with SMTP id 2adb3069b0e04-59b7947f58cmr5490713e87.18.1768306736568;
        Tue, 13 Jan 2026 04:18:56 -0800 (PST)
Received: from pc636 (host-95-203-18-139.mobileonline.telia.com. [95.203.18.139])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b731aa442sm4524767e87.95.2026.01.13.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:18:55 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 13 Jan 2026 13:18:53 +0100
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
Message-ID: <aWY4LQZrudJ4SB8G@pc636>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan>
 <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>

On Mon, Jan 12, 2026 at 05:36:24PM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2026, at 12:09 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>> 
> >>> ﻿Hello, Shrikanth!
> >>> 
> >>>> 
> >>>>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> >>>>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> >>>>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>>>> systems, this process takes significant time, increasing as the number
> >>>>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>>>> waiting for synchronize_rcu().
> >>>>>> 
> >>>>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>>>> it should complete as quickly as possible.
> >>>>>> 
> >>>>>> Performance data on a PPC64 system with 400 CPUs:
> >>>>>> 
> >>>>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>>>> Before: real 1m14.792s
> >>>>>> After:  real 0m03.205s  # ~23x improvement
> >>>>>> 
> >>>>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>>>> Before: real 2m27.695s
> >>>>>> After:  real 0m02.510s  # ~58x improvement
> >>>>>> 
> >>>>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> >>>>>> 
> >>>>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> >>>>>> 
> >>>>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>>>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> >>>>> your "expedited switch" improvement.
> >>>>> 
> >>>> 
> >>>> Hi Uladzislau.
> >>>> 
> >>>> Had a discussion on this at LPC, having in kernel solution is likely
> >>>> better than having it in userspace.
> >>>> 
> >>>> - Having it in kernel would make it work across all archs. Why should
> >>>> any user wait when one initiates the hotplug.
> >>>> 
> >>>> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> >>>> though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> >>>> We will have to repeat the same in each tool.
> >>>> 
> >>>> - There is already /sys/kernel/rcu_expedited which is better if at all
> >>>> we need to fallback to userspace.
> >>>> 
> >>> Sounds good to me. I agree it is better to bypass parameters.
> >> 
> >> Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> >> 
> >> I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> >> 
> > IMO, we can increase that threshold. 512/1024 is not a problem at all.
> > But as Paul mentioned, we should consider scalability enhancement. From
> > the other hand it is also probably worth to get into the state when we
> > really see them :)
> 
> Instead of pegging to number of CPUs, perhaps the optimization should be dynamic? That is, default to it unless synchronize_rcu load is high, default to the sr_normal wake-up optimization. Of course carefully considering all corner cases, adequate testing and all that ;-)
> 
Honestly i do not see use cases when we are not up to speed to process
all callbacks in time keeping in mind that it is blocking context call.

How many of them should be in flight(blocked contexts) to make it starve... :)
According to my last evaluation it was ~64K.

Note i do not say that it should not be scaled.

--
Uladzislau Rezki
