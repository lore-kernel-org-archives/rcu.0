Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCB208A9;
	Sun,  2 Mar 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740910791; cv=none; b=g0H+BSj1o3PmSTepQk2Pp2zQj6Id0aWNPnpnNA3+c9N+ih7IVMHvOduBMwrUWv+VljduOR3rN9DpMzlN3quiFAuepxaXc8ZNlDGET3eZrYc+y/NnA09zpLrXXvSXu+8KtX00Br9/2xLvTtx6ZPg2MGtPTr7fqy1NrA4eAGsptsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740910791; c=relaxed/simple;
	bh=YAeeZnvz1NJO9OAU5tjC2KBFIFDuxn96gYPuwegv1zY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYWbTjOwtB7Awaunk5er/22zDjcmH4OOfHVROX+O8+JFfO3YLq0CjBkKMSm62BJExR/362Mja+uHWFQgSG/KUXuTJVovs99/R0Nu5JfmMdlyPAKDoRgDOFjaf0axPnH9mtauRVs5gp3vyO0dCiVd/SdN8WljfBdY9lIPB3o5StQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC5X81FY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC5X81FY"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30918c29da2so34873181fa.0;
        Sun, 02 Mar 2025 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740910788; x=1741515588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDow4HpevkJEBaD+G8HUmKQolL98G4+tlymNV1q5jHI=;
        b=jC5X81FY0YCamgh2F53UvAsbie+0Wbn7xWd/dpi+JjvrymNu9dqf1QzV0pkyYDYTjO
         iIeTXTcTdVxCclGgc0z7GoNA2FUTmTwMDTouAi+y30aqzWRe0mFryzhMlkgqa1cV/APO
         yWC4yHlRe1WzRPiGp4Hep9+WS0dSFHPZ7pDJ1rHcyMC0DFfj8ZtpHSyPF4608EyH/z75
         rZMp2F2GaY0s8dw0jTfoqxqBpMYSML3qnGCEkQCA105HFbW+kTGeYY7EacZbyA8waWVI
         tB2VRz4fVxJuslf8bXd/lVn+4wC7avZYNpFAGdo1CuMfK70NzMAUHw1k4ZZf1cSWBdEA
         bB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740910788; x=1741515588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDow4HpevkJEBaD+G8HUmKQolL98G4+tlymNV1q5jHI=;
        b=rE/mPPvBZIuC8hIuJ3HM10qlgsbmW8qR+X6U5thr/fNl7J4tXIHmR7YRY+wyXyCC8a
         KpXj7IxUgNdCU9bQ5909TwXBdUIZ+NqYUE3Ke288cXk/Vgn1o+0Mpr86mYTq+DA4Ci91
         vYK6n/FpdsRSwhGoLv1v0IsuYYEob7Qk4EhJ+ZUFeaF5jl6G5qttLiFBa0m5F13SLaRM
         N22QPBP/LB7O93kzyGXmqJn6ZZb0+Xc5Bc0Mlum5r/hucWSO5luuyD1tjsMIRdZk7j29
         RXIwCRAxzjnbZ/Qx08/A68uzJYMz9A2wEVwTHHsqgmhp+ob21SCph7oyZuCRP428z2MC
         ifUw==
X-Forwarded-Encrypted: i=1; AJvYcCU53Mo+F6+f1T4eIujWarxJ5w9y70nYHZfLVHP/ZxbgkHoYnjMU4xWJv+YF5gu6Y4pNwbN5/eviqrE9M04=@vger.kernel.org, AJvYcCWDnM2IamB/qs/Qyd/rvoRvYnIuaLpPGjB1pl2VAQ0ryIJcq5OyFfrQHaRzg7twDbi/ZXB9@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOFINekXxd/Jd98RXuZ8b1dACZsjv4qD+Ina49fxS8W61gin5
	SKyVZNgjmJX1Myu/bNpYc5sTNZMOzZVolB71bXG9bYoYx1RvlKNe
X-Gm-Gg: ASbGncve27QbJ2VHMu1nBQJ5aLfWOFKHdx8SbNENcYtkBdkqMW5/QNUg6GVfCDIIhEv
	gkUk+sPpX4SqWjSUiU9Sbd+yOxBvgKQKuftCa9w7kDBw8Chic+6kmZcM5kepEv0Lx/JZLzXSTpp
	9zfxt00H2kIeEUNT1NSdZfGiVumrig8FeLqWrVoc/k+GECcIsGnukpoaMvg+3ZI+cN7g/W4alGt
	kZNSe+CWpKeX21xvGtWFwnlcruBWVlwlKua6pEFKH5QRCwqpzTNy3IrzwAFQRh4Z1vyHq3WOpw5
	EIvl3TjgeWk=
X-Google-Smtp-Source: AGHT+IEVstJsgvnpgan61935F4dKHTxndzwJCMvSlv9ghggmb+cGc6yah5wydn7sMEk8xLLqIWJcQg==
X-Received: by 2002:a05:651c:512:b0:307:2b3e:a4a9 with SMTP id 38308e7fff4ca-30b932532eamr43337591fa.20.1740910787254;
        Sun, 02 Mar 2025 02:19:47 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867ca129sm10189521fa.64.2025.03.02.02.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 02:19:46 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 2 Mar 2025 11:19:44 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8QwwBCoWb4J3_Xv@pc636>
References: <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>

On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > Hello, Paul!
> > > 
> > > > > > > > 
> > > > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > > > RCU tree:
> > > > > > > > 
> > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > > > 
> > > > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > 
> > > > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > 
> > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > 
> > > > > I can trigger it. But.
> > > > > 
> > > > > Some background. I tested those patches during many hours on the stable
> > > > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > > > right away.
> > > > 
> > > > Bisection?  (Hey, you knew that was coming!)
> > > > 
> > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> > > 
> > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > 
> > Huh.  We sure don't get to revert that one...
> > 
> > Do we have a problem with the ordering in rcu_gp_init() between the calls
> > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
> > do we need to capture the relevant portion of the list before the call
> > to rcu_seq_start(), and do the grace-period-start work afterwards?
> 
> I tried moving the call to rcu_sr_normal_gp_init() before the call to
> rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> Which does not necessarily mean that this is the correct fix, but I
> figured that it might at least provide food for thought.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 48384fa2eaeb8..d3efeff7740e7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
>  
>  	/* Advance to a new grace period and initialize state. */
>  	record_gp_stall_check_time();
> +	start_new_poll = rcu_sr_normal_gp_init();
>  	/* Record GP times before starting GP, hence rcu_seq_start(). */
>  	rcu_seq_start(&rcu_state.gp_seq);
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> -	start_new_poll = rcu_sr_normal_gp_init();
>  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
>  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
>  	raw_spin_unlock_irq_rcu_node(rnp);
>
Running this 24 hours already. TREE05 * 16 scenario. I do not see any
warnings yet. There is a race, indeed. The gp_seq is moved forward,
wheres clients can still come until rcu_sr_normal_gp_init() places a
dummy-wait-head for this GP.

Thank you for testing Paul and looking to this :)

--
Uladzislau Rezki


