Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B515CD4A;
	Mon, 27 Jan 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992586; cv=none; b=I6kWDY6AB6qZ0V6V1lFsk6xdcH0zdh8Fw8HWM0AOuhjgwtSv2uz2to6GjD/zYvxbdcXXdATv/f370IIaYbhvvuYDQTRo+xcEdm+1LzkNGOWZhbZVrERtFNjFonkmzoXhJz/elIK2BqKZs7UncCVhax5T9NYIEZzdwFaX3As+LGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992586; c=relaxed/simple;
	bh=TPKpo38lJCQahvc9spT4qmkzMLCNSPHfxlHNyhHtlDc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQMpfc5QK2Ya7o5HuoYCM2+OJQ7IlqiSjuyf2bh8PWHulafhie+F8NMP4iAq246Jj7wJFZyOhzATH1JbMDxBRWFlLd0DRD9scPY8l0hPNYwg89VyExZnZoFcTh3KPXeEFqHJ1r8kSDE9DYrt4ZVoYHwCBQX+Q0ZP9bvCyk8Paus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClcuHTqM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClcuHTqM"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3778bffdso5182243e87.0;
        Mon, 27 Jan 2025 07:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737992582; x=1738597382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkFq8O6/HlE8JX2FQx50UjZTsb0kd4R9PMtrePwiloQ=;
        b=ClcuHTqMy14ZaBRFR8ZlPs4UpHiLQUCUPxR6l2WAac9vshWimCFwqVuRliXX/xEGlB
         Ue+ysA2WjyXx+fXGhqTiIyWcqMfCwnI1aZwrEV5ljeO4HbbpQXe96FKqOAbWAVcnXj8l
         MJK4eg3PdoKmAyNse2z/8/uaUm/igBZDlctg/4kGEKyN0FlAAtR5tipobc3wqaifDoJ6
         wNnHLegVj9YCEeJa47wDtemv2cr1Up8ChxmSzx/NmtyxRU0feuO7l1yeVVxcRYn1uoSD
         BhpO5lTl+Km8OtplCq8/mKL+K8Xu8r3jywQ2pnH5DjnAqLx5F/JD+Txz+DjmXVtHRdrj
         ULBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992582; x=1738597382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkFq8O6/HlE8JX2FQx50UjZTsb0kd4R9PMtrePwiloQ=;
        b=FKUrjqf0zyfwHS+3aBfO15sIu9LupnxYmjFVcfGUjNILQTbspkZhwe43p8uPrpsDd1
         DuqO8kJnXmuA3k73YzLFT1Ll/RftrASlKfFCY7n6/yIVlllEYSqSrr6IsInerjZsgZmH
         SKwJvBSaVwIYKd6eURJKqn8X1NF3w/Vr8sSgLm8ndTrVlZOaifyLcz3Egu4hliRoffdl
         4+yXPvvyudkCdJNo+IUCay1A8QIin5pl/BEChVj21rYVham4ANKbi1B6MOzb9WCkS8dv
         LVrhRghgzmu4kMNDH9U3ug0/JOtffN3Wk1umJXFuH7+Mo3lxaPiIX8wapO0EdUGDidoj
         pH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL/z0R2kNzM0XPkz1yeFt2DJqe/oPrhCmvYHUsb5gGiWevM7PTAiDfCg3/5ZGHvbUcaLoeQS/IL5v00M8=@vger.kernel.org, AJvYcCXVpvZ2wI/C9kkYUjaMLvcrjU33vpOGnS7YVJGCz8EnfIyQUaL87YJ/2iftRzoF3eiDSvaL@vger.kernel.org
X-Gm-Message-State: AOJu0YzsR9Af3fRBEFSWkhfx5YnQiXFIUtddtdC/C34EN1OZ2GTnQfLO
	GWsWApr3fQbceeFLzfwFB90ShgdD5faYqh2ADyIolqO48LWHO/FW
X-Gm-Gg: ASbGncto1egtv3B6V+SxGOfPaXZkoiXdku0QqYQfDSH4dC6sfVXcZpE3JunsBg3FDER
	SG39IZVoSP+PwsjjXgmx2IJMkRBKXKZpqDqbEcUfBeT4MSBOzbh4KsHLw8BCTQ52ErKz1aziHtD
	s+P75JlBG9C20kP9iGku08PUwO4ROzQa4Y1NTPv3BbaWJvxXu/wQPhO26UhCwxuxadZNkGuG0/s
	VeNqkHxprnxnM7nEO5gZHHBhuT5mJ6bbFb3TPUeWdDWCspWvlMCSBW9RX1nrdDnNfZ4kaCc4/l/
	U+goCMdVY1n58rZXAagDbtbvu9QinCO3aFw=
