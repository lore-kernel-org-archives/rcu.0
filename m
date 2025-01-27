Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69A1487F8;
	Mon, 27 Jan 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998827; cv=none; b=WsUgNPxQ1EuzV2YfPH0LrWia579XvEyYezx5YkLuMc+6LEP0lZbLuHxwaJVcHZrW/zADULeGit4n4sk1fH9XxZJ/6OcIeHz78/ec/sjuLX+h54UPd/pMVo7Dh85GzIxmsiIjPJcSBTlLpuWa7c0UnYAlHy/qmy3VX55cnbp51zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998827; c=relaxed/simple;
	bh=tcwx+4I66TCTnZhpIOkwB8JX7+VEOEjS0PEiYuSDa2c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ublnl+zD+AM8aSBknoIVq9JXpVVpiw5nCDp7GfvbVAEG9fJage6dPY5EXtUJkZE7iJypJr5psIa8XKLXmjfuxMLRxQcDpgiEWvsb1zI1YB71rDadieJTkRkrcK0splYP/wADDrnT/twIUR7DwarbexhKADSJ2sBMi5ke5nCcNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/4dnyxi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/4dnyxi"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5401e6efffcso5145021e87.3;
        Mon, 27 Jan 2025 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737998823; x=1738603623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MHjbOL5Lv4KMF6+AGOYgNKv10Kcp0EwvPAGl3Mi9ebU=;
        b=N/4dnyxiRXdT6R3REVPIX4vPlb+vU5SX9fjRXHjT5sWOvPmWCSrgl0MiTPgGCaEdaA
         citPbRIn+NfQLFRtH5gu2T2GUTz9sXqmEQvbMO9eTtDoJdm63CfmG9JNcvcnK9ll1ck7
         8EMQTEo1EfgJgu1om9pBfuTdUjoXeXKw6/itHPfwMFC0xm2Ghk6gTt/WHtJ9L/iLBRQL
         3BtBPyQ4AvXJ05U/vqF7Y1NOITM82ctmMi5cEWjMWFOWS+ZE4pveZB+UmKUVxlkJGAAE
         w2LRDlFBo7jLowK7WFzXmYPDCcg0TFVf3GIdzurPYN8ng88lubK904N/PO1ikwazXJzX
         Rm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737998823; x=1738603623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHjbOL5Lv4KMF6+AGOYgNKv10Kcp0EwvPAGl3Mi9ebU=;
        b=L+nhPbiWQC6BzhaR3/m8CaAPFxANabySXXC24vMNdzt6UkYa3EfMnIy/tykzkWn7SI
         ko27FVOqcIJ5EXC+/4VAf/1Q2rrU0rh4stYOAnlVT9PtaF49NsJWeolXRdguAhuGc1T8
         B7z+34HkzGTR3HP03lt/Ycs9tn00yeAl5TBzrOqf7pmpyZ7b7y0rVvaF/tt+W0qNNQX+
         FNybS8X+iyO2KHXiaRK+kJIOhg1vM5YNJWTmpLUy2CLtvpP0B0f9U3BL8/f1n4BLkyol
         orRlawvDT7Cc0jYVVo8AhGzZ4H7JrnO2aWDkxL1feEhI7bUmHDFT4PbolwRPJ4578ovs
         JzSg==
X-Forwarded-Encrypted: i=1; AJvYcCVXQoUagCU+4L42gVK3IuebQLef5lMjBo862oPVBln6CJwSchL/pR1gIw6dHE9Rb7/qW+HSV3kcIRT8X2U=@vger.kernel.org, AJvYcCWCDhP9ixO9fKPiWqgtVKAwewLsrj5X7huuzqjFc/YgIiYAErcPFFH1ohKp7xbXWb9XTfWc@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUF4yXOJCIi+0JNckn+4t+84cZIZa1DykMVdRMuhKdsJLF/b/
	8PVmYHNOACkp2l1mndtQNXjGEUv421eS49Co+z5Y1RGvxrAaHKim
X-Gm-Gg: ASbGncuGCGyiXo2o/HO7WrU8N54ZESoRVLX2+MnqBPaxG+Yy7m72vCCR/ywaws1zv9t
	PkVUWQyUy65mOv9oXRNYImuj0O8Pgo3tN91MA7IuLGh6T24SR/i/IrZ8K/s26tY2jKaFdtbYBXG
	rB3VFxFrbXRdvZlfV8Z5gyfk4IsK+sBo2ZuvV5b/7e5utgCVOjtJhG5vNRxLOLGNgxHJWXmEn7F
	SVFowrx7FsSys6e1cv7mj9kDV+CBlP6PG++LpOauCnJylpukzAn4XqivVw/ts7+VK/E76zp+MjB
	WlDmQ/+k6U2ytso5vOJO7wrXb/RckTK6
X-Google-Smtp-Source: AGHT+IEKXq7x+OUjbZ/6PDHTt40SBWyZmfZ1udlNQJoeBPK8fISAl+ENDq9UY/SJjkfUc2byiJV4VQ==
X-Received: by 2002:ac2:4570:0:b0:540:2542:d89a with SMTP id 2adb3069b0e04-5439c288152mr12749459e87.52.1737998822877;
        Mon, 27 Jan 2025 09:27:02 -0800 (PST)
Received: from pc636 (host-95-203-24-189.mobileonline.telia.com. [95.203.24.189])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368362sm1344861e87.124.2025.01.27.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:27:02 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 18:26:59 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5fB4xTWD7PWmVXq@pc636>
References: <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
 <Z5PMGlDb489VEZ7S@pc636>
 <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
 <Z5PSeEn_ceFuqbnz@pc636>
 <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
 <Z5eJ13aWwMDK00U1@pc636>
 <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
 <Z5epgkyeyAvTVOQg@pc636>
 <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>

