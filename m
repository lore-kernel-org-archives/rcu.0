Return-Path: <SRS0=mJfo=S4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB2C43219
	for <rcu@archiver.kernel.org>; Fri, 26 Apr 2019 10:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123982077B
	for <rcu@archiver.kernel.org>; Fri, 26 Apr 2019 10:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDZKyS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:54:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfDZKyR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Apr 2019 06:54:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hJyUg-0008Fm-1X; Fri, 26 Apr 2019 12:54:14 +0200
Date:   Fri, 26 Apr 2019 12:54:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Message-ID: <20190426105413.rajcon4vyzov446c@linutronix.de>
References: <20190424073446.8577-1-bigeasy@linutronix.de>
 <20190424103809.GM3923@linux.ibm.com>
 <20190424183039.GA4494@linux.ibm.com>
 <20190425194638.GA7238@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425194638.GA7238@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2019-04-25 12:46:38 [-0700], Paul E. McKenney wrote:
> > And it doesn't like my (admittedly ancient) QEMU, complaining about not
> > knowing about "x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on".
> > If I remove these, it works.  I will be upgrading soon (famous last
> > words), so what I am going to do is queue the following separate
> > not-for-upstream patch that makes it work on my setup.
> 
> Also, the !SMP scenarios get this:
> 
> :CONFIG_PARAVIRT_SPINLOCKS=y: improperly set

I ignored that (because there is a CHECK option to ensure that certain
options are set).

> Would it make sense to only set this on CONFIG_SMP=y runs?  The easy
> way to do this is to move it from CFcommon to the scenario files not
> having CONFIG_SMP=n.  Or would something else work better?
> 
> Or am I doing something wrong?

You should also get that warning on ARM for instance since those
PARAVIRT SPINLOCKS are only implemented on x86.
I have no numbers to compare the performance with and without that
option. So we could drop that option or you tell me where to look after
a run with/without that option so I can tell if it is worth the effort.

> 							Thanx, Paul

Sebastian
