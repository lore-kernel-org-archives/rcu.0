Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15652702B7;
	Fri, 28 Feb 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762509; cv=none; b=c+EPl503pbZ8xtdjM8B+bcCYNTEFGMXwn2QPgalJq2xrp28JUYF6yJ/j/+w4tO+zZZASajNUcb3dunyLPxVdh9Z8MqlbSrU/Eywg0yrGhpK0H9+A4w3TSq4KhjECEeKaDwJDQs0ODOHJPUzqj5PF7kW9IckkKZrf+2c/pVXtvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762509; c=relaxed/simple;
	bh=ACLIb+NpgbqVY+xntMyy9aeID2FvN87OO3Glwq+E6Ng=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKU8f3PkC2k8o3bKCs+G+xhR/pfN4RU4s61y5RXGDaRidjtTQGhxgTsvFla0If/0AUFgNZfZAQSmuY+tDqoddCIIPLSvNJ+DxUS4O9gjgvlW/at9sIjxBpZGpP7xozgIDu/2XvemlwiC87D44cIjdhzH3QxOPdkQit75d2CzmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7KzhAzZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7KzhAzZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549490e290dso1235094e87.2;
        Fri, 28 Feb 2025 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762506; x=1741367306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7ixW3KngAXUUODkP5bWrBi2H7GkNF4vIVUuhitUtD0=;
        b=G7KzhAzZoO+qzDH5wTllxnvsDP3bfzUPd0Rkm2hG3tbQyqjMZM2DaeOFra+4X3LoF4
         0u0geonRBJ+5SpaqxGMrlZRNeenRKFKYd8j5BAVbbtqzDNE7TEVSTIF3CoZbje/rAwC8
         MXbmLXFc8PPmOzBOw0ONUPtZZ8dJ8ypC7zQN7jruOLBIwXOb9ddx5MCpeRo16lINlW0f
         NnWUfKEtBtr/3o18FQcsxeEhz1mi/N2vFVUBwWcmAjGe7jGhLgweZppHC83SduR4JIuq
         tC2eEUBB2E0GyeeZQBw/IzhGezzpiTb33qTd/qy5s2ipWTFgG0L/eS1cOov4CDqp7YyN
         qyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762506; x=1741367306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7ixW3KngAXUUODkP5bWrBi2H7GkNF4vIVUuhitUtD0=;
        b=B42mn80B9LSwQWNFconTGEpHC1uW5qR5C5TSOLoLMEx+uJa8Dstfr2j1bDH7IRUdma
         IpDnPaa8uy7XEuLerxmKykNut5+HVaN+KlwEvZ0Djk+Me4coSPKFAc09VYGJFgDgs3kG
         1qYL5q856tmri/aCwJLg13jNMklCzH+9FUBJ4deYHXckx73LcKeIXPp1M3N0NsayJ0RY
         34VOoZ4OXvMQlwZxWPcGKR5JB02vuSQj5EuUbtkX7zbM5jrKrLJycfkLAyqG49LZV8V7
         GnUA4mdEU+dXPiURgkQjRS+c+gBmDpmQzuhmtvifGQZm0GPTM3qK2pn/TbOW24PUzoTE
         e53Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCaLejDI3BBu0IUJ1F8Kzlo9yH0clhVHIx7ylBrO8H7foWTw5VuJHw35HV2VxWQvgiewvt@vger.kernel.org, AJvYcCVCcM4gIpXpRF8xHmlRPl5IoERJnRohdlAEEWRLVYuOCWfwTAFBmBtacYLMnn8h8mDOmVnNxhC7vPJ1n2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJrnCziQX4g9nNeUolysDNEMakmtJq3SWN4IsWOjgdBYn9lO+Y
	xXoyLZ9ka5A/N/qTA8ZpXZaUKVJHgC6APnUwu+0qD1lJdsvgcFU/
X-Gm-Gg: ASbGnctA0ga7Z5R/VuGnfkJGDiGjqNB0AIdJzEQrobDSZvwVSss30R5h5m2FKEP36Pc
	4/BxoB78GhHc/mh2Ds8MkdGPHs7YpsENFSddJB+gIw8zi5fnlhfIaaxBzkcyB+i7aOyDpHX2MAf
	YhRskoZ2YS0KedfXvHLvWMMNBBJS2hvlgnCDo6/J5TB/1DP+0SzKdQD/NN+p+U0u+7pZa6hJ99D
	/OPjG60PxV4sKlO9JPDK+OUqm2XhPkK0Nczrjgsj6EXGRqx3kqFzplj7Ejf8U9KAoIBLvPKmGws
	1MZlPTG4l1+VLDMQjaNgXRjJDg8kYWntANz9ckk587HFTOl6
X-Google-Smtp-Source: AGHT+IEWJRE9/GZRX0rFDqRJY2PucanY7TwDXd/Q/ExQJY3euuAmZjdhuOnPKOeYtssXkgRqoOYhUg==
X-Received: by 2002:ac2:4e14:0:b0:545:2c40:ec1d with SMTP id 2adb3069b0e04-5494c3550damr1882701e87.44.1740762503919;
        Fri, 28 Feb 2025 09:08:23 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cb00dsm552848e87.211.2025.02.28.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:08:23 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 28 Feb 2025 18:08:19 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8Htg565HnNumdxy@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8HmH85bYNU8enJ2@pc636>

On Fri, Feb 28, 2025 at 05:36:47PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 28, 2025 at 07:41:40AM -0800, Paul E. McKenney wrote:
> > On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > > > Hi Ulad,
> > > > > 
> > > > > I put these three patches into next (and misc.2025.02.27a) for some
> > > > > testing, hopefully it all goes well and they can make it v6.15.
> > > > > 
> > > > > A few tag changed below:
> > > > > 
> > > > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > > > synchronize_rcu() call.
> > > > > > 
> > > > > > Just using "not" full APIs to identify if a grace period is
> > > > > > passed or not might lead to a false-positive kernel splat.
> > > > > > 
> > > > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > > > both normal and expedited states into one single unsigned long
> > > > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > > > run.
> > > > > > 
> > > > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > > > for expedited and normal states.
> > > > > > 
> > > > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > > > 
> > > > > I switch this into "Closes:" per checkpatch.
> > > > > 
> > > > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > 
> > > > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > > > Would you or Paul double-check the Reviewed-by should be here?
> > > > 
> > > > I am good with keeping my Reviewed-by tags.
> > > > 
> > > Thanks Paul!
> > 
> > Except that I got this from overnight testing of rcu/dev on the shared
> > RCU tree:
> > 
> > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > 
> > I see this only on TREE05.  Which should not be too surprising, given
> > that this is the scenario that tests it.  It happened within five minutes
> > on all 14 of the TREE05 runs.
> > 
> Hm.. This is not fun. I tested this on my system and i did not manage to
> trigger this whereas you do. Something is wrong.
>
We have below code to start a new GP, if we detect that processing is
starved:

<snip>
/*
 * The "start_new_poll" is set to true, only when this GP is not able
 * to handle anything and there are outstanding users. It happens when
 * the rcu_sr_normal_gp_init() function was not able to insert a dummy
 * separator to the llist, because there were no left any dummy-nodes.
 *
 * Number of dummy-nodes is fixed, it could be that we are run out of
 * them, if so we start a new pool request to repeat a try. It is rare
 * and it means that a system is doing a slow processing of callbacks.
 */
  if (start_new_poll)
    (void) start_poll_synchronize_rcu();
<snip>

we do not use a _full() version, since we need to inform rcu-gp-kthread
to initiate a new GP.

Any thoughts?

--
Uladzislau Rezki
