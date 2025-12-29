Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C902C0284
	for <rcu@vger.kernel.org>; Mon, 29 Dec 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008829; cv=none; b=hmDyk/g8SpJuCJJ9WaGWwNDygQ8ZPLi28y0grzAlz3Hlv8GzicGhp+SgjDr0w+CvUaioEDQ+/b4p3nJIWB1O8bwEaIQS/pgnWrJgKHvvNsL5OLdgrxcO/3vHjbPm8YMNKhCMxzBwHKVe/7Po3be65T8tczeWOiJomhRLqQpWm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008829; c=relaxed/simple;
	bh=HkH5N2sCSZATBK6DPKkbYweTOgvAx2hC81qJ2oZEES0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Pa2VQbGnjSVlJxw1/efeTaFAsirvzKNum7OrGauDBV+1nsAgNRvod5PNPLXN5QRxRU40lVVlABfobCeOSz+o65iuw8r/y3N02DShST88xlqESAG1D3Hn0a3pjiO7K31SFXZtY61YNqrbMItGtt0FSIK3SMMsc0ZjZe5TsJlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj/nPovB; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj/nPovB"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37ce27af365so77759541fa.0
        for <rcu@vger.kernel.org>; Mon, 29 Dec 2025 03:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767008824; x=1767613624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H25YjglsiDocpn+BoTyVRQ1j/CuNDDswQSIC0niKha8=;
        b=Oj/nPovBrQ2+yf684fPsdDIu/NynNPycOpOn4NLhFG9onoJvNwiNguDtJScPBUiItc
         BrR6ZkBa3dPY8y1ONPrHqasyIEA74Vd6QT50tj4YXUDvyn23f9wnSOvVp9oheB3fEW89
         XhA13pt6TORsTWLf1TsSZ9VsSKvXUKKP30i6WuOtuiLMjvWgxvcz0h1kC2Sm4foGlZ8D
         pY+mpfTC6Z3drXh5qo/QrP169vUV8wjysRPYBWLn/tWjSyEPoWXSpMDkcxPOme/Pph4s
         5gda6RetD4knfBC63Y4PljqZ8H9eSJRKq4etWJIHBU3xYbwmUkadKd0q/FO1E8mzeDEC
         /V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767008824; x=1767613624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H25YjglsiDocpn+BoTyVRQ1j/CuNDDswQSIC0niKha8=;
        b=eziqoAN0Cgj2fsipqAHWDWvN1iFqwjnEytP8iakT7QyadyaC9oJouy1OKLSRcLsFhQ
         mK7loD/vPZNmPEvrJteHOPP7wgVgoeVbomnjykYiPJJBwc6SjN3bgxhCTYhWAZJyNgTi
         6rgpmRhqt/TxS7qfp4FDXyP/8kcxpbl0QiIAPmoueCG8qvqxe/W7lkqwqS2aOIyUaz+k
         MDV1VdTYgtA8wECEoMH/4rLshNqhnL5j6ND5pYjR6pduWNCcmfFzoILAwYRK5AJX3Iss
         yYTlvFancQC60smHcYviolZtbfNQInkBA9W3MXyrrboikIkHyeTHJAj0Id+yzDQCoz+R
         tz3A==
X-Forwarded-Encrypted: i=1; AJvYcCV9m+/zytt4wkpaVRDJzhCnKAqwik+ZPZ/28J/IycMeTSBx3XuflwdVtRNwuqiuiqA8t2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZumyVzmw/Nug5Lv4NUQ3n1/M9VRevK7etJGfN2XCtwZkoSTQ
	f9Y6JWMVl7/3VK7ekOnXar6GoW5s1hNU9iekggI4UC2bAWe1duhbSKs3
X-Gm-Gg: AY/fxX6FbcE8nwW9uYA+q2S4Qm9abu7edL1wRyTcE1Kk6zWbTs2sAJqczwbGYXNlNrh
	8XJ3atUCgfK7xLVADXmDM/ZOqyBZcEjiBRl067Megr3KzuKuC4lcHE3jc+AqUZKVah2SRQD44nS
	PprSPU64RY+E6hGDfZSY59Tx/eIeKGXmVfAmwG7Kdt71N31a4wICRyGhOVSNodLHNQEuHo2twG1
	AbHXC8R19vManUXlkQYWl3M2+q2juH9eQCCcATn91KC3z5JXgpb4kL4Y7U5w3Hf2kewBQoxuom6
	jN7dJR2NBHwTfdku3/Mt2Pp5z38tu+JyT5yUKoqrzdpMm0VPRPVkAw5j3IQAhrKgKDL8mER4gsp
	+7Nn1+o4nNqvn0lUVIlvajjgSijIxmZVAQAqnz3YeflbfxKFE+clkTsw+VQDXWeA=
X-Google-Smtp-Source: AGHT+IFSg+WSEwB3XB79RKQVyNhsmnCsLQUY9OP3lUuJ7bveG+0qIPegeK5CbVGhYsQruQ8DQXKbvw==
X-Received: by 2002:a2e:b8c5:0:b0:372:8d61:c26f with SMTP id 38308e7fff4ca-38121605c79mr97545091fa.11.1767008824228;
        Mon, 29 Dec 2025 03:47:04 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812264cc13sm82419611fa.37.2025.12.29.03.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:47:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 29 Dec 2025 12:47:01 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Message-ID: <aVJqNYGfboJBc37w@milan>
