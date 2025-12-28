Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5C20C477
	for <rcu@vger.kernel.org>; Sun, 28 Dec 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766944685; cv=none; b=pWFp1tnAYLPx8BaPyAWRK4MicgC3ThvRL3BjTvS/3U2T0aMbzJBvpj2eOJt/V63jjzrL67a5StiSRQWrPXv3o5PeqTWtaWxqwKN0os+x7i1ZRekadP1Uf9fJb1r3G9ccKSpY5bEOzpl62dyRh5+cRRcuIzVReMJb/ExfNF+v0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766944685; c=relaxed/simple;
	bh=Aldvd7A5y4MV+HJjmYCViMUqWpaOlcCfUbSup6qEAOw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQNCTASiGiepOJwZEpSWqa5/0vwBgNqD5tOmHg0VOxZ4d7yBfq1CKpQbHCa+TydJnpPdAj3wqTXzCuzdrn9adMbKFDxAmiLl2T2q69eqTcMReYfUUtwVPEdNaXYYr9Fmxj5lekblQA85j3oomJd+oPwIczBo4UM3xsNvKCVisas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+erRx5j; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+erRx5j"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37fd6e91990so65996131fa.3
        for <rcu@vger.kernel.org>; Sun, 28 Dec 2025 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766944682; x=1767549482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAFmivjsQTgERIVGyEMEyxcJB51e29aR+8Wf6D6WKzQ=;
        b=P+erRx5jADAvJGv5GGx+QsNfrpr7P5XYcNhduruNFSkt47hamlhNCu4QBHDhp6GOiJ
         fzr88kSwzxFnR7aPy1XyB6CSLLiND8n1nQOU21/qtLUkdo+VgNOLB535iUffTCjy+O+g
         0prGeEk0c9CzjT6BiY8oAwwBZ9yG7cTHc6A7+cNwsAvSC+5akf2GbfAHNMMLX3+cfTSD
         E1mjfnQKVR/Tx+iUlHW0pS0ZAW+a3ZlVirNFVSlrqZS8B6N9irBjYGF93c61liVTS74c
         0o9M5uzA7X3r8NB0pI2XQXXZwK+qvDRIT+dcnbJMf46IABn02P3WVh0n/js6tCu01cDY
         gAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766944682; x=1767549482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAFmivjsQTgERIVGyEMEyxcJB51e29aR+8Wf6D6WKzQ=;
        b=QCeY+ne5cGuJu0fqc7c7fG9WgImlrAPsxobEJJPZkyTzdL/MiOo0ffxOfYHTzrXF+D
         3FC+0KKAegz6pyDSXMpSbtaLVvrUCUZCnKVfD1UUJBiBCFUoBOu/8rJrajSZuAhA8nw2
         FEgiXoTBMpFo+BIZJZ3yCX+us0uIcYxO8mMjMq4RsONz0ukRVG64yz2+CDXUSDGO2iEW
         bN7Y/+BgH+Uff2Dl/6AGMNAgh7IxI3v1tmLZwi6y6pHumb/cbTfksi48CS40A4EusMEJ
         vMxAQBjCE9X+P4JlyByhEPMq5U1nTjkgJg9bZMsK/MUqjuGsGPbCJuuTOhKDzi3MgY8I
         Dfaw==
X-Forwarded-Encrypted: i=1; AJvYcCXW/OdFXB03WUQJ1XpdfR2yi7yCzZJOQPz/wi3qrCa5BcWVnSUlGyeeXlt/xzAPsmHmAGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+BRMDgJhWnYiyOQAKvY7jm/4+h4N/rbs54u8/083gXBRvQwR8
	Sy3laEDuc7nR7e4HMID3qjtcRph2OgG0R1yHszkyjBXSAeYYmEg3Z6Zd
X-Gm-Gg: AY/fxX70XJ7EUDkf1maQPgo2gW1oFZrWnaF9jzE2zUWh1reE47ILQ2SgihaC/swNeQQ
	yl+N/ZEGHRIZxN8rqoyfRzaRPxj0xMfFNQ1+iHHF8RAEiLukgmeZ96aWqW7PcXGplfMSiR+Yd58
	KxTw0+QNYjh2+n/STcPQgt7JzKlN/HkxgU4ieX35olJOACaaN4B0FAndA5xXBzAJv82I1O3CpcZ
	vU8oU5Dp76DAvDkgB5DQaHwuVNN425sH7Hvs3J3KVWMhCe9MwUbibSJlJUeTVXCsxY6RLBTJV3h
	HUTMeMk9xEco01SW+mOBDCg4MH1ErAHZ0VufhDTn5ZtmqoJaFyow83UC87Suvumm4ylw+C+wvYp
	jlVr3SoHE5+stdwIaKMf9ZcSMlRBKUtrcy8YX4EwuYjB+lJE1A4kH
