Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C77C433F5
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiELDSP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245364AbiELDSN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:18:13 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1A6C0CB
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:18:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id n6so2698582ili.7
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKyyNDT+ej4C2SVkbaIQqoaLm9WEC3/jgByHcIC6ifM=;
        b=Hou7/M6DK+mahgwqBsmvNdF9s1omq/QObpNsW2SEYv3dMy9PyEu5dXO5uKzJR52iQ3
         hKD5dt2JNV1bMTtpP499ElIbDSlVpV2PH9we+2oGyY37nSWJLzmRk5oBY/mv6Pe14RG+
         qhS8SB6Bs5tFXp8B/hU/k7a8e/2YwrNe2TrP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKyyNDT+ej4C2SVkbaIQqoaLm9WEC3/jgByHcIC6ifM=;
        b=z2tBdGCxZuFwpc7cqL2TB+xBTwbyPRS9SrAK33IBU0XEZopFj3yHyXy9soB+EB2A+I
         Dx/sVjiewLXwzuSy0WdnW+BbGKFETupp5i0h+Gm9h9gIjlZIah92JKFAhi1FTgHkwBn4
         1/RGuqhR70fIQ/z13HGa0jWV0OEPwBuBiPi6+Q2FOdqymmdh8v4HUGPP4ehh5NRfUsPs
         QzEWnyr4ycSuccoEBsR0uV+zZNaPmt4NRSbSMYR6WbCMN0ItrxUj6EtYzbUar+2wxCVG
         LEpPMUOi333Mam3JF0DQk392TL/RUjY7pcxHpdLUJwLhf+fee88BOpk6cpqb7JYJ9c06
         +HUQ==
X-Gm-Message-State: AOAM531oCYJbGNR4GfsHAZTw32UMfEPzG70o5SEtgd8DK1V/WicZpDaI
        YI2QV1bH+1vKCB9YVu13XE4i+lIbRBvpZ642NmZ0iDMy0zU=
X-Google-Smtp-Source: ABdhPJwMEGzrcCpj4Gn+ZwK7u6ho0k2axiXLUUW4jDmNwVdadzM3+Sni+e5azyUzkQHxd5BcMkqE/f/qb3Vnz3fCcSc=
X-Received: by 2002:a05:6e02:156c:b0:2cf:5589:24b0 with SMTP id
 k12-20020a056e02156c00b002cf558924b0mr12907803ilu.125.1652325491523; Wed, 11
 May 2022 20:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 11 May 2022 23:17:59 -0400
Message-ID: <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     rcu <rcu@vger.kernel.org>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 11, 2022 at 11:04 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Hello!
> Please find the proof of concept version of call_rcu_lazy() attached. This
> gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> Rushikesh Kadam from Intel for investigating it with me.
>
> Some numbers below:
>
> Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> The observation is that due to a 'trickle down' effect of RCU callbacks, the
> system is very lightly loaded but constantly running few RCU callbacks very
> often. This confuses the power management hardware that the system is active,
> when it is in fact idle.
>
> For example, when ChromeOS screen is off and user is not doing anything on the
> system, we can see big power savings.
> Before:
> Pk%pc10 = 72.13
> PkgWatt = 0.58
> CorWatt = 0.04
>
> After:
> Pk%pc10 = 81.28
> PkgWatt = 0.41
> CorWatt = 0.03
>
> Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> can see that the display pipeline is constantly doing RCU callback queuing due
> to open/close of file descriptors associated with graphics buffers. This is
> attributed to the file_free_rcu() path which this patch series also touches.
>
> This patch series adds a simple but effective, and lockless implementation of
> RCU callback batching. On memory pressure, timeout or queue growing too big, we
> initiate a flush of one or more per-CPU lists.
>
> Similar results can be achieved by increasing jiffies_till_first_fqs, however
> that also has the effect of slowing down RCU. Especially I saw huge slow down
> of function graph tracer when increasing that.
>
> One drawback of this series is, if another frequent RCU callback creeps up in
> the future, that's not lazy, then that will again hurt the power. However, I
> believe identifying and fixing those is a more reasonable approach than slowing
> RCU down for the whole system.
>
> NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> at runtime to turn it on or off globally. It is default to on. Further, please
> use the sysctls in lazy.c for further tuning of parameters that effect the
> flushing.
>
> Disclaimer 1: Don't boot your personal system on it yet anticipating power
> savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> I believe this series should be good for general testing.
>
> Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
> net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> of review and agreements.

I did forget to add Disclaimer 3, that this breaks rcu_barrier() and
support for that definitely needs work.

thanks,

 - Joel
