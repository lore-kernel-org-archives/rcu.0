Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890272DA755
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237755; cv=none; b=FM9TWwCYanpyf3uJnECBWvI2wcZsiHnf9KNIeBGMgqNYHFHB/b5BWxUUSh1fMB+1S2S4Toe26115IanQTpg6jjOTbO8jp2lNlvBCMv66H2Ls5Tg4Ltd6ZU/TZdXHIPGNL5jC4OuDA/oKT/sQDIcanvVHui2abAKWG2BSbfYFBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237755; c=relaxed/simple;
	bh=OJB3qQLixmLbSxVGQskeXIa9IR2SDMZNpVzBkBE9CJs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B09OwSpzEa2/uCUwH0xRTxlvLdqHzCOhEKU23jEL5ixi7mOBpjy80BkOeol6qo43Xhdl8Y0YnjeRmzJNcnusvfLGyGDDr7ar5FdY/Xy6ayS5b/NAMCnACfqGbPOCKnOrMVkINJl10Tx4R0rvyyAcJ49KCPSH1jCVqNCRLU/vPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4VWuPJ9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4VWuPJ9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b7882e605so5865589e87.0
        for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 09:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768237752; x=1768842552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WLV1NsxjV3ejRzmN5EWp0k3Qy7VB+brJ9PeF6ga5Kbc=;
        b=N4VWuPJ9e0HmtB9Eh4qH6yX7Mg7Dt4vRFggTPRkieTRqcp6dBmB837LNGV1rnGw1A4
         nfHvsKfkQhe0DX8lH5y9wXQsPqwMbXM4Y13Ig5TOIxU75QrKWkmtyUXR0DaoCTdNQj5V
         Snsal/asC10uocLuLnThymdl/f4H+OZuSOw6Xtr2P0H2ONpBXvhevnKWiSk69+J8KFz5
         VdFv++kVci7CFE+x+K/f2u0h+lywQ0kyETYbhxI4d4bz+A7U0AVZxPhEi82uNnHgsYRI
         FjXOZS7Y/E2OEhiyjmcawxmlqH6Sh5VjDY/UjNYLsXKqF8AwyN3KuZzwz9bIEwJaD/En
         U3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237752; x=1768842552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLV1NsxjV3ejRzmN5EWp0k3Qy7VB+brJ9PeF6ga5Kbc=;
        b=VoqO1YcxvEkm+Z6vWdfs0CtTL8FqEXS8mwK1nVZGzGyNXW6LQwcq5EiHEPzR+bjB4V
         C5x37b7CKBLfEAYsxwBw9jk5IFn5g4jA6eEdDv+zaWbmNDz+06+2jrfVeUo+g1rzkHOh
         UDVxZcjGTdbjsfhF5Y+mdvbe4XLg7SC/PPZrxalejWIEwMq5TW5Rdwfk0rUDRZB+B38c
         TGVWLkZTkyxabOxzu/uMnBp3c7B2FaSUdOizpz9uZHOAJYizJQUylbMmELNtFgE+VGOT
         ir6aGfI1vyHEZUpTCPD5bv8GlpzIt/s0o3FBCcklzl7X9VQVzKdSO8EXqKxOQQlf7wik
         KlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrUoKb+xtCqlHeqqP9AqpeBzysA67LsKZ/MzSkykAqa8U3Ktx2VcJkfJ+Nnym/PYHjb2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/F7UrVKLmO0TFyXM3i+6Eg2G9ZtG3/xYBeG5JxwH+IuZ6ZCug
	k59bo+6NB3IhhsNPpEXdbMwewYFWnnd1ZLGgTNmdnnvQ1CtarImE/Uxn
X-Gm-Gg: AY/fxX5KE3OEPHOrBO9yTT3+XQfTX3EDzG6WDMlMsIfWh1anoiHwEAXe1hIPjk779h6
	PD4O1oX7P3k0mtzpev4m7NftWNOmc4AcTSoy9zCWqCz9b3O2APrKHTVcHIZTFVOiqNE4Fxa7SAQ
	UNz1Zd2ZRwd1yFqOjWPjb32IQzwjVgrXOgkNiJW5/IVdV6btv8yGUcjUt5KspQU/7ZDuuQJ+plG
	BWeedR0DR9D/H4w06CClJjWqMmOy7eyVMSgNC6Q3K2PNkyWRHVNVrfoO5ThtkPHXQNFpTMEuman
	LXF7HdwbPoRwQI7pXnkCv2b8tqPYPJqtoIE0hNHzc2RZ+bqWmJhASmViGBZ8bwSnBWcsu+2cRTY
	yB1j1LuhP2aMowGF/Er848S5c0JDeauz5+/Q4W9RaYHfO2d2oYvcO
X-Google-Smtp-Source: AGHT+IEvqK8oHcfGwCDrhoKWko25WVhi/Q+5LwtVlHdVJPwRlLaIiZmCfnbRPTjwihLiBNvr1keRhw==
X-Received: by 2002:a05:6512:4004:b0:594:2f25:d488 with SMTP id 2adb3069b0e04-59b6ef1e286mr5998653e87.21.1768237751382;
        Mon, 12 Jan 2026 09:09:11 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d0d108sm4925107e87.27.2026.01.12.09.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:09:10 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 12 Jan 2026 18:09:09 +0100
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
Message-ID: <aWUqtX2PGDOZUaDW@milan>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>

On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿Hello, Shrikanth!
> > 
> >> 
> >>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> >>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> >>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>> systems, this process takes significant time, increasing as the number
> >>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>> waiting for synchronize_rcu().
> >>>> 
> >>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>> it should complete as quickly as possible.
> >>>> 
> >>>> Performance data on a PPC64 system with 400 CPUs:
> >>>> 
> >>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>> Before: real 1m14.792s
> >>>> After:  real 0m03.205s  # ~23x improvement
> >>>> 
> >>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>> Before: real 2m27.695s
> >>>> After:  real 0m02.510s  # ~58x improvement
> >>>> 
> >>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> >>>> 
> >>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> >>>> 
> >>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> >>> your "expedited switch" improvement.
> >>> 
> >> 
> >> Hi Uladzislau.
> >> 
> >> Had a discussion on this at LPC, having in kernel solution is likely
> >> better than having it in userspace.
> >> 
> >> - Having it in kernel would make it work across all archs. Why should
> >>  any user wait when one initiates the hotplug.
> >> 
> >> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> >>  though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> >>  We will have to repeat the same in each tool.
> >> 
> >> - There is already /sys/kernel/rcu_expedited which is better if at all
> >>  we need to fallback to userspace.
> >> 
> > Sounds good to me. I agree it is better to bypass parameters.
> 
> Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> 
> I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> 
IMO, we can increase that threshold. 512/1024 is not a problem at all.
But as Paul mentioned, we should consider scalability enhancement. From
the other hand it is also probably worth to get into the state when we
really see them :)

--
Uladzislau Rezki