X-Google-Smtp-Source: AGHT+IHYXN3oVgd6jMbxvqn4l7j/XsJvb+MP5m5mhQgaF1h0f0io0mWv7X+vSo6SQJr2bzS2CTWfGw==
X-Received: by 2002:a05:651c:a0a:b0:382:8844:2080 with SMTP id 38308e7fff4ca-382884420e0mr4398141fa.25.1766944681800;
        Sun, 28 Dec 2025 09:58:01 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de70asm73625811fa.4.2025.12.28.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:58:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Sun, 28 Dec 2025 18:57:58 +0100
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Message-ID: <aVFvppCjx26yn6Wx@milan>
References: <20251223034630.1092719-1-joelagnelf@nvidia.com>
 <b355f3ed-3916-4419-951b-33e3788427f4@paulmck-laptop>
 <20251226023339.GB739018@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226023339.GB739018@joelbox2>

On Thu, Dec 25, 2025 at 09:33:39PM -0500, Joel Fernandes wrote:
> On Thu, Dec 25, 2025 at 10:35:44AM -0800, Paul E. McKenney wrote:
> > On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
> > > The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> > > State) design where the first FQS saves dyntick-idle snapshots and
> > > the second FQS compares them. This results in long and unnecessary latency
> > > for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> > > 1000HZ) whenever one FQS wait sufficed.
> > > 
> > > Some investigations showed that the GP kthread's CPU is the holdout CPU
> > > a lot of times after the first FQS as - it cannot be detected as "idle"
> > > because it's actively running the FQS scan in the GP kthread.
> > > 
> > > Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> > > state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> > > GP kthread cannot be in an RCU read-side critical section while running
> > > GP initialization, so this is safe and results in significant latency
> > > improvements.
> > > 
> > > I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> > > showing significant latency improvements (default settings for fqs jiffies):
> > > 
> > > Baseline (without fix):
> > > | Run | Mean      | Min      | Max       |
> > > |-----|-----------|----------|-----------|
> > > | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> > > | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> > > | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> > > | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> > > | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> > > | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> > > | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> > > | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> > > | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> > > | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
> > > 
> > > With fix:
> > > | Run | Mean     | Min      | Max       |
> > > |-----|----------|----------|-----------|
> > > | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> > > | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> > > | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> > > | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> > > | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> > > | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> > > | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> > > | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> > > | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> > > | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
> > > 
> > > Summary:
> > > - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> > > - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
> > > 
> > > Tested rcutorture TREE and SRCU configurations.
> > > 
> > > [apply paulmck feedack on moving logic to rcu_gp_init()]
> > 
> > If anything, these numbers look better, so good show!!!
> 
> Thanks, I ended up collecting more samples in the v2 to further confirm the
> improvements.
> 
> > Are there workloads that might be hurt by some side effect such
> > as increased CPU utilization by the RCU grace-period kthread?  One
> > non-mainstream hypothetical situation that comes to mind is a kernel
> > built with SMP=y but running on a single-CPU system with a high-frequence
> > periodic interrupt that does call_rcu().  Might that result in the RCU
> > grace-period kthread chewing up the entire CPU?
> 
> There are still GP delays due to FQS, even with this change, so it could not
> chew up the entire CPU I believe. The GP cycle should still insert delays
> into the GP kthread. I did not notice in my testing that synchronize_rcu()
> latency dropping to sub millisecond, it was still limited by the timer wheel
> delays and the FQS delays.
> 
> > For a non-hypothetical case, could you please see if one of the
> > battery-powered embedded guys would be willing to test this?
> 
> My suspicion is the battery-powered folks are already running RCU_LAZY to
> reduce RCU activity, so they wouldn't be effected. call_rcu() during idleness
> will be going to the bypass. Last I checked, Android and ChromeOS were both
> enabling RCU_LAZY everywhere (back when I was at Google).
> 
> Uladzislau works on embedded (or at least till recently) and had recently
> checked this area for improvements so I think he can help quantify too
> perhaps. He is on CC. I personally don't directly work on embedded at the
> moment, just big compute hungry machines. ;-) Uladzislau, would you have some
> time to test on your Android devices?
> 
I will check the patch on my home based systems, big machines also :)
I do not work with mobile area any more thus do not have access to our
mobile devices. In fact i am glad that i have switched to something new.
I was a bit tired by the applied Google restrictions when it comes to
changes to the kernel and other Android layers.

--
Uladzislau Rezki
