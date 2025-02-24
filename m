Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14D1EB3E
	for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372025; cv=none; b=o9l9GXWU0tRDbJK0lDjYrcxT8/L+0Mfg6rRVQYpTd5CHoUBKAUK3kZ6DfiT58KtWOvti09JDVae8cwb0b8GYZBpSNbV2J649aeEdi4KGzljDVmgO3VAanUy71xCNUHPi2KCZpeXNN6WtWyhc7BR27behW7ttFKVMdAY5+AvApQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372025; c=relaxed/simple;
	bh=7aOn/n9ydfblSdbbERb2pYl6zATx2cIjSiLxOM7O9Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msc/pxtWpqYSDmDAmCfe4vqq2g70PoPNGZas8XDRURG3jQqwCzS52DQJ3r7OD7tCGwRLN1RX3XpDaBN2+vjh/C44mTPBBfFrZzF8PjpCgb36x6GDWccTKGTC50zD3Ub1SnDuhhxyx+rP+YAwrYTuhRF+hd1nriaHEREO7hbsGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQk3e4eP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQk3e4eP"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0a4b030f2so538217085a.0
        for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 20:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740372022; x=1740976822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0o+mSdoO6usP7w4Zy/wg4+VbHOO8CmvBrRjZXQYt6U=;
        b=QQk3e4ePbqGg/DIMxLAVQ/kCFcbjJFzTnNYTxMnOwEjQTrY5Unn9RD/LFkqCZDtzl7
         X6RNUG4wG9NG5il9NjlpynJyWUbIJuWXxhQREPPT7Z4H4jy8rOtePLnxzGXu4mzE+1yr
         veJdOt5LVIRQFMJrOe1KQ1Nf3BoPVXRyxuR0ZO3LXT16oY1g0X4uUJBz+O5oei1RgPg1
         e3dwWLx/F8RbHPthukBmQhIVCuwTBhrs29A8wru9kFVHp0jknDn0HqB+8dsVGC/yPamI
         33mz7xO/Vc8wsPf6Wrftk99DnUqNqHr683iM94fF8iuFTQTlpmTohOJdP+9X43mqCm78
         KCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740372022; x=1740976822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0o+mSdoO6usP7w4Zy/wg4+VbHOO8CmvBrRjZXQYt6U=;
        b=WG+Wsi68cmLsUgRE1kNUTLTIg3GK1GaqtqZ83igH6ZBCCDd7MoGoNVgVzBiQ0cG+7p
         BPfz2IwxjKUs1SExZ1ZaAQ/aUOPL2ckLNdPFkd1m1xOcnJXgJjC2uspSxVZ6i91k90IF
         3PU87uX/AoMQfpclWEeWRXrc9ah6TpAA6wbloeoYldVxdwI6dqIJSC8PmKn5A3Pcj7rs
         fF2W98+wDbIrrnySDJkwM8Q2lCx1mDvfjTk8i69fyQRaisojvC8/Yv6+7E7gi3XtxMIV
         5/A9OtEcr/j8sBPbwC8bGdmlhSac3vMQgbiFX4iZR6HRPIYxMl5zrcZxZIvqDubowIkP
         8Iug==
X-Forwarded-Encrypted: i=1; AJvYcCUqKYmXW80YAkhYuso1hxmz885IXMwOuS8SHKk1VjNUjVoZsXSygHzgLAgSH4kFrNkVVTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWjcaQ4LaUWAhRFhXy1kJIJgeYu0KnKSqgBHvNaBLV5nVYSTk
	MN7qXsraXjNOIJP4lNFbjVdGYGFHc7QIWTSAjUjk/KOIDhg2KMfhWchCpg==
