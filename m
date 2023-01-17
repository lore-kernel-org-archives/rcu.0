Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693D6C46467
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 01:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjAQBpY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjAQBpV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 20:45:21 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257F8B741
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 17:45:19 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o5so5130532qtr.11
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 17:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYhSlmk0PvxFX1+U3oYA9QkS2QMXHxwQiR9tSZnBUWw=;
        b=HyDb9cPhodKHbCX5PyjPWv3t75rpjuZ+D7bbvR5yYnKigDVr8kYw9TN2dMkilSHE/+
         mU8scfWYBlgJrSR0ZfSmx9N9EPTbNk4nAG+Evh+CndALCfdINagMY6pHkGd6JdaH66i5
         T9HMAlhIodPDY4HEx6Da+XhC1FiMZkSkglMc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYhSlmk0PvxFX1+U3oYA9QkS2QMXHxwQiR9tSZnBUWw=;
        b=CFk8AR61hH8x5RfsA5JZl4uSXx143Tsg2s0XJnVPKrJkSO05EVKiMrMNsGM51BUNCv
         IX273bGeS/SkNi9L3urecNK7V3Gh4DqC2OZ1lFN9/AF3xAU1kWc2obRg5+RBOzHlp9LP
         3PztziOHcDZjpcfbNKNMdZn7CyuwRNghrogI4LY89X69361SW6GhDh5Bo1c2rwl2N0La
         SDzNKOoSUn1SnbFRZ4oXlzRliuGxdBnHGPcdB+LlermGcCX5QKNGJAVqnmakS4v1dQ6l
         DHFRq22D97eyRcm6IkOBZZdtNo9fLQq1+uxhmyOxTbb/EMBa5eH5Lj/uDuiytFMN3s1L
         vqiw==
X-Gm-Message-State: AFqh2kohQgPq4ly+hdqkphql3C5LWt/CKiodMy8pqKGAn2fFIdQgdMGW
        H6ZKJOQdO5LWvKG0xj7MxYgl3g==
X-Google-Smtp-Source: AMrXdXvz0tAieoyCSMNzPNvXGVUBJAnt7xFzPy8Wn+ZUkDoPr+m1Q7fpjxTUkX4N1uHafEQLvv+9Eg==
X-Received: by 2002:ac8:4457:0:b0:3ab:5d1e:a775 with SMTP id m23-20020ac84457000000b003ab5d1ea775mr1178915qtn.12.1673919918020;
        Mon, 16 Jan 2023 17:45:18 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id x8-20020ac81208000000b003999d25e772sm15240106qti.71.2023.01.16.17.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 17:45:17 -0800 (PST)
Date:   Tue, 17 Jan 2023 01:45:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <Y8X9rL4ZB9E7gAN9@google.com>
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
 <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
 <CAEXW_YQsUN_80FiXcts+5KgWo999KXWZDbkuPjmFCb8LiiLBzw@mail.gmail.com>
 <Y8Xoi3UvMs+Oy78O@google.com>
 <CAABZP2z50Fbs2rh4j2ToH-0hGfDamzQF3SoxxniC5LrXZ=Ja+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2z50Fbs2rh4j2ToH-0hGfDamzQF3SoxxniC5LrXZ=Ja+A@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 08:37:16AM +0800, Zhouyi Zhou wrote:
> On Tue, Jan 17, 2023 at 8:15 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > > Hi Zhouyi,
> > >
> > > On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > > >
> > > [..]
> > > > On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > Hello,
> > > > > I am seeing -EBUSY returned a lot during torture_onoff() when running
> > > > > rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > > > > also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> > > > >
> > > > > This causes warnings in torture tests:
> > > > > [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > > [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > >
> > > > > Full kernel log here:
> > > > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> > > > >
> > > > > Any ideas on why this is happening and only for CPU 0 (presumably the
> > > > > boot CPU)? I'd personally need these warnings to go away for my tests
> > > > > as this causes rcutorture's tests to not cleanly pass for me. It
> > > > > appears remove_cpu() -> device_offline() is what returns the error.
> > > > >
> > > > I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > > > nohz_full mode, which prevent that cpu from
> > > > going offline [1]. We have discussed this topic, but there is no
> > > > agreement on how to solve it yet.
> > >
> > > But I am seeing the issue in TRACE02 config which is:
> > > CONFIG_NO_HZ_IDLE=y
> > > # CONFIG_NO_HZ_FULL is not set
> > >
> > > So that is not NO_HZ_FULL:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
> > > However, I can't seem to find the full kernel logs for that.
> > >
> > > Also, other than the TRACE02 fail, I only see the issue with configs
> > > with CONFIG_NO_HZ_FULL=y
> > >
> > > Can you try TRACE02 specifically, and see if you can reproduce the
> > > same issue on your setup? Meanwhile, I'll try to trace what is
> > > returning the -EBUSY.
> I am trying TRACE02 on my X86_64 machine using cross compile and
> qemu-system-aarch64 now, my equipment is limited, but hope I can be of
> beneficial to the community ;-)

Cool, I am assuming you are trying the patch you shared which you wrote in
November. I bet you will still see the issue.

> >
> > How about something simple like the following? (untested)
> >
> > ---8<-----------------------
> >
> > diff --git a/kernel/torture.c b/kernel/torture.c
> > index bc8fb361efc0..cd64110694c0 100644
> > --- a/kernel/torture.c
> > +++ b/kernel/torture.c
> > @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
> >                         // PCI probe frequently disables hotplug during boot.
> >                         (*n_offl_attempts)--;
> >                         s = " (-EBUSY forgiven during boot)";
> > +               } else if (tick_nohz_full_running && ret == -EBUSY) {
> > +                       (*n_offl_attempts)--;
> > +                       s = " (-EBUSY forgiven if nohz_full is running)";
>  Fantastic fix!! thus we can fix the time keeper cpu torture problem
> without touch the time keeper code.

Thanks. Unfortunately this does not fix the issue for TRACE02 and the patch
you shared does not fix it either -- because TRACE02 is not a no-hz-full
test. :-(

We will need to do a bit of tracing to figure out where the -EBUSY is coming
from for TRACE02.

I wonder if we should ignore -EBUSY altogether, since as Thomas mentioned,
hotplug failure is "normal". Thoughts?

thanks,

 - Joel

