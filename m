Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468C2343AE;
	Mon,  3 Mar 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017830; cv=none; b=VyaYLZS0cpUSI0h+4qMXZIDL/lPxbhaJGkr9gXyJQtxlS6fdj5YGXT6YEHB65bfR+IGw6AdeyZ7SCNKXe37cjx35CsToccCWTEJK9Kmsxn278xrpCKu0twejbzh5SiNWSEdPd6GTF9V1SMyuo4TKk2WxXoXhwruLqDPEbLqQQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017830; c=relaxed/simple;
	bh=K9/AQDAf1TTF20oZGaRFG3Ajc6WqbwAy1cZIKuifTKE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMX9eXKvRiLbyExhO8lydKnxWQGwDubVrAA2hm/RkkHgdKPKhCB1M/OUZ1ZHqPH7Ke1cIyXYXKh334j43T9IWzdZEihKFJduCV4RJHuNHGvl4wqby/tLKadwOpK2U+ogvKj9jw5liPJJrNUM5RbO683GdmvsJRKSXLS0DxdE9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxbbpNZv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxbbpNZv"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-548409cd2a8so4744387e87.3;
        Mon, 03 Mar 2025 08:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017826; x=1741622626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGm5mmMzr5+gmD7/0oRkuukrN0T9bkZiu15KcUlBcIc=;
        b=NxbbpNZv8A6PSLmUx8Br/SM1hxwpQwqAod7uVYVKYYQWaefEbYA+rShmuKS7jAiFVb
         hMPOEPsIcnjiD/fx2K7oTE8S/T1ijZFRgL4BFWTLmhNpyQSzUSIA2gURhdkeZzSo4mFh
         upklOZ/O4Edyxh73v4QeQNC51NdHOQRY0Xk7p3ZuaxV6f6FjHuWYzmgcy9pI5OdcoJbs
         zMr5+8EXmyuqCxmnFRTAG7bmyQJtYoM2QmD9mQFsQTzaFwfcdhUiq9T7F8gOZBrAx0NZ
         EOEMJdUPayhUaKuTMEyI3yGvHlf9hxzIjZG4oBdhiL5mQDK+FwaIOlop/UCaZFPW4dGp
         xN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017826; x=1741622626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGm5mmMzr5+gmD7/0oRkuukrN0T9bkZiu15KcUlBcIc=;
        b=qV8/ZBHTJxmiPf4JxMFK0E++c2Y1aOF0aX33BFJtK01T9IdUMjMpF35vcGAO16HbCX
         Bbso0D6Ch61da7oab84Ie9nPEpzZm23Hht0m0jRudEMuEICU3FZnW36dIkWvueG/06kA
         pluSS1Pa5vVyWM7HrgXgVcChZfpvynsQjMXi9J2eZSQBBkAACvmNuPkArA2dtNZJXpec
         4IK2iPyGGsE/7dJ5yMJIaHXNCVvgsJoF9efdbzjOHrjVBPmztvujUw63UWU5vvUnatGI
         6Pi7BnW7hYap8KAo3VGskhVOqoXOGcuaOhfC30TpgKUzZLuHJUDW3o7EK4+KGlbGddx8
         Uo/g==
X-Forwarded-Encrypted: i=1; AJvYcCU2Avw4sULclFSdRDu4Je2VGC0hnEIT05oZ0ldED7gTuB/sl67woFrqINkp50tSn9UkfqCLrVEuvnUr0v8=@vger.kernel.org, AJvYcCWTnF2MC55HtP2TzyztLLjmI4I7mQuauh1SZMO/Vd8za/8HD1r6fCVddaKBxmVRz0ahV+bS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HiRIJagJvBoHfpubqrxgov8aU8jO4LvzNuou7qHeuk3EU0Ik
	TfC6Yvh1QGWbfgpHsW1x9e05KQ37LJCCikzMvtsvB/WPtbnous32
X-Gm-Gg: ASbGnctoJ+RXJIA+dB8qs2BHi80YHT8CasWTmMELMTT9I4PTc3mFLCFmQW1sjp26qcF
	bzVu+/zDiWNJFRqaNeT22llKaSclKvtlj6851pkf3SOxFUzpG+wLRqZQ+TjwjY7yE1XmH9W1yga
	lW9It5g5vnCMrYgNul66TpJ9iSabljxe4lQsUpBopj7lmKINsPxVrGNFbEbhhJXBXuDjGx9qxXe
	kJzOoc2xCr1XhkIgsKzjNMrAxGmj3xyIhIRAkaV89HTAjYhYP+pxLbUCH8qLUx3nLBshjvhYTEK
	g1dTtEj+9es=
X-Google-Smtp-Source: AGHT+IHQ9QIWigeXjOQEL4SSVtYjRkzqP/8sLAtjcON0jotEGBTKj0liFEziO0qTYuwT/ExG69vuVw==
X-Received: by 2002:a05:6512:2820:b0:545:fba:8a57 with SMTP id 2adb3069b0e04-5494c10c5e4mr4378966e87.8.1741017825649;
        Mon, 03 Mar 2025 08:03:45 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495522216bsm968381e87.252.2025.03.03.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:03:44 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 3 Mar 2025 17:03:42 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8XS3hJFR3qMNniG@pc636>