X-Gm-Gg: ASbGncto85NaRz9qr8x4HJlSnDOowqtIsfGehxXIe2AaZFFb9Zu8cA1ssTXJIiDyWRY
	kx7n0a0c6VpK/n4v4YRcm3H5B2Uz3YuLcc+l9erLnTy+oSMuMEVpQ1EPAdmuEs2/AE/OvrvgI4C
	rk0wJS34js7EjyOHhTuoE7MHxXHuS9IKZhMPApsADREvQbXDrCWQaQBTJq/5tWIg2Ctn6bkjN4P
	Hg8jeDD9jTJxiXycSvPBZihvToX1QWs9Fg5Jiby0YVqJDwiQAEA0LURmLStd8P5lCV9UwMgP0Pw
	FICgA/bJPA5fBQzJ7Iac2yZugV+tMHPd++Z5bbKgcZd4nmqvUI6DGB1C/zTMrRpswt+W5ygDvZC
	SY8Mc+FgVv0XoSNJe
X-Google-Smtp-Source: AGHT+IFRc07AA7Z7laLAli64j6wQl2yXaXyNFQuy6nLDkttwtei6GdMMgQviFMx62jjYAIFEbkyvJA==
X-Received: by 2002:a05:620a:3916:b0:7c0:bc63:7b76 with SMTP id af79cd13be357-7c0cf9504bamr2172811285a.36.1740372021630;
        Sun, 23 Feb 2025 20:40:21 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a4b4908esm886184085a.80.2025.02.23.20.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 20:40:21 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id AB8371200068;
	Sun, 23 Feb 2025 23:40:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 23 Feb 2025 23:40:20 -0500
X-ME-Sender: <xms:NPi7Z4mxG5xHLrUcESuep8BMBMIW3kWFjgTGq_-TVViEClxMqFNADQ>
    <xme:NPi7Z33JjRki4SMZcnKl8wyrpJUCWTzHWMIbgK6uJFw_BsAyVfkpwmpO0IvybEDY1
    zNu8p2QHmM9jImb1Q>
X-ME-Received: <xmr:NPi7Z2pwAWETfr10tTI4c9HYjz2zoUWkfFbtFbxX-mzq1stTuaSvXhDADw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvdevkeegkeeggfevkeetjedvhfekieekudfg
    ueeghfekgeduvddulefgteegudelnecuffhomhgrihhnpedtuddrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhlih
    hvvghrrdhsrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehprghulhhmtghksehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhkuhhrrdgrrdgrrhhorhgrsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehovgdqlhhkpheslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrh
    iisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:NPi7Z0mFN2vtSKsnoej2LLjkmRE4q3K-o7ubYTZAm4fo8kMLaO_YDw>
    <xmx:NPi7Z20a8_EWkY63G-trpAOvCikqaP6b1z8mujNH1AjbAe5D3atFOQ>
    <xmx:NPi7Z7vKotH15n284d7Q4ekibmclzP0SgWAZvqGiXH7xXLqmHLeBLw>
    <xmx:NPi7ZyXldQVbZSK2hYXZY_40_g-AUkM6FpzHqq9I05-LdKmXoxURzA>
    <xmx:NPi7Z52b3psLUitBkmOve-TSD87rkh8kUDj3liYa4rMOS_n5_6qrWG8Z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 23:40:20 -0500 (EST)
Date: Sun, 23 Feb 2025 20:40:19 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [linux-next:master] [rcu]  c9b55f9da0:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <Z7v4MytjhhBZkG4S@Mac.home>
References: <202502171415.8ec87c87-lkp@intel.com>
 <08e755d1-9f7d-4238-ac2d-1869d68a8ddc@paulmck-laptop>
 <Z7gkXQMxTc2J4KQ9@xsang-OptiPlex-9020>
 <64d58e80-3601-4f9b-ae46-756dd124345f@paulmck-laptop>
 <Z7vXylQt2yR6HCa6@xsang-OptiPlex-9020>
 <Z7vltauHgdSdo7Ui@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7vltauHgdSdo7Ui@Mac.home>

