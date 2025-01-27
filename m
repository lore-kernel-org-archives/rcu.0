Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70517B50A;
	Mon, 27 Jan 2025 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005875; cv=none; b=LV9XQAb46MlmMQebDcK+8YAv9ibRNkaa/NZcz3YuGIOFSbjOlTG08MpDWM9vJ624O8KgRWpDTfIzs2gIRcvZX3XgP/QX4SYugcTC618Rh62TYgWwPpYjmA26FxhoH3a0JnoUlec+w4rG+u4rxieA7VBdvTgf+E/LCmqw5sLxNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005875; c=relaxed/simple;
	bh=mC7TTrpCsyJshbb7wJTtU44juiIgT0kxOxvdswiOQWs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2XJXsDlvwtyOCTlzxXFND0TlGXChvSWkymrD+mweLkZjbzt031Crl9WMA2JPQ6W5SkhYcBRkz6Li7C90KaTKpO7vcWpaKKPgrtfxGFjF9BGrJ1CQkl1QPmChriswF+jemKqe3yAbOb1WCgdgkAUCqidHzbWjYj8k5v/0r6JwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsKVcUkx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsKVcUkx"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-306007227d3so48395051fa.0;
        Mon, 27 Jan 2025 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738005871; x=1738610671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ez9m0ANZ1hsdJjGOAkY7UH4KdAbsQA0J7RPLrz+F/+0=;
        b=NsKVcUkxH1HaxiOBLYUr3X3lqjbqzbmRBMwkE9bQHK4BMd2GbHcr3FmP53ZM7A/xaA
         ABut5+041Pv9E+ITulDyMsU7tPZdINBQ4hVg7dYCUWf+C1nxHzGaaVKcNH41GCdDAQw9
         wuQZptXMOhyuDDCKgKpWhcr8lsYzPaxRjhUWUYMIuc1QCSYlMgtJirmA+k/4rF5w1aTB
         uRI+dUfSTHKWpgIbuemoPSD7sq5TLrWYb9u5DPvf9vGNu8et4KPM5Ch89vcSyBk/i/3s
         xOtbEC6j9y3J27DhkxuGRFjCZgKzOgqogOy6IYjXjI2XY5Jw9MMBmTBeBFpM+DWqumud
         oY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005871; x=1738610671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez9m0ANZ1hsdJjGOAkY7UH4KdAbsQA0J7RPLrz+F/+0=;
        b=GourxLTpMA7nfk3Tgv5dktdrissL9w4xvglztqeOvmYAH5wfmP8GZXx7MFhneFn6pf
         JeyLwEalYcwS1/iU8xHZUUYdOokHyaOhdIooaXveebmilJ28tVJZ3tgkT884vrNPEqq/
         P2S9OT8Ufe9KSZ1RJ5cYODDxFikbn7p0OFxZalrMUpQ73Ib22DDR7TE/R7DxksArQq8k
         o/obcIzIiG/yGcPuaunL8WphHB71VnpwKqWPM4jM3oW4UMsycNqGQq40vMCiwa1Y02jc
         GgCOU0tNxgH8eGAksRG4SaKy7VoVb++ISbA2puBrnB1PtJKCJx2EXXRqR3Y/ASgL6aIu
         0OBg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPxYmqm9irSDDsJ5VcyD5Ct3O4BlwVMpduYX5z4ajO+7TZSmWs4Wjnz7GK0DyOYgFIX7WqLzxi8/inew=@vger.kernel.org, AJvYcCW3fIUqGMlRwOyktctQVBKjEH8nwbAH2MTkkzOe/2nCGkKqJCy/owtG1/b3lxJM5oSoCbcK@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLV98IFCSQimo6kFFsIDWfrIZyFLtrX1zlg3iSsjaBx3QqPEs
	Jw+uCYT7djH1mo7DTiYd7h9Gt/gM7f7P/miO3iGtk+tkVAHt8pKS
X-Gm-Gg: ASbGncsqj4GTmjUmvpi0qvNed5pxYfotVqknAnstcfCpDS960XnpXLV3DGx1tRIetKn
	3Vz0tbKpVIgvqJ1mtTDvIIPvGOzvfrIsHvmwt0TeuRSL9Ra5lHdRxcoKY7d8MfOtwArLItjlhA7
	nDPhXr53ByNbF/6VKH6s4c5kYSnH9wwmGc3VLMTBNbUUh06Se1S3ijdW9vOgjMxfCNg0yxHiEej
	PJuU/6MzZ03HV2o63Hs/dtdzs0IOHtfEym0fgEi8YhIgn4=
