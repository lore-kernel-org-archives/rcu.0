Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309B5C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 02:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiLaCOe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiLaCOc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 21:14:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98E1C906
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:14:27 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f20so23685407lja.4
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5FZECl/a5n2X3xPqCOwD24XLwjJ7poGDkvnKXL/X5Q=;
        b=HHOE+lyr+TDwBIWiFS5S7/zvMWdlkUG+eAaV89vBFvJWFCxPHxmaObHXJbp6Jj3WIX
         IpLLLt0W1dQWvJGhzs5hft4yV+z8WE03kOBmDgOxCrhReRIQ9FmHBOXXq0bUonu6jw4x
         +asY6fQQ5WSCPCfRtxFnFkQ3pDZnaAqpv+X60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5FZECl/a5n2X3xPqCOwD24XLwjJ7poGDkvnKXL/X5Q=;
        b=ei9JSgjCwX82WdIE8Ht+pN/15y2wgPtC/xuzbWF9Fmw3pKiSRYT6PSPcIXCv3K3/Rp
         seIQFWbCk0nGmUP/ZXMEBbjSAy2MSLTPYWmOWBuu/CVTwZUsz093A+lisR2k4PScwu9w
         Gs+pGEQf80wEY7WOfxyzLU0K2LaVn13mtYR5BTkgS28jqC1CotH+Dpo7qX/mTXTnJ0Zk
         YnkdwUEw9pHEuU+b11eyIJHvhvKeeysEhpU82wovMFKKpbj14mOwc6AzdmCCZ0payx5O
         feaqyDnFlg1ApZmv0S6gJpUfOMMOcMZGQ4zp3KN83eewc0HcHMUfTRv8L23x+7ZNWj+8
         vKYw==
X-Gm-Message-State: AFqh2kqg+7bEMnCeeOzRuBNYjc0WZin+mFJsVdIzmV5c2b+nxxAf6ic2
        XwDtF5X8dGcDMKOGsMTArRwd0CyhkEv1NUsLtkcc3g==
X-Google-Smtp-Source: AMrXdXsnT2lc1FM83OD72XfFCkM7Nr5+JEcjdpORFucZLSGwWqePjcUX4DvKY4+pfRScWUXNXnId0mihKJXZ8lVcoG8=
X-Received: by 2002:a2e:3c15:0:b0:27f:dca1:8584 with SMTP id
 j21-20020a2e3c15000000b0027fdca18584mr484118lja.313.1672452865573; Fri, 30
 Dec 2022 18:14:25 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <CAABZP2xNJoR2ABsQ6uPEHrK-KU2WO3gRt46==n10yMZ7fNZ6mA@mail.gmail.com>
In-Reply-To: <CAABZP2xNJoR2ABsQ6uPEHrK-KU2WO3gRt46==n10yMZ7fNZ6mA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 30 Dec 2022 21:14:24 -0500
Message-ID: <CAEXW_YT3ZGANz2w7M=WiPO6diUYz0PTkV9U14=8NssqZQa6boA@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 30, 2022 at 9:04 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Hi Joel
>
> As a beginner, I am interested and I have time, could you tell me
> where to download 6.0.16-rc2-g50f737b34ede when you are convenient?
> And could you tell me which torture command you are invoking? I may
> help to do some tests ;-)

Sure Zhouyi, You can checkout linux-6.0.y from the stable tree [1] and
easily reproduce it via:
tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5
--configs "25*TREE07"
This will take 2 hours to run a total of 25 tests of TREE07. The main
interest is in the shutdown stage.

If you want to collect traces when the RCU stall triggers, you can do
something like:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5
--configs 20*TREE07 --bootargs
"trace_event=sched:sched_switch,sched:sched_waking,sched:sched_wakeup,rcu:rcu_callback,rcu:rcu_fqs,rcu:rcu_grace_period
ftrace_dump_on_oops panic_on_warn=1 sysctl.kernel.panic_on_rcu_stall=1
sysctl.kernel.max_rcu_stall_to_panic=1" trace_buf_size=300K --kconfig
"CONFIG_RCU_TRACE=y CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_RANDOMIZE_BASE=n"

You can see these traces in a link in my last email. Refer to that
email for the special trace_printk() patch as well if you fancy,
though that is optional.

As a suggestion, also avoid top-posting to mailing lists [2]

Cheers,
Joel
[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
[2] https://kernelnewbies.org/mailinglistguidelines

>
> Cheers
> Zhouyi
>
> On Sat, Dec 31, 2022 at 9:46 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hello,
> >
> > I have been firefighting a hang on 6.0.y stable kernels with
> > rcutorture. It happens mostly consistently when TREE07 is shutting
> > down.
> >
> > It appears that the RCU torture threads are attempted to stop but the
> > shutdown thread, but are constantly awakened by a timer softirq
> > handler in ksoftirqd context. When they wake up, they immediately goto
> > sleep in uninterruptible state until the next time a timer handler
> > wakes them up. It appears the timer softirq is long enough to cause
> > RCU stalls and I see it calling 100s of timer function handlers
> > (call_timer_fn).
> >
> > I am doing some more investigation with trace_printk(s):
> > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> >
> > Regarding the timer handlers, I was wondering if it is possible that a
> > large number of timer handlers constantly queued can cause RCU stalls
> > due to the timer softirq taking a very long time. That certainly
> > appears to be the case here. Shouldn't the timer softirq also do
> > rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> > many of them?
> >
> > Here is a full log with trace dump if you anyone wants to take a look:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/console.log
> > And the res directory:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/
> >
> > Any thoughts on any patches 6.0 might be missing?
> >
> > Meanwhile, debug here continues... thanks,
> >
> >  - Joel
