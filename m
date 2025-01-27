Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2025A63B;
	Mon, 27 Jan 2025 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002710; cv=none; b=tmjQbUyRP27qjsze3SWFC5y0LDgP3jvEI9foJHMsRYM4zzhU2Z/T6/6EAtLCOyp5ldUf4IQIVySXZpeOk/Sc+YgVC6CsQp7sXPhx9giUWE4Wme9IXKQZN2LomYQPrHRN0CiTO9PRDm0L5CapOgXxBWY0ynFnz4L5H9pYKmZLiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002710; c=relaxed/simple;
	bh=4MurIzubynaIUHUqIf74FZOwHkDyb6HTWfD3rGkunLg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CApq3l4cM2kPm8Jgs03UKA61xfTKdQTPJWaVfWRRjUtKIm/MexOr33CYAeXp2RPx8W9fvD6BpqdkuJaXgWlpW+rKNqYXPibSaCbLGWFv+7gaJlHBy6p3qgr7uG7pFGcJTTYtCxaujgSjSlEwJNE3sReNm5FmHo/BzYCF7unjQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbRiEJ6F; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbRiEJ6F"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30737db1ab1so43758181fa.1;
        Mon, 27 Jan 2025 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738002706; x=1738607506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2QA4xnSiO2r3x6IRPwW1APZKTeIga0MpAz8KLGeahg=;
        b=HbRiEJ6Fg1yUUpSL3Ok9YIXTrW8Xch8keNqKPA3eoQgaoYWIbXKv0N2CwvfWCZLR6n
         IEkRWyhuNy6yzUjlSZneDokyxzboaaGlobLIH53Fl9357DZvaZY7YrJ0H7iEHA72q2I9
         hJkgWtYJ0cySFMMPWrCXHVuEqKXttb6MflFpfkbUtHHQmhQU7+5aeOgii6pTFUtRxmmO
         IP3E+3BOAnswQFOOdOAMhQopSXY8gnQuyF5xamABgk1xQjo2PLyVTpqp0n5ucwQVe3uq
         qFgww9X3Qy89TBFXa0g+KBsKSpirafa616lysBif+ZRVCuBH1d6VmL0QbRIjf76RwgLe
         aN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738002706; x=1738607506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2QA4xnSiO2r3x6IRPwW1APZKTeIga0MpAz8KLGeahg=;
        b=KnuWiaDJz7hlbCwe/r9MAA3+dw/HrdwQu5SkxhvTObiZ6fKk/9m2+Bvs9kdEVvWMT8
         xS1lfbTFnRZGhnyxNkFFGytwteOLUq+UmfD+peR30C6ekZ+gE13cXFMY3VI157iB+fmf
         XmS1TZ5aLHAm83vjhfK7yvJQjtQxGKvFgRDk0vVYvt22/EZ3g2aGlJP22Unf7tlFIG8W
         MGFL4NYNxipVEkA3lfqUHPWU+XW7gHFA6Tf6dJbFe7DOyN4ANL+/Vq7+zgcO8F1MWvyl
         SoClT5fzqZngHg0gR/nZGAq4OszpE0RWpNhyNfwgMcEsSHPtgvqUEzt8S+6dGa6PLXnZ
         dJXA==
X-Forwarded-Encrypted: i=1; AJvYcCURA9pVKrhZxsmHLgn3AaTV5sW8871QbiYu7precYlZfd66AxVQg9VuUHcDOdU/d7bh4oui@vger.kernel.org, AJvYcCUbkRl7kC1DA7X1n7zLH9g2KEkUMXVz18mQ865A7PDF52LmevyrtDeOHcNyuvkgU+p4uUSWb+ne5Jp/tWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wOUFXxXZDS6RBQzMIoPKuUUE78e/B156DqDqDb9Z6+HFOqLj
	8UGhkvDxeA9LevHgEFHRsgIRIXL/Eri7J10TBelRsg6W44bQIiWl
X-Gm-Gg: ASbGncu1YjvUIxky79V0e0TmJ+AiBd9xqntbGVK7nvflLOZqHJqdgUTbh3fMSU63azp
	iBjGaturlBrh2dBAjwsdV2JprNAaFu1AiYabMfis+f99w5ygG28OLdq8pls5Gwmkn24Z6IX/j4x
	HJFYxiY6xwDnPFRas0N2DNct9PqUvfdnnbsc1jvxjnccoxqTsb42+TAcN8yuFMWKXi82w/JddeT
	hwWHSV++J0+9R0X3Pcf2Bcd4KmOwlfpLe3WygdoKq/z5dpBEXWWY69rQTsBWHrjP+4j2jyB6OgH
	HwHk3V65aiUM3glljFknfVcJ3GYI6DfQ
X-Google-Smtp-Source: AGHT+IHTKg3ob26lZbRe19QIV3ddtew3yxBa3WcQSrQLjy7NvPL2729IJAStZXRON5Fm95AaHF2ciw==
X-Received: by 2002:ac2:5df8:0:b0:540:1f7d:8bce with SMTP id 2adb3069b0e04-5439c2805a2mr11029333e87.38.1738002705933;
        Mon, 27 Jan 2025 10:31:45 -0800 (PST)
Received: from pc636 (host-95-203-24-189.mobileonline.telia.com. [95.203.24.189])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076ba6b02bsm15615741fa.12.2025.01.27.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 10:31:45 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 19:31:43 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5fRDwS69qBJycZj@pc636>
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
I was confused by the: how CONFIG_NR_CPUS can influence on number of
instances kvm.sh runs.

It is obvious, that as much parallel setups you run as faster you can
reproduce it. Of course if there are enough resources a system runs the
test.

--
Uladzislau Rezki
