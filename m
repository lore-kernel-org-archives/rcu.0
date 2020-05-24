Return-Path: <SRS0=Zo9h=7G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3323BC433E0
	for <rcu@archiver.kernel.org>; Sun, 24 May 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1131A2076C
	for <rcu@archiver.kernel.org>; Sun, 24 May 2020 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbgEXTEi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 May 2020 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388009AbgEXTEi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 May 2020 15:04:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3FCC061A0E;
        Sun, 24 May 2020 12:04:38 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcvue-0005xX-VA; Sun, 24 May 2020 21:03:57 +0200
Date:   Sun, 24 May 2020 21:03:56 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200524190356.eqohmrmbilonm4u7@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
 <20200522173953.GI2869@paulmck-ThinkPad-P72>
 <20200523150831.wdrthklakwm6wago@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523150831.wdrthklakwm6wago@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-05-23 17:08:32 [+0200], To Paul E. McKenney wrote:
> On 2020-05-22 10:39:53 [-0700], Paul E. McKenney wrote:
> > It looks good to me, but I have not yet tested it.  (Happy to let you
> > take the first crack at rcutorture in any case, scenarios SRCU-P and
> > SRCU-N.)
> 
> on it.

|tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 240 --configs 8*SRCU-N
|SRCU-N ------- 2127126 GPs (147.717/s) [srcu: g26566592 f0x0 ]
|SRCU-N.2 ------- 2123520 GPs (147.467/s) [srcu: g26563696 f0x0 ]
|SRCU-N.3 ------- 2122181 GPs (147.374/s) [srcu: g26549140 f0x0 ]
|SRCU-N.4 ------- 2126099 GPs (147.646/s) [srcu: g26564232 f0x0 ]
|SRCU-N.5 ------- 2127107 GPs (147.716/s) [srcu: g26590168 f0x0 ]
|SRCU-N.6 ------- 2125489 GPs (147.603/s) [srcu: g26545616 f0x0 ]
|SRCU-N.7 ------- 2128308 GPs (147.799/s) [srcu: g26591524 f0x0 ]
|SRCU-N.8 ------- 2126432 GPs (147.669/s) [srcu: g26586816 f0x0 ]
|
|tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 240 --configs 8*SRCU-P
|SRCU-P ------- 565751 GPs (39.2883/s) [srcud: g5034676 f0x0 ]
|SRCU-P.2 ------- 569508 GPs (39.5492/s) [srcud: g5062872 f0x0 ]
|SRCU-P.3 ------- 574240 GPs (39.8778/s) [srcud: g5098488 f0x0 ]
|SRCU-P.4 ------- 564376 GPs (39.1928/s) [srcud: g5031244 f0x0 ]
|SRCU-P.5 ------- 563705 GPs (39.1462/s) [srcud: g5024720 f0x0 ]
|SRCU-P.6 ------- 565043 GPs (39.2391/s) [srcud: g5030272 f0x0 ]
|SRCU-P.7 ------- 567450 GPs (39.4062/s) [srcud: g5046392 f0x0 ]
|SRCU-P.8 ------- 566496 GPs (39.34/s) [srcud: g5039396 f0x0 ]

Results at
   https://breakpoint.cc/res.tar.xz

Sebastian