On Mon, Jan 27, 2025 at 08:51:01AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 27, 2025 at 04:42:58PM +0100, Uladzislau Rezki wrote:
> > On Mon, Jan 27, 2025 at 06:51:44AM -0800, Paul E. McKenney wrote:
> > > On Mon, Jan 27, 2025 at 02:27:51PM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Jan 24, 2025 at 11:34:03AM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Jan 24, 2025 at 06:48:40PM +0100, Uladzislau Rezki wrote:
> > > > > > On Fri, Jan 24, 2025 at 09:36:07AM -0800, Paul E. McKenney wrote:
> > > > > > > On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> > > > > > > > On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > > > > > > > > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > > > > > > > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > > > > > > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > > > > > > This configuration specifies the maximum number of CPUs which
> > > > > > > > > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > > > > > > > > something higher.
> > > > > > > > > > > > 
> > > > > > > > > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > > > > > > > > the torture test on as many CPUs as many system has.
> > > > > > > > > > > > 
> > > > > > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > > > > > 
> > > > > > > > > > > You should be able to override this on the kvm.sh command line by
> > > > > > > > > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > > > > > > > > For example, see the torture.sh querying the system's number of CPUs
> > > > > > > > > > > and then specifying it to a number of tests.
> > > > > > > > > > > 
> > > > > > > > > > > Or am I missing something here?
> > > > > > > > > > > 
> > > > > > > > > > It took me a while to understand what happens. Apparently there is this
> > > > > > > > > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > > > > > > > > you need to know about that. I have not expected that.
> > > > > > > > > > 
> > > > > > > > > > Therefore i removed it from the configuration because i have not found
> > > > > > > > > > a good explanation why we need. It is confusing instead :)
> > > > > > > > > 
> > > > > > > > > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > > > > > > > > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > > > > > > > > TREE05, won't each instance of TREE05 consume a full system, for a total
> > > > > > > > > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > > > > > > > > command line, but that would affect all the scenarios, not just TREE05.
> > > > > > > > > Including (say) TINY01, where I believe that it would cause kvm.sh
> > > > > > > > > to complain about a Kconfig conflict.
> > > > > > > > > 
> > > > > > > > > Hence me not being in favor of this change.  ;-)
> > > > > > > > > 
> > > > > > > > > Is there another way to make things work for both situations?
> > > > > > > > > 
> > > > > > > > OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> > > > > > > > need more CPUs for TREE05.
> > > > > > > > 
> > > > > > > > I will not resist, we just drop this patch :)
> > > > > > > 
> > > > > > > Thank you!
> > > > > > > 
> > > > > > > The bug you are chasing happens when a given synchonize_rcu() interacts
> > > > > > > with RCU readers, correct?
> > > > > > > 
> > > > > > Below one:
> > > > > > 
> > > > > > <snip>
> > > > > > /*
> > > > > >  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
> > > > > >  * delay between calls.
> > > > > >  */
> > > > > > static int
> > > > > > rcu_torture_fakewriter(void *arg)
> > > > > > {
> > > > > > ...
> > > > > > <snip>
> > > > > > 
> > > > > > > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > > > > > > interacts with rcu_torture_reader().  So my guess is that running
> > > > > > > many small TREE05 guest OSes would reproduce this bug more quickly.
> > > > > > > So instead of this:
> > > > > > > 
> > > > > > > 	--kconfig CONFIG_NR_CPUS=128
> > > > > > > 
> > > > > > > Do this:
> > > > > > > 
> > > > > > > 	--configs "16*TREE05"
> > > > > > > 
> > > > > > > Or maybe even this:
> > > > > > > 
> > > > > > > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> > > > > > Thanks for input.
> > > > > > 
> > > > > > > 
> > > > > > > Thoughts?
> > > > > > > 
> > > > > > If you mean below splat:
> > > > > 
> > > > > > 
> > > > > > i.e. with more nfakewriters.
> > > > > 
> > > > > Right, and large nfakewriters would help push the synchronize_rcu()
> > > > > wakeups off of the grace-period kthread.
> > > > > 
> > > > > > If you mean the one that has recently reported, i am not able to
> > > > > > reproduce it anyhow :)
> > > > > 
> > > > > Using larger numbers of smaller rcutorture guest OSes might help to
> > > > > reproduce it.  Maybe as small as three CPUs each.  ;-)
> > > > > 
> > > > OK. I will give a try this:
> > > > 
> > > > for (( i=0; i<$LOOPS; i++ )); do
> > > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > > > 	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> > > > 	echo "Done $i"
> > > > done
> > > 
> > > Making each guest OS smaller needs "--kconfig CONFIG_NR_CPUS=4" (or
> > > whatever) as well, perhaps also increasing the "16*TREE05".
> > > 
> > 
> > By default we have NR_CPUS=8, we we discussed. Providing to kvm "--cpus 5"
> > parameter will just set number of CPUs for a VM to 5:
> > 
> > <snip>
> > ...
> > [    0.060672] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=5, Nodes=1
> > ...
> > <snip>
> > 
> > so, for my test i do not see why i need to set --kconfig CONFIG_NR_CPUS=4.
> > 
> > Am i missing something? :)
> 
> Because that gets you more guest OSes running on your system, each with
> one RCU-update kthread that is being checked by RCU reader kthreads.
> Therefore, it might double the rate at which you are able to reproduce
> this issue.
> 
You mean that setting --kconfig CONFIG_NR_CPUS=4 and 16*TREE05 will run
4 separate KVM instances?

--
Uladzislau Rezki
