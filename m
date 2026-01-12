Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5E374166
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237537; cv=none; b=olDDR3POYzCPqS8Y9WfjMzM8daWmfX4K6FwVTghupJ4RE7WkH8UJPEaRMo/usoYpfc/gR9AXBocPA1VvvcEGrgprZGkX4fpic7XnVLumbOm/fCLZVAljLAi2T9uEgELhg0A5g0zdHPjyULRZKOuWl0Fm23kr/KNjsOUE2ClFWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237537; c=relaxed/simple;
	bh=b79nEfxKiXwSTqX1JEtj/AQiuc19VYkbFZ5JtFJrQOY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEannbv7aWctB16vYlIAA9m2oetZbt/PuxTeSPXNOUuVjfONQz/fudmAO1lyjotvl11z8eXj4nhXkPFPosttLT4Nxg9O/rw8mEbBWV+Tw9it/7THG6zVZC2B8fD74x7l41lyhtpI6aAFPCiM1Il0apiCPaVDQMvZRy+RsSLTHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPIKN9NY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPIKN9NY"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b7073f61dso6666518e87.2
        for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768237534; x=1768842334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhOLd8idS9s2SPhOmUyW/gBUoul65h6Gfn3I2KctTu8=;
        b=NPIKN9NY8JOQXF8HiyAx7mnnbFM8SMkxHtHnHN0qhzBREirWKEFMc5oS8zPiH5yhhU
         fdF9GgmIUJXOz6K7ru59dfhjj2Osuv9GkiNIFmP/GrZVP4NBlz2ofjysalklE9KZ0Iq9
         5N2oDhQ5MFnfC3ySkozgHbjXrRou3sLu9DsIQ1vqj9tYDhVZnUYugAayDhhlpvGhEx1s
         2KeSUeGIy0XJAMfWm/tBA3NpYdfVD9zLUwjZvfCYZke9jn7m+ed/sp8er/KSvfsiz7eA
         iqhed25OypM23nWlKcyTv79Na3I+zBKbuq5laKcGmtBnk/va37e+5wh8u58NtvPUeAe6
         f2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237534; x=1768842334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhOLd8idS9s2SPhOmUyW/gBUoul65h6Gfn3I2KctTu8=;
        b=ss1+4m0EUD4Y16RQbT4BfEN6jK70sz1V80Jy1j0v4fjAZx2uztGubvZ3O3bfiZ0Tao
         3aiAt6pRvkhaktSBzSCTRu/5CBX+uzvRASqKz/QTlq2U8k7l1kE2ipzyd2Un8IZ7yeoh
         fairBQ1XRnLWZIW1sPoWjztlkI4Hma67u+Ajnest2UjZaalbjYLR1OQ+YMsgzK9TbbKa
         7pDb4XRdUxRerBbPEUXHr2JfBy6dvRr3lxQbwtEFKkwaLU+rF5z0DnNafNB3Ior4ali0
         XgPIY8JjwWnDL4t5yHoAle/lJUIVxoPORkoelNBBxZMKtQasuP23tORX5FDAvmwjbENG
         iA5A==
X-Forwarded-Encrypted: i=1; AJvYcCV6F1TB4ZASv3vBlAeT0ie9EqJ4ZpwkepD4NBOCAp6SVOmyjbT+KK5gWzQ+mDm+bW9FwVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6zIT683a9aB8fYLtfRM1O9XADDf3mVF9AiaaHAjQiEVbfXLs
	z1iNt4VwYD0FOvX+K1GyOCOpAMKHMqLOt/lOuW7rdzvL+i9tWNp6EeAe
X-Gm-Gg: AY/fxX4ViblFk09nS/WqC/k+mabnpQ0t/DaS+2ClDX8l/cKjmoTwGM6QB8g6DspZl3i
	48RXOJn+q7o6kdrGpl2aIQXlkskynnrWrzOvpR9hOk3sNYUKReWYpS1PA8QgGJiOkrGRaHQ/OUh
	P5wtF26CLbq+1Ktd+f2/DSF1+Essm3QmPBf+jS2NGjiJY/rvuvg9d+iYgcuG1XIEbkKYvK6/Xh4
	fF7vBV8Kj+ehEGykbJNygn4f2Hqavqpe3r1IvA52OPC2e9hizp3qW5LWZBmlr9JEP59t8mgsv9f
	WqXV6MxS4i7PBjsZJeJVL1y1rvkxspZ6VKs8/twfkctPESu21GSFIUmXJoQoOKPhPA6MqGFbVaE
	qIG8s7+8CBFBWubRktaxQkkSQkQX2t4OzEMxl6kOwXkMwTWH68N+Nh1gt6BYGKVA=
X-Google-Smtp-Source: AGHT+IGs49n4+renF0H9IMIyt+AuvC3gMQI5IsTLq23QXwbyL6ZTAhPXeYNnwtlcLVEIw0VONfjVmg==
X-Received: by 2002:a05:6512:a83:b0:598:8f92:c33f with SMTP id 2adb3069b0e04-59b6f05536cmr7017904e87.51.1768237532542;
        Mon, 12 Jan 2026 09:05:32 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b669418b6sm4871218e87.20.2026.01.12.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:05:31 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 12 Jan 2026 18:05:30 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <aWUp2kDi5gjGKOtR@milan>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>

On Mon, Jan 12, 2026 at 08:48:42AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> > 
> > 
> > > On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > 
> > > ﻿Hello, Shrikanth!
> > > 
> > >> 
> > >>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> > >>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> > >>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> > >>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> > >>>> systems, this process takes significant time, increasing as the number
> > >>>> of CPUs grows, leading to substantial delays on high-core-count
> > >>>> machines. Analysis [1] reveals that the majority of this time is spent
> > >>>> waiting for synchronize_rcu().
> > >>>> 
> > >>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> > >>>> operation. Since CPU hotplug is a user-initiated administrative task,
> > >>>> it should complete as quickly as possible.
> > >>>> 
> > >>>> Performance data on a PPC64 system with 400 CPUs:
> > >>>> 
> > >>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> > >>>> Before: real 1m14.792s
> > >>>> After:  real 0m03.205s  # ~23x improvement
> > >>>> 
> > >>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> > >>>> Before: real 2m27.695s
> > >>>> After:  real 0m02.510s  # ~58x improvement
> > >>>> 
> > >>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> > >>>> 
> > >>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> > >>>> 
> > >>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > >>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> > >>> your "expedited switch" improvement.
> > >>> 
> > >> 
> > >> Hi Uladzislau.
> > >> 
> > >> Had a discussion on this at LPC, having in kernel solution is likely
> > >> better than having it in userspace.
> > >> 
> > >> - Having it in kernel would make it work across all archs. Why should
> > >>  any user wait when one initiates the hotplug.
> > >> 
> > >> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> > >>  though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> > >>  We will have to repeat the same in each tool.
> > >> 
> > >> - There is already /sys/kernel/rcu_expedited which is better if at all
> > >>  we need to fallback to userspace.
> > >> 
> > > Sounds good to me. I agree it is better to bypass parameters.
> > 
> > Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> > 
> > I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> 
> This would require increasing the scalability of this optimization,
> right?  Or am I thinking of the wrong optimization?  ;-)
> 
I tested this before. I noticed that after 64K of simultaneous
synchronize_rcu() calls the scalability is required. Everything
less was faster with a new approach.

I can retest. Should i? :)

--
Uladzsislau Rezki
