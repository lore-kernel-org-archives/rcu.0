Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C818C433F5
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 14:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358506AbiEMOrG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 May 2022 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381485AbiEMOqv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 May 2022 10:46:51 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF018443CC
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:45:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id 3so5862832ily.2
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kavAqkUG4PJG+4ltdIRsFP4LD0Cs4221gPL+2KRnB/I=;
        b=ew3495ThhxiDLWZ2lzj+rYkjqFxsINiCxykYvdRZX83rM9mmvXVVYnrnOp4aMtRY8c
         0VEkmKbwceQ+Fl2GO+drBBrnvKkY5pECU96WH1duOGz1wBHT2HBaz7+JbAjq+Apg9wRB
         PKMX/+ce09IvuqF+id3Ik7xHBD15nvRmGE6/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kavAqkUG4PJG+4ltdIRsFP4LD0Cs4221gPL+2KRnB/I=;
        b=ZL1J1lA+aKSL74yCjrDRuSdWs+vwZ8a8DmFwXjt7WgIcRJICd9kgSFbZRfQAmdaO9x
         LUoBDJeOUC62jhupnzo+gZZDwryyvRamw4c1G2ogaRScvam7xGE+BSVotIzHRwf4mkYi
         Ut9UJAn5nlLW3tDStaxM3gDU4Dvj2/B8y0gJD1RhAnKt8nfvv30yGVHX1le5Z/cWFWey
         x78vvpD7XgXmPGp73VQPmI8+L3Ib5Qea8MzjPeT/8UEUIIclPV3u5fj6KtSocwuJg/pK
         3JdDMWm9CQGMYn6qFbdy2npAW6AgEUVq3H+SCDyhBDC+qixMY9Un8hVByLRz0qYg5SCm
         H3+A==
X-Gm-Message-State: AOAM530jqkSRJCHREfeCoJdZas0UZJ01jq//pzVzWnWrESB76bRqdfho
        9sdrZCF2ur3QKi/XCv4s+imHH6vvwuy1GznK+nea/w==
X-Google-Smtp-Source: ABdhPJyKoM38qrjPvRdH731rqKxZZILO4JeKFCCkrT9zgo3QsQdkHc0lmFMIiYCw4sMeSfTktRhkCNDvfBCYNANb38k=
X-Received: by 2002:a92:ddcb:0:b0:2cd:95b6:bede with SMTP id
 d11-20020a92ddcb000000b002cd95b6bedemr2718389ilr.280.1652453156722; Fri, 13
 May 2022 07:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com> <20220513002312.GB1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220513002312.GB1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 13 May 2022 10:45:45 -0400
Message-ID: <CAEXW_YSRJDk322dtFFU_GfmRqFGtCoMBdbuxaO8W-j8_RFJ6fw@mail.gmail.com>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 8:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, May 11, 2022 at 11:17:59PM -0400, Joel Fernandes wrote:
> > On Wed, May 11, 2022 at 11:04 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > Hello!
> > > Please find the proof of concept version of call_rcu_lazy() attached. This
> > > gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> > > Rushikesh Kadam from Intel for investigating it with me.
> > >
> > > Some numbers below:
> > >
> > > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > > system is very lightly loaded but constantly running few RCU callbacks very
> > > often. This confuses the power management hardware that the system is active,
> > > when it is in fact idle.
> > >
> > > For example, when ChromeOS screen is off and user is not doing anything on the
> > > system, we can see big power savings.
> > > Before:
> > > Pk%pc10 = 72.13
> > > PkgWatt = 0.58
> > > CorWatt = 0.04
> > >
> > > After:
> > > Pk%pc10 = 81.28
> > > PkgWatt = 0.41
> > > CorWatt = 0.03
> > >
> > > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > > can see that the display pipeline is constantly doing RCU callback queuing due
> > > to open/close of file descriptors associated with graphics buffers. This is
> > > attributed to the file_free_rcu() path which this patch series also touches.
> > >
> > > This patch series adds a simple but effective, and lockless implementation of
> > > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > > initiate a flush of one or more per-CPU lists.
> > >
> > > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > > of function graph tracer when increasing that.
> > >
> > > One drawback of this series is, if another frequent RCU callback creeps up in
> > > the future, that's not lazy, then that will again hurt the power. However, I
> > > believe identifying and fixing those is a more reasonable approach than slowing
> > > RCU down for the whole system.
> > >
> > > NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> > > at runtime to turn it on or off globally. It is default to on. Further, please
> > > use the sysctls in lazy.c for further tuning of parameters that effect the
> > > flushing.
> > >
> > > Disclaimer 1: Don't boot your personal system on it yet anticipating power
> > > savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> > > I believe this series should be good for general testing.
>
> Sometimes OOM conditions result in stalls.

I see.

> > I did forget to add Disclaimer 3, that this breaks rcu_barrier() and
> > support for that definitely needs work.
>
> Good to know.  ;-)
>
> With this in place, can the system survive a userspace close(open())
> loop, or does that result in OOM?  (I am not worried about battery
> lifetime while close(open()) is running, just OOM resistance.)

Yes, in my testing it survived. I even dropped memory to 512MB and did
the open/close loop test. I believe it survives also because we don't
let the list to grow too big (other than shrinker flushing).

>
> Does waiting for the shrinker to kick in suffice, or should the
> system pressure be taken into account?  As in the "total" numbers
> from /proc/pressure/memory.

I did not find that taking system memory pressure into account is necessary.

> Again, it is very good to see this series!

Thanks I appreciate that, I am excited about battery life savings in
millions of battery powered devices ;-) Even on my Grand mom's android
phone ;-)

Thanks,

 - Joel
