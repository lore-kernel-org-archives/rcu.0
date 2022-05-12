Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E53C433F5
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 13:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiELNJ3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbiELNJ3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 09:09:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4C223864
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 06:09:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so10094372eja.11
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOKDCbIriw6OJ94H8uXOsFOQjPckQU1jNvR9j6xPIYg=;
        b=Cq0hWTmhgIB3ClJksT82pGjaoBie5kB/ol4DAnwgjhKx4nojswAfnQB5bYQdOBSEVx
         Uj8AFvrPDEJQttBufRrBhWYGL78L1E8LFtSLbLxPq6BH/LYgiR25lKsw5ez3rzY7EME+
         1S86xcSldzTNlZkmR+dxzQ3GZmeOyckkYjAl4kS990zT6b9txH5JzD88aZGynfr5RsKb
         H8XsHHOLjCdscdLrJr4WzpmcxY3NdkIvCY9Kit1jJYA9570R7YxAAhfynwThtTwC2uCz
         9hENJy/l2909BRF5wrUbsN4XJJlSl1xqAQGEj4415gqDdFZYq2WOSRJODfXRugMS1g7j
         xHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOKDCbIriw6OJ94H8uXOsFOQjPckQU1jNvR9j6xPIYg=;
        b=GUbI9Hz6DNEJ5qtxLpbDi/fYvfHzwfw8MD/qWDxwSwjamcR0VdX8EXKxRBHDMsjHJt
         7L5c9pc8OUeiHw4Rz/KbQ+4Owu4wDjTVbJftxDLo9UdSgbNtydI8M1ij5mXN3pzCqaYH
         nedCot6a23fo9Oy8q2Cak7jAJa+vCrW0Iqpd7Bazxovqr0QPHdhOnvvEtvhCbZyCfEJ3
         uxEIiBD1A9RSGZHyqIsSIbfYZ0H16Ts7UEYXJUf4SW2CHVub5RFjOjPjaUjRsvZnZRK4
         1IGUoGg775BGAs2jT2SWd88S1rSXD0n9jhaAEQsFm7Us2mSDSfbpKIXmNCi6aZylYxjv
         m/vQ==
X-Gm-Message-State: AOAM530PLUrtghk+tWacHWrExD7Av689FDpyJEv11u7z/PWLDAiOPe48
        nLJjbsE/BbnzzBrYTi7u/UVSnASVgYndXEffd3EsJkAj
X-Google-Smtp-Source: ABdhPJwWwADSReNaBc1CASv+1rKIPGRfaY/DMvNKyG1bpxDZ3KN+jOUseqRBCOLK4B6plpLAsc1VBSnQYQIb2Y6EwN4=
X-Received: by 2002:a17:906:a0ce:b0:6d1:cb30:3b3b with SMTP id
 bh14-20020a170906a0ce00b006d1cb303b3bmr29800770ejb.582.1652360966504; Thu, 12
 May 2022 06:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org> <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
In-Reply-To: <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 12 May 2022 15:09:15 +0200
Message-ID: <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Joel!

Which kernel version have you used for this series?

--
Uladzislau Rezki

On Thu, May 12, 2022 at 5:18 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, May 11, 2022 at 11:04 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > Hello!
> > Please find the proof of concept version of call_rcu_lazy() attached. This
> > gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> > Rushikesh Kadam from Intel for investigating it with me.
> >
> > Some numbers below:
> >
> > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > system is very lightly loaded but constantly running few RCU callbacks very
> > often. This confuses the power management hardware that the system is active,
> > when it is in fact idle.
> >
> > For example, when ChromeOS screen is off and user is not doing anything on the
> > system, we can see big power savings.
> > Before:
> > Pk%pc10 = 72.13
> > PkgWatt = 0.58
> > CorWatt = 0.04
> >
> > After:
> > Pk%pc10 = 81.28
> > PkgWatt = 0.41
> > CorWatt = 0.03
> >
> > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > can see that the display pipeline is constantly doing RCU callback queuing due
> > to open/close of file descriptors associated with graphics buffers. This is
> > attributed to the file_free_rcu() path which this patch series also touches.
> >
> > This patch series adds a simple but effective, and lockless implementation of
> > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > initiate a flush of one or more per-CPU lists.
> >
> > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > of function graph tracer when increasing that.
> >
> > One drawback of this series is, if another frequent RCU callback creeps up in
> > the future, that's not lazy, then that will again hurt the power. However, I
> > believe identifying and fixing those is a more reasonable approach than slowing
> > RCU down for the whole system.
> >
> > NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> > at runtime to turn it on or off globally. It is default to on. Further, please
> > use the sysctls in lazy.c for further tuning of parameters that effect the
> > flushing.
> >
> > Disclaimer 1: Don't boot your personal system on it yet anticipating power
> > savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> > I believe this series should be good for general testing.
> >
> > Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
> > net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> > of review and agreements.
>
> I did forget to add Disclaimer 3, that this breaks rcu_barrier() and
> support for that definitely needs work.
>
> thanks,
>
>  - Joel



-- 
Uladzislau Rezki