X-Google-Smtp-Source: AGHT+IEZudu3+6hAT8N3PllP9pFZ5DvPuauWwSv3xc1jX+A0QjS7f4OmuTj1kwFdDctNqTqQNfKPvg==
X-Received: by 2002:a05:6512:ea7:b0:540:5b5c:c18d with SMTP id 2adb3069b0e04-5439c22a94dmr12465646e87.7.1737992581888;
        Mon, 27 Jan 2025 07:43:01 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8381754sm1325196e87.246.2025.01.27.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:43:01 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 16:42:58 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5epgkyeyAvTVOQg@pc636>
References: <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
 <Z5PMGlDb489VEZ7S@pc636>
 <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
 <Z5PSeEn_ceFuqbnz@pc636>
 <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
 <Z5eJ13aWwMDK00U1@pc636>
 <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>

On Mon, Jan 27, 2025 at 06:51:44AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 27, 2025 at 02:27:51PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 24, 2025 at 11:34:03AM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 24, 2025 at 06:48:40PM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Jan 24, 2025 at 09:36:07AM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> > > > > > On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > > > > > > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > > > > > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > > > > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > > > > This configuration specifies the maximum number of CPUs which
> > > > > > > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > > > > > > something higher.
> > > > > > > > > > 
> > > > > > > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > > > > > > the torture test on as many CPUs as many system has.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > > > 
> > > > > > > > > You should be able to override this on the kvm.sh command line by
> > > > > > > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > > > > > > For example, see the torture.sh querying the system's number of CPUs
> > > > > > > > > and then specifying it to a number of tests.
> > > > > > > > > 
> > > > > > > > > Or am I missing something here?
> > > > > > > > > 
> > > > > > > > It took me a while to understand what happens. Apparently there is this
> > > > > > > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > > > > > > you need to know about that. I have not expected that.
> > > > > > > > 
> > > > > > > > Therefore i removed it from the configuration because i have not found
> > > > > > > > a good explanation why we need. It is confusing instead :)
> > > > > > > 
> > > > > > > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > > > > > > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > > > > > > TREE05, won't each instance of TREE05 consume a full system, for a total
> > > > > > > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > > > > > > command line, but that would affect all the scenarios, not just TREE05.
> > > > > > > Including (say) TINY01, where I believe that it would cause kvm.sh
> > > > > > > to complain about a Kconfig conflict.
> > > > > > > 
> > > > > > > Hence me not being in favor of this change.  ;-)
> > > > > > > 
> > > > > > > Is there another way to make things work for both situations?
> > > > > > > 
> > > > > > OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> > > > > > need more CPUs for TREE05.
> > > > > > 
> > > > > > I will not resist, we just drop this patch :)
> > > > > 
> > > > > Thank you!
> > > > > 
> > > > > The bug you are chasing happens when a given synchonize_rcu() interacts
> > > > > with RCU readers, correct?
> > > > > 
> > > > Below one:
> > > > 
> > > > <snip>
> > > > /*
> > > >  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
> > > >  * delay between calls.
> > > >  */
> > > > static int
> > > > rcu_torture_fakewriter(void *arg)
> > > > {
> > > > ...
> > > > <snip>
> > > > 
> > > > > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > > > > interacts with rcu_torture_reader().  So my guess is that running
> > > > > many small TREE05 guest OSes would reproduce this bug more quickly.
> > > > > So instead of this:
> > > > > 
> > > > > 	--kconfig CONFIG_NR_CPUS=128
> > > > > 
> > > > > Do this:
> > > > > 
> > > > > 	--configs "16*TREE05"
> > > > > 
> > > > > Or maybe even this:
> > > > > 
> > > > > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> > > > Thanks for input.
> > > > 
> > > > > 
> > > > > Thoughts?
> > > > > 
> > > > If you mean below splat:
> > > 
> > > > 
> > > > i.e. with more nfakewriters.
> > > 
> > > Right, and large nfakewriters would help push the synchronize_rcu()
> > > wakeups off of the grace-period kthread.
> > > 
> > > > If you mean the one that has recently reported, i am not able to
> > > > reproduce it anyhow :)
> > > 
> > > Using larger numbers of smaller rcutorture guest OSes might help to
> > > reproduce it.  Maybe as small as three CPUs each.  ;-)
> > > 
> > OK. I will give a try this:
> > 
> > for (( i=0; i<$LOOPS; i++ )); do
> > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > 	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> > 	echo "Done $i"
> > done
> 
> Making each guest OS smaller needs "--kconfig CONFIG_NR_CPUS=4" (or
> whatever) as well, perhaps also increasing the "16*TREE05".
> 

By default we have NR_CPUS=8, we we discussed. Providing to kvm "--cpus 5"
parameter will just set number of CPUs for a VM to 5:

<snip>
...
[    0.060672] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=5, Nodes=1
...
<snip>

so, for my test i do not see why i need to set --kconfig CONFIG_NR_CPUS=4.

Am i missing something? :)

--
Uladzislau Rezki