On Sun, Feb 23, 2025 at 07:21:25PM -0800, Boqun Feng wrote:
> I finally find why I cannot reproduce this, I accidentally used
> next.2025.02.10a to build the kernel first, which has commit
> ("rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool"),
> which changes Kconfig RCU_TORTURE_TEST_CHK_DRD_STATE into a bool and
> that disabled the test... (because config from you has it as =m).
> 
> On Mon, Feb 24, 2025 at 10:22:02AM +0800, Oliver Sang wrote:
> > hi, Paul,
> > 
> > On Fri, Feb 21, 2025 at 05:02:51PM -0800, Paul E. McKenney wrote:
> > 
> > [...]
> > 
> > > > > 
> > > > > And rcutorture's WARN_ON() has a bug that is exposed by that change
> > > > > in Kconfig option.  Does the patch shown below help?
> > > > 
> > > > the patch does not fix the WARNING in our tests. attached one dmesg FYI.
> > > 
> > > Just to make sure that I understand, this patch was applied against this
> > > commit, correct?
> > > 
> > > c9b55f9da0d2 ("rcu: limit PREEMPT_RCU configurations")
> > > 
> > > I am guessing this based on this dmesg line:
> > > 
> > >  [  109.553307][  T781] CPU: 1 UID: 0 PID: 781 Comm: rcu_torture_rea Tainted: G                T  6.14.0-rc1-00007-gc9b55f9da0d2 #1
> > 
> > above line is not from the dmesg I attached in last mail. it's from
> > https://download.01.org/0day-ci/archive/20250217/202502171415.8ec87c87-lkp@intel.com/dmesg.xz
> > which is for our original report.
> > 
> > > 
> > > Is this really the case, or am I confused?
> > 
> > we applied your patch as:
> > 
> > 89519085afdf2 fix for c9b55f9da0 from Paul
> > c9b55f9da0d2c rcu: limit PREEMPT_RCU configurations
> > f001b7165def8 osnoise: provide quiescent states
> > 
> > so in the dmesg I attached in last mail (I attached it again in this mail):
> > 
> > [    0.000000][    T0] Linux version 6.14.0-rc1-00008-g89519085afdf (kbuild@9871be4fdbcc) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT Fri Feb 21 00:34:02 CST 2025
> > ...
> > [  117.463907][  T812] CPU: 1 UID: 0 PID: 812 Comm: rcu_torture_rea Tainted: G                T  6.14.0-rc1-00008-g89519085afdf #1
> > 
> > the change of this 89519085afdf2 is as [1]
> > 
> > I'm not sure if it's better to upload dmesg for fix patch to
> > https://download.01.org/0day-ci/archive/20250217/202502171415.8ec87c87-lkp@intel.com
> > again, so I did not do that. sorry if this causes confusion.
> > 
> > not sure if this is the correct applyment? thanks
> > 
> > [1]
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index d26fb1d33ed9a..de85a88810cf6 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -1873,6 +1873,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
> >  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
> >  static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
> >  {
> > +       int mask;
> > +
> >         if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
> >                 return;
> > 
> > @@ -1902,8 +1904,10 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
> >         WARN_ONCE(cur_ops->extendables &&
> >                   !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
> >                   (preempt_count() & PREEMPT_MASK), ROEC_ARGS);

And we need another fix for the WARN_ONCE() above because in
non-preemptible RCU on a preemptible kernel, rcu_read_lock() is just
preempt_disable(). Sending both really quick.

Regards,
Boqun

> > -       WARN_ONCE(cur_ops->readlock_nesting &&
> > -                 !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
> > +       mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> > +       if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> 
> Now look into this, I think this should be:
> 
> 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> 
> because:
> 
> *	For preemptible RCU, ->readlock_nesting() will return 
> 	rcu_preempt_depth()
> 
> *	For non-preemptible RCU, ->readlock_nesting() will return
> 	preempt count.
> 
> , which means if RCUTORTURE_RDR_PREEMPT or RCUTORTURE_RDR_SCHED is in
> the curstate for *non-preemption RCU*, ->readlock_nesting() will be >0.
> That is, the "mask" needs to consider _PREEMPT and _SCHED for
> *non-preemption RCU*, not preemptible RCU.
> 
> Paul? Did I get it right?
> 
> Regards,
> Boqun
> 
> > +               mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> > +       WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
> >                   cur_ops->readlock_nesting() > 0, ROEC_ARGS);
> >  }
> > 
[...]
