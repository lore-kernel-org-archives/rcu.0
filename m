Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B60154425
	for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328238; cv=none; b=E58ZbAO4uayh1FF04/uJCGt3AR1PsQ18SdPQKVpOx42iEgT6QLgbuLrHSZhA38TbNqbO/5kVPht12WpICDobzPYsAu3cdgJGGUMUJ1kZUrftUbpjdIMHYwQ15frb8q35vYICdmZ+CFOh2dH0qTr8Qffa6GMyMxGU4ZFjjbi2Ykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328238; c=relaxed/simple;
	bh=rBLDpfbxP8dBnQqdE1HcfFp5xfLcKMYrH6d7Mn0ZCMs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzrG65z/Mnmor0odwYeFlYAnuNbUZp+EZmjXAP48s/AsHBFQjxSFgWmXBf3TgBCaLpFYIWgAqAdnxfRNLLPrmDrmuQctTuPCdYI03702ZpbazNQZiSFcSSaEWmphgFqi2Kk2wkNoA3izR7aN3up6qz0qz3mGiiKtKufCLbP1+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUQmgsv9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUQmgsv9"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b6f04cae6so6533178e87.2
        for <rcu@vger.kernel.org>; Tue, 13 Jan 2026 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768328235; x=1768933035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbC4gM3NijuXYimgCveWveeQh9WcJZZ4E8rmyHc9+jI=;
        b=UUQmgsv9SoUzlNybaIA3lYVi/pwDhHBQNqo7vePkEIvVHw9Ce9EWTnxM0A1j99iltp
         ypxlnCUnn1pAbMsPUqBLB8TEssLQ3MGL1E0ak3YpYY9YIlRWT2wBk/HDpAXcyDwDrDMz
         /pqzNQta/IztW7WY9zRgdxQ9KaCdiw+FbuF8L5pYfoZAheqjlXIjfub1SS2p68bEo3Ai
         ipgyOBCuUr1apGLlRHtnFXFUjPWWSIXV+bkStrKzw2RZGANeWPYNzLZmE+6KTTgcpbQR
         KZ+PSLVBcJktlUwFTQ3aNyg2l008FYqbUoAN141OOZDYEz4/jgSzUzQuZtFtMlG3iQnD
         ZSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768328235; x=1768933035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbC4gM3NijuXYimgCveWveeQh9WcJZZ4E8rmyHc9+jI=;
        b=KWtPC2zS3O4hFNAYmIMmPj8FNkqpsbc3geQ8oAh4WHK+PRV5mVvXBpxeGPPeUjq3Hh
         bCKAq7QfhEVEaaauFAkcUoOD1BCvsvLlmjCT/CUTJ6tdYayuDwD+NPB5SfYXWZHPmZFb
         OHrWn35Z6cQzsie7E8FA0ew8IaKcEKuMbl3GjZbEEWzp3/iuSKUir7Jzv9F7YHcCMVgD
         sb6gKs8/hfGt/RGwTc1IJ/0zw4wPyickedQzILkwZ/TJNzSk7nON6BqpbEAH/tKDwH04
         ssqzT7Hcf5Did6VrIsykWHub/dSUT0iUSg1sSZ/5GW+GqcMaPcYtddW0HR1FlQijfFVp
         GoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAjXehYGoGMYmXYdkT5UDnB2jR3IoiugHAAtCT8uJ3/fXzH+ux+lhiw+QhjPOCuKJj7IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijTuwiEhQH2eMTPdsWo9U00pDyhp8+AEQkoaJiCokE79HQ0RS
	o5MxcBg49ixYM7XmLJx1WgnnXi0CdcHCuwKeMa9vF1BuykAPnU28dH7N
X-Gm-Gg: AY/fxX7wF7uyBHe6nKuWRY/3ZO+hmhI0BuyBJdp6nicDm5tN91h5PiyP2No2foDYuze
	2uASfcm4ugvE3g0BOu2hMYAb8W+OabGPs9UXg2DwEz25B1UOlt07+aquriczJS1KPEX3K+Su95Q
	BvNMWuBWwadlQL9J/oh4Syn+GWM7TPfRimOeO5/7jqh4fjVx+U95iZmY94pyZYQx+qCdXwMg0uC
	1SswsWmZaYDQ9MrLRm8jxdH/Nikaf4c9cL1e9DyvGhqQFRiffzLBYQrcsaYoo6zvgthj1unrU8X
	rOMiNjflVhfrqiH+ZwArK+HzyR3wnjaMB87BpBRk71M0jFDus3ZRPoVCzCUzAtpZHqh76ogvMFs
	USeSFRb/4NQ5HYvNXs/V/O/B8tKmJCoMWmHkPncqUd37o8cOt/fA5