References: <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <Z8QwwBCoWb4J3_Xv@pc636>
 <d90bd6d9-d15c-4b9b-8a69-95336e74e8f4@paulmck-laptop>
 <Z8SnhS_LnzN_wvxr@tardis>
 <e62483fc-489e-40bd-b77d-b4728a53df3e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62483fc-489e-40bd-b77d-b4728a53df3e@paulmck-laptop>

On Sun, Mar 02, 2025 at 12:36:51PM -0800, Paul E. McKenney wrote:
> On Sun, Mar 02, 2025 at 10:46:29AM -0800, Boqun Feng wrote:
> > On Sun, Mar 02, 2025 at 09:39:44AM -0800, Paul E. McKenney wrote:
> > > On Sun, Mar 02, 2025 at 11:19:44AM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > > > > > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > > > > > Hello, Paul!
> > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > > > > > > > RCU tree:
> > > > > > > > > > > > 
> > > > > > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > > > > > > > 
> > > > > > > > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > > > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > > > > > 
> > > > > > > > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > > > > > 
> > > > > > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > > > > > 
> > > > > > > > > I can trigger it. But.
> > > > > > > > > 
> > > > > > > > > Some background. I tested those patches during many hours on the stable
> > > > > > > > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > > > > > > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > > > > > > > right away.
> > > > > > > > 
> > > > > > > > Bisection?  (Hey, you knew that was coming!)
> > > > > > > > 
> > > > > > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> > > > > > > 
> > > > > > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > > > > > 
> > > > > > Huh.  We sure don't get to revert that one...
> > > > > > 
> > > > > > Do we have a problem with the ordering in rcu_gp_init() between the calls
> > > > > > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
> > > > > > do we need to capture the relevant portion of the list before the call
> > > > > > to rcu_seq_start(), and do the grace-period-start work afterwards?
> > > > > 
> > > > > I tried moving the call to rcu_sr_normal_gp_init() before the call to
> > > > > rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> > > > > Which does not necessarily mean that this is the correct fix, but I
> > > > > figured that it might at least provide food for thought.
> > > > > 
> > > > > 							Thanx, Paul
> > > > > 
> > > > > ------------------------------------------------------------------------
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 48384fa2eaeb8..d3efeff7740e7 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
> > > > >  
> > > > >  	/* Advance to a new grace period and initialize state. */
> > > > >  	record_gp_stall_check_time();
> > > > > +	start_new_poll = rcu_sr_normal_gp_init();
> > > > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > > >  	rcu_seq_start(&rcu_state.gp_seq);
> > > > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > > > -	start_new_poll = rcu_sr_normal_gp_init();
> > > > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > > > >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > > > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > > > >
> > > > Running this 24 hours already. TREE05 * 16 scenario. I do not see any
> > > > warnings yet. There is a race, indeed. The gp_seq is moved forward,
> > > > wheres clients can still come until rcu_sr_normal_gp_init() places a
> > > > dummy-wait-head for this GP.
> > > > 
> > > > Thank you for testing Paul and looking to this :)
> > > 
> > > Very good!  This is a bug in this commit of mine:
> > > 
> > > 012f47f0f806 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
> > > 
> > > Boqun, could you please fold this into that commit with something like
> > > this added to the commit log just before the paragraph starting with
> > > "Although this fixes 91a967fd6934"?
> > > 
> > > 	However, simply changing get_state_synchronize_rcu_full() function
> > > 	to use rcu_state.gp_seq instead of the root rcu_node structure's
> > > 	->gp_seq field results in a theoretical bug in kernels booted
> > > 	with rcutree.rcu_normal_wake_from_gp=1 due to the following
> > > 	sequence of events:
> > > 
> > > 	o	The rcu_gp_init() function invokes rcu_seq_start()
> > > 		to officially start a new grace period.
> > > 
> > > 	o	A new RCU reader begins, referencing X from some
> > > 		RCU-protected list.  The new grace period is not
> > > 		obligated to wait for this reader.
> > > 
> > > 	o	An updater removes X, then calls synchronize_rcu(),
> > > 		which queues a wait element.
> > > 
> > > 	o	The grace period ends, awakening the updater, which
> > > 		frees X while the reader is still referencing it.
> > > 
> > > 	The reason that this is theoretical is that although the
> > > 	grace period has officially started, none of the CPUs are
> > > 	officially aware of this, and thus will have to assume that
> > > 	the RCU reader pre-dated the start of the grace period.
> > > 
> > > 	Except for kernels built with CONFIG_PROVE_RCU=y, which use the
> > > 	polled grace-period APIs, which can and do complain bitterly when
> > > 	this sequence of events occurs.  Not only that, there might be
> > > 	some future RCU grace-period mechanism that pulls this sequence
> > > 	of events from theory into practice.  This commit therefore
> > > 	also pulls the call to rcu_sr_normal_gp_init() to precede that
> > > 	to rcu_seq_start().
> > > 
> > > I will let you guys decide whether the call to rcu_sr_normal_gp_init()
> > > needs a comment, and, if so, what that comment should say.  ;-)
> > > 
> > 
> > Please see the updated patch below (next and rcu/dev branches are
> > updated too).
> 
> Works for me!
> 
> >               For the comment, I think we can add something like
> > 
> > 	/* 
> > 	 * A new wait segment must be started before gp_seq advanced, so
> > 	 * that previous gp waiters won't observe the new gp_seq.
> > 	 */
> > 
> > but I will let Ulad to decide ;-)
> 
> Over to you, Uladzislau!  ;-)
> 
Works for me! Sorry for late answer. I got a fever, therefore i reply not
in time.

--
Uladzislau Rezki