References: <20251223034630.1092719-1-joelagnelf@nvidia.com>
 <b355f3ed-3916-4419-951b-33e3788427f4@paulmck-laptop>
 <20251226023339.GB739018@joelbox2>
 <aVFvppCjx26yn6Wx@milan>
 <1033a68f-c17b-4847-819d-7fb4e9e45016@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033a68f-c17b-4847-819d-7fb4e9e45016@paulmck-laptop>

On Sun, Dec 28, 2025 at 04:04:49PM -0800, Paul E. McKenney wrote:
> On Sun, Dec 28, 2025 at 06:57:58PM +0100, Uladzislau Rezki wrote:
> > On Thu, Dec 25, 2025 at 09:33:39PM -0500, Joel Fernandes wrote:
> > > On Thu, Dec 25, 2025 at 10:35:44AM -0800, Paul E. McKenney wrote:
> > > > On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
> > > > > The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> > > > > State) design where the first FQS saves dyntick-idle snapshots and
> > > > > the second FQS compares them. This results in long and unnecessary latency
> > > > > for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> > > > > 1000HZ) whenever one FQS wait sufficed.
> > > > > 
> > > > > Some investigations showed that the GP kthread's CPU is the holdout CPU
> > > > > a lot of times after the first FQS as - it cannot be detected as "idle"
> > > > > because it's actively running the FQS scan in the GP kthread.
> > > > > 
> > > > > Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> > > > > state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> > > > > GP kthread cannot be in an RCU read-side critical section while running
> > > > > GP initialization, so this is safe and results in significant latency
> > > > > improvements.
> > > > > 
> > > > > I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> > > > > showing significant latency improvements (default settings for fqs jiffies):
> > > > > 
> > > > > Baseline (without fix):
> > > > > | Run | Mean      | Min      | Max       |
> > > > > |-----|-----------|----------|-----------|
> > > > > | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> > > > > | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> > > > > | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> > > > > | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> > > > > | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> > > > > | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> > > > > | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> > > > > | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> > > > > | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> > > > > | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
> > > > > 
> > > > > With fix:
> > > > > | Run | Mean     | Min      | Max       |
> > > > > |-----|----------|----------|-----------|
> > > > > | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> > > > > | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> > > > > | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> > > > > | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> > > > > | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> > > > > | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> > > > > | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> > > > > | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> > > > > | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> > > > > | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
> > > > > 
> > > > > Summary:
> > > > > - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> > > > > - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
> > > > > 
> > > > > Tested rcutorture TREE and SRCU configurations.
> > > > > 
> > > > > [apply paulmck feedack on moving logic to rcu_gp_init()]
> > > > 
> > > > If anything, these numbers look better, so good show!!!
> > > 
> > > Thanks, I ended up collecting more samples in the v2 to further confirm the
> > > improvements.
> > > 
> > > > Are there workloads that might be hurt by some side effect such
> > > > as increased CPU utilization by the RCU grace-period kthread?  One
> > > > non-mainstream hypothetical situation that comes to mind is a kernel
> > > > built with SMP=y but running on a single-CPU system with a high-frequence
> > > > periodic interrupt that does call_rcu().  Might that result in the RCU
> > > > grace-period kthread chewing up the entire CPU?
> > > 
> > > There are still GP delays due to FQS, even with this change, so it could not
> > > chew up the entire CPU I believe. The GP cycle should still insert delays
> > > into the GP kthread. I did not notice in my testing that synchronize_rcu()
> > > latency dropping to sub millisecond, it was still limited by the timer wheel
> > > delays and the FQS delays.
> > > 
> > > > For a non-hypothetical case, could you please see if one of the
> > > > battery-powered embedded guys would be willing to test this?
> > > 
> > > My suspicion is the battery-powered folks are already running RCU_LAZY to
> > > reduce RCU activity, so they wouldn't be effected. call_rcu() during idleness
> > > will be going to the bypass. Last I checked, Android and ChromeOS were both
> > > enabling RCU_LAZY everywhere (back when I was at Google).
> > > 
> > > Uladzislau works on embedded (or at least till recently) and had recently
> > > checked this area for improvements so I think he can help quantify too
> > > perhaps. He is on CC. I personally don't directly work on embedded at the
> > > moment, just big compute hungry machines. ;-) Uladzislau, would you have some
> > > time to test on your Android devices?
> > > 
> > I will check the patch on my home based systems, big machines also :)
> > I do not work with mobile area any more thus do not have access to our
> > mobile devices. In fact i am glad that i have switched to something new.
> > I was a bit tired by the applied Google restrictions when it comes to
> > changes to the kernel and other Android layers.
> 
> How quickly I forget!  ;-)
> 
> Any thoughts on who would be a good person to ask about testing Joel's
> patch on mobile platforms?
> 
As Joel already wrote, Suren probably is a good person to ask :)

--
Uladzislau Rezki
