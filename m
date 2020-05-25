Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65676C433E0
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 03:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CFD207DA
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 03:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590377239;
	bh=8e3jh3bZdGATOCnKBrKDXIxxoT45/hVK4lQxxIz2yY0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nkfVCvdPXzDWdtrNzcLVLOe+pnIpd4UoLTSx9ywZizX3WYSZ17iFwUFdByLOxF6Sr
	 h2owu0diY9UPP5pGoPJVU7GeltMlE7VC26cjGzGyKsm36cVUepy9eSJU45aPVYVLNV
	 RoSh+uu3rg92C1sRgBbDUz1x57ghaS5/T8DJKA0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgEYD1T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 May 2020 23:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388466AbgEYD1S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 May 2020 23:27:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282C72073B;
        Mon, 25 May 2020 03:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590377238;
        bh=8e3jh3bZdGATOCnKBrKDXIxxoT45/hVK4lQxxIz2yY0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xY45brw2iaBl1vMDI1prK92l6gDN9y5D9qgXIdA2mnNIZg2oeadMb4vAtnmplbRLF
         kszKYSUehId2+43wb+xRanEklEO1o3eG1ZTFobssgQ+tvQJFTs02/XJ4TYT8RqwEJe
         kslDhIUa2fqUqq7U0WCFhMRwJQVR2xpwbGTW0SMw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 056413522681; Sun, 24 May 2020 20:27:18 -0700 (PDT)
Date:   Sun, 24 May 2020 20:27:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200525032717.GV2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
 <20200522173953.GI2869@paulmck-ThinkPad-P72>
 <20200523150831.wdrthklakwm6wago@linutronix.de>
 <20200524190356.eqohmrmbilonm4u7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524190356.eqohmrmbilonm4u7@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 24, 2020 at 09:03:56PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-23 17:08:32 [+0200], To Paul E. McKenney wrote:
> > On 2020-05-22 10:39:53 [-0700], Paul E. McKenney wrote:
> > > It looks good to me, but I have not yet tested it.  (Happy to let you
> > > take the first crack at rcutorture in any case, scenarios SRCU-P and
> > > SRCU-N.)
> > 
> > on it.
> 
> |tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 240 --configs 8*SRCU-N
> |SRCU-N ------- 2127126 GPs (147.717/s) [srcu: g26566592 f0x0 ]
> |SRCU-N.2 ------- 2123520 GPs (147.467/s) [srcu: g26563696 f0x0 ]
> |SRCU-N.3 ------- 2122181 GPs (147.374/s) [srcu: g26549140 f0x0 ]
> |SRCU-N.4 ------- 2126099 GPs (147.646/s) [srcu: g26564232 f0x0 ]
> |SRCU-N.5 ------- 2127107 GPs (147.716/s) [srcu: g26590168 f0x0 ]
> |SRCU-N.6 ------- 2125489 GPs (147.603/s) [srcu: g26545616 f0x0 ]
> |SRCU-N.7 ------- 2128308 GPs (147.799/s) [srcu: g26591524 f0x0 ]
> |SRCU-N.8 ------- 2126432 GPs (147.669/s) [srcu: g26586816 f0x0 ]
> |
> |tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 240 --configs 8*SRCU-P
> |SRCU-P ------- 565751 GPs (39.2883/s) [srcud: g5034676 f0x0 ]
> |SRCU-P.2 ------- 569508 GPs (39.5492/s) [srcud: g5062872 f0x0 ]
> |SRCU-P.3 ------- 574240 GPs (39.8778/s) [srcud: g5098488 f0x0 ]
> |SRCU-P.4 ------- 564376 GPs (39.1928/s) [srcud: g5031244 f0x0 ]
> |SRCU-P.5 ------- 563705 GPs (39.1462/s) [srcud: g5024720 f0x0 ]
> |SRCU-P.6 ------- 565043 GPs (39.2391/s) [srcud: g5030272 f0x0 ]
> |SRCU-P.7 ------- 567450 GPs (39.4062/s) [srcud: g5046392 f0x0 ]
> |SRCU-P.8 ------- 566496 GPs (39.34/s) [srcud: g5039396 f0x0 ]
> 
> Results at
>    https://breakpoint.cc/res.tar.xz

Looks good, thank you!

							Thanx, Paul