X-Google-Smtp-Source: AGHT+IGKt2DUgYdKwTt4Tlb/wLWk6WIked/dSKSXdnX5sVRF8YLuvtaVj74LZlFQrm7jHvDrm/c2iw==
X-Received: by 2002:a05:651c:b0e:b0:2ff:df01:2b43 with SMTP id 38308e7fff4ca-3072ca9abd3mr193079061fa.18.1738005869352;
        Mon, 27 Jan 2025 11:24:29 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bacbb93sm15511131fa.37.2025.01.27.11.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:24:28 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 20:24:26 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5fdaj2HnhpagC-A@pc636>
References: <Z5PMGlDb489VEZ7S@pc636>
 <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
 <Z5PSeEn_ceFuqbnz@pc636>
 <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
 <Z5eJ13aWwMDK00U1@pc636>
 <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
 <Z5epgkyeyAvTVOQg@pc636>
 <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
 <Z5fB4xTWD7PWmVXq@pc636>
 <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>

On Mon, Jan 27, 2025 at 10:15:21AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 27, 2025 at 06:26:59PM +0100, Uladzislau Rezki wrote:
> > On Mon, Jan 27, 2025 at 08:51:01AM -0800, Paul E. McKenney wrote:
> > > On Mon, Jan 27, 2025 at 04:42:58PM +0100, Uladzislau Rezki wrote:
> > > > On Mon, Jan 27, 2025 at 06:51:44AM -0800, Paul E. McKenney wrote:
> > > > > On Mon, Jan 27, 2025 at 02:27:51PM +0100, Uladzislau Rezki wrote:
> > > > > > On Fri, Jan 24, 2025 at 11:34:03AM -0800, Paul E. McKenney wrote:
> > > > > > > On Fri, Jan 24, 2025 at 06:48:40PM +0100, Uladzislau Rezki wrote:
> > > > > > > > On Fri, Jan 24, 2025 at 09:36:07AM -0800, Paul E. McKenney wrote:
> > > > > > > > > On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> > > > > > > > > > On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > > > > > > > > > > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > > > > > > > > > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > > > > > > > > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > > > > > > > > This configuration specifies the maximum number of CPUs which
> > > > > > > > > > > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > > > > > > > > > > something higher.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > > > > > > > > > > the torture test on as many CPUs as many system has.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > > > > > > > 
> > > > > > > > > > > > > You should be able to override this on the kvm.sh command line by
> > > > > > > > > > > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > > > > > > > > > > For example, see the torture.sh querying the system's number of CPUs
> > > > > > > > > > > > > and then specifying it to a number of tests.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Or am I missing something here?
> > > > > > > > > > > > > 
> > > > > > > > > > > > It took me a while to understand what happens. Apparently there is this
> > > > > > > > > > > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > > > > > > > > > > you need to know about that. I have not expected that.
> > > > > > > > > > > > 
> > > > > > > > > > > > Therefore i removed it from the configuration because i have not found
> > > > > > > > > > > > a good explanation why we need. It is confusing instead :)
> > > > > > > > > > > 
> > > > > > > > > > > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > > > > > > > > > > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > > > > > > > > > > TREE05, won't each instance of TREE05 consume a full system, for a total
> > > > > > > > > > > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > > > > > > > > > > command line, but that would affect all the scenarios, not just TREE05.
> > > > > > > > > > > Including (say) TINY01, where I believe that it would cause kvm.sh
> > > > > > > > > > > to complain about a Kconfig conflict.
> > > > > > > > > > > 
> > > > > > > > > > > Hence me not being in favor of this change.  ;-)
> > > > > > > > > > > 
> > > > > > > > > > > Is there another way to make things work for both situations?
> > > > > > > > > > > 
> > > > > > > > > > OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> > > > > > > > > > need more CPUs for TREE05.
> > > > > > > > > > 
> > > > > > > > > > I will not resist, we just drop this patch :)
> > > > > > > > > 
> > > > > > > > > Thank you!
> > > > > > > > > 
> > > > > > > > > The bug you are chasing happens when a given synchonize_rcu() interacts
> > > > > > > > > with RCU readers, correct?
> > > > > > > > > 
> > > > > > > > Below one:
> > > > > > > > 
> > > > > > > > <snip>
> > > > > > > > /*
> > > > > > > >  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
> > > > > > > >  * delay between calls.
> > > > > > > >  */
> > > > > > > > static int
> > > > > > > > rcu_torture_fakewriter(void *arg)
> > > > > > > > {
> > > > > > > > ...
> > > > > > > > <snip>
> > > > > > > > 
> > > > > > > > > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > > > > > > > > interacts with rcu_torture_reader().  So my guess is that running
> > > > > > > > > many small TREE05 guest OSes would reproduce this bug more quickly.
> > > > > > > > > So instead of this:
> > > > > > > > > 
> > > > > > > > > 	--kconfig CONFIG_NR_CPUS=128
> > > > > > > > > 
> > > > > > > > > Do this:
> > > > > > > > > 
> > > > > > > > > 	--configs "16*TREE05"
> > > > > > > > > 
> > > > > > > > > Or maybe even this:
> > > > > > > > > 
> > > > > > > > > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> > > > > > > > Thanks for input.
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Thoughts?
> > > > > > > > > 
> > > > > > > > If you mean below splat:
> > > > > > > 
> > > > > > > > 
> > > > > > > > i.e. with more nfakewriters.
> > > > > > > 
> > > > > > > Right, and large nfakewriters would help push the synchronize_rcu()
> > > > > > > wakeups off of the grace-period kthread.
> > > > > > > 
> > > > > > > > If you mean the one that has recently reported, i am not able to
> > > > > > > > reproduce it anyhow :)
> > > > > > > 
> > > > > > > Using larger numbers of smaller rcutorture guest OSes might help to
> > > > > > > reproduce it.  Maybe as small as three CPUs each.  ;-)
> > > > > > > 
> > > > > > OK. I will give a try this:
> > > > > > 
> > > > > > for (( i=0; i<$LOOPS; i++ )); do
> > > > > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > > > > > 	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> > > > > > 	echo "Done $i"
> > > > > > done
> > > > > 
> > > > > Making each guest OS smaller needs "--kconfig CONFIG_NR_CPUS=4" (or
> > > > > whatever) as well, perhaps also increasing the "16*TREE05".
> > > > > 
> > > > 
> > > > By default we have NR_CPUS=8, we we discussed. Providing to kvm "--cpus 5"
> > > > parameter will just set number of CPUs for a VM to 5:
> > > > 
> > > > <snip>
> > > > ...
> > > > [    0.060672] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=5, Nodes=1
> > > > ...
> > > > <snip>
> > > > 
> > > > so, for my test i do not see why i need to set --kconfig CONFIG_NR_CPUS=4.
> > > > 
> > > > Am i missing something? :)
> > > 
> > > Because that gets you more guest OSes running on your system, each with
> > > one RCU-update kthread that is being checked by RCU reader kthreads.
> > > Therefore, it might double the rate at which you are able to reproduce
> > > this issue.
> > > 
> > You mean that setting --kconfig CONFIG_NR_CPUS=4 and 16*TREE05 will run
> > 4 separate KVM instances?
> 
> Almost but not quite.
> 
> I am assuming that you have a system with a multiple of eight CPUs.
> 
> If so, and assuming that Cheung's bug is an interaction between a fast
> synchronize_rcu() grace period and a reader task that this grace period
> is waiting on, having more and smaller guest OSes might make the problem
> happen faster.  So instead of your:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> 
> You might be able to double the number of reproductions of the bug
> per unit time by instead using:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> '32*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
> --kconfig "CONFIG_NR_CPUS=4"
> 
> Does that seem reasonable to you?
>
It only runs one instance for me:

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs 32*TREE05 --memory 10G --bootargs rcutorture.fwd_progress=1 --kconfig CONFIG_NR_CPUS=4
----Start batch 1: Mon Jan 27 08:20:17 PM CET 2025
TREE05 4: Starting build. Mon Jan 27 08:20:17 PM CET 2025
TREE05 4: Waiting for build to complete. Mon Jan 27 08:20:17 PM CET 2025
TREE05 4: Build complete. Mon Jan 27 08:21:26 PM CET 2025
---- TREE05 4: Kernel present. Mon Jan 27 08:21:26 PM CET 2025
---- Starting kernels. Mon Jan 27 08:21:26 PM CET 2025

with 4 CPUs inside VM :)

--
Uladzislau Rezki