X-Google-Smtp-Source: AGHT+IF+n5iLMBZWhEQWVJQdZbJecbDSuAWt8j5wM2R/3cg9CfJ5JfAKMMsnLirF1xQdLiI7d5M3Rg==
X-Received: by 2002:a05:6512:3a83:b0:598:ee60:8af1 with SMTP id 2adb3069b0e04-59b6ef04a41mr7229668e87.15.1768328234781;
        Tue, 13 Jan 2026 10:17:14 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b71b7eaacsm4785758e87.40.2026.01.13.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 10:17:14 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 13 Jan 2026 19:17:12 +0100
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <aWaMKCTR1sw-V93G@milan>
References: <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan>
 <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
 <aWY4LQZrudJ4SB8G@pc636>
 <B077EC99-57EC-48B8-9B71-237A7A95DFE2@nvidia.com>
 <aWZUAhbMV_BHamr_@milan>
 <6d05f9ea-fc4f-4115-a416-8e779f17e0fb@nvidia.com>
 <a746ab66-79ac-4cdc-91e8-07814e172a8b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a746ab66-79ac-4cdc-91e8-07814e172a8b@linux.ibm.com>

On Tue, Jan 13, 2026 at 08:23:29PM +0530, Shrikanth Hegde wrote:
> Hi.
> 
> On 1/13/26 8:02 PM, Joel Fernandes wrote:
> > 
> > 
> 
> > > > > > > > Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> > > > > > > > 
> > > > > > > > I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> > > > > > > > 
> > > > > > > IMO, we can increase that threshold. 512/1024 is not a problem at all.
> > > > > > > But as Paul mentioned, we should consider scalability enhancement. From
> > > > > > > the other hand it is also probably worth to get into the state when we
> > > > > > > really see them :)
> > > > > > 
> > > > > > Instead of pegging to number of CPUs, perhaps the optimization should be dynamic? That is, default to it unless synchronize_rcu load is high, default to the sr_normal wake-up optimization. Of course carefully considering all corner cases, adequate testing and all that ;-)
> > > > > > 
> > > > > Honestly i do not see use cases when we are not up to speed to process
> > > > > all callbacks in time keeping in mind that it is blocking context call.
> > > > > 
> > > > > How many of them should be in flight(blocked contexts) to make it starve... :)
> > > > > According to my last evaluation it was ~64K.
> > > > > 
> > > > > Note i do not say that it should not be scaled.
> > > > 
> > > > But you did not test that on large system with 1000s of CPUs right?
> > > > 
> > > No, no. I do not have access to such systems.
> > > 
> > > > 
> > > > So the options I see are: either default to always using the optimization,
> > > > not just for less than 17 CPUs (what you are saying above). Or, do what I said
> > > > above (safer for system with 1000s of CPUs and less risky).
> > > > 
> > > You mean introduce threshold and count how many nodes are in queue?
> > 
> > Yes.
> > 
> > > To me it sounds not optimal and looks like a temporary solution.
> > 
> > Not more sub-optimal than the existing 16 CPU hard-coded solution I suppose.
> > 
> > > 
> > > Long term wise, it is better to split it, i mean to scale.
> > 
> > But the scalable solution is already there: the !synchronize_rcu_normal path,
> > right? And splitting the list won't help this use case anyway.
> > 
> > > 
> > > Do you know who can test it on ~1000 CPUs system? So we have some figures.
> > 
> > I don't have such systems either. The most I can go is ~200+ CPUs. Perhaps the
> > folks on this thread have such systems as they mentioned 1900+ CPU systems. They
> > should be happy to test.
> > 
> 
> Do you have a patch to try out? We can test it on these systems.
> 
> 
> Note: Might take a while to test it, as those systems are bit tricky to
> get.
> 
Let me prepare something. I will come back.

--
Uladzislau Rezki
