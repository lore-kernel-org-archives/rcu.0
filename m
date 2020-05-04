Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE53EC3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9862073B
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 18:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAJUFyHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgEDSTE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730105AbgEDSTE (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 14:19:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033AFC061A0E
        for <rcu@vger.kernel.org>; Mon,  4 May 2020 11:19:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b1so351980qtt.1
        for <rcu@vger.kernel.org>; Mon, 04 May 2020 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0S0fzMzsFl0bLgNM+EgMs0aWyomMNYCeZT4Tg2u+zd8=;
        b=pAJUFyHbiVrJITSEZzA9hI6b/q96M4GFdrxxjD9xGVHb2orF8McDHNK2yfP36R27ka
         ht5q87wbY4tpgzXb4LrG7LG46QznJ3a+hIXVUsNz1Y1d1QKFpolrWK8cgXDy6sy5mijm
         S/IrPx35Yji3yvw/uBGTmKRbHVdcJTW74vDm1VjVnroVJRQVQRuICOFvvX3P4hu7jr4c
         +H5Uex5NKCLtwSF2QDkodqjG19WV7TByYRhfZJ3geJ4+qiiosF7xLBIMg/jv+92ZgeXz
         3JpEjRxma/MQ0/InwwDRmCWNFH//EPD7JgSr2wZWijcXRDpP9gVtPKrPPMJzc9WI+YIc
         8shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0S0fzMzsFl0bLgNM+EgMs0aWyomMNYCeZT4Tg2u+zd8=;
        b=c2WOrR6ofJbxr5UzuxHxv/ITcZC2Vz1sCiLqpxO/ps5X26XvNI3qZ+mZyOY8A5apRo
         l2IxHM5Uj742dQOSkYScvBa16tkCEU7yB0zrZ1RhsiHis3U7ef9QMDG8TJWk6pEmntDI
         HePGU3iRu+Ws90R9IqPopuK7iHhF3BMRWqrUcz7sU86klO1HB+gMSLJIRuyzlYeoJcsS
         n96qKmWfLkqwTyj1znGIM3AcfvL0syXdT/0cWPyYkYNJVyNw0kAWC5eZZXKxShHSgvdT
         vCUh3xIycwyPH7AI3nqwPzWhvqDhFfD2n7jMNbPvCbXiw5sW/uGtmN/pikR+w/TbBj5H
         CD6w==
X-Gm-Message-State: AGi0PuZSklJqQFatxadmFiv2V4tVFY7g3rLq5QQY9Ae/HyTtA5XGhpLE
        y0xLkcPKzw5pHufqcZeytmQmFCsb0nrpe1Dd6TE6ow==
X-Google-Smtp-Source: APiQypKZlVjRXzmmyuk2Ec0vU5DSpLg4TQpbXbv2a5QSXiyKtYq/RX9wh2PZ27Ou2L2GMthOBmz4RYZAYn6SpsLQJw8=
X-Received: by 2002:ac8:6757:: with SMTP id n23mr412624qtp.304.1588616342624;
 Mon, 04 May 2020 11:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200504120505.89351-1-joel@joelfernandes.org>
 <20200504171532.GR2869@paulmck-ThinkPad-P72> <20200504174413.GA8883@paulmck-ThinkPad-P72>
In-Reply-To: <20200504174413.GA8883@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 4 May 2020 14:18:50 -0400
Message-ID: <CAJWu+opxU7Vk1=StVmrbey_WLuCtvjw094oanpai3kuarAi07Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
To:     paulmck@kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 4, 2020 at 1:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, May 04, 2020 at 10:15:32AM -0700, Paul E. McKenney wrote:
> > On Mon, May 04, 2020 at 08:05:00AM -0400, Joel Fernandes (Google) wrote:
> > > These patches clean up the usage of dynticks nesting counters simplifying the
> > > code, while preserving the usecases.
> > >
> > > It is a much needed simplification, makes the code less confusing, and prevents
> > > future bugs such as those that arise from forgetting that the
> > > dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> > > common situations.
> > >
> > > rcutorture testing with all TREE RCU configurations succeed with
> > > CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.
> > >
> > > v1->v2:
> > > - Rebase on v5.6-rc6
> > >
> > > v2->v3:
> > > - Rebase on rcu/dev with adjustments for tasks-RCU.
> >
> > Thank you!
> >
> > But this does not apply to any of v5.6-rc6, v5.7-rc1, or v5.7-rc2.
> >
> > Where should I be trying to apply it?
>
> OK, morning blindness overcome.  I new see the "rcu/dev" in v2->v3.
>
> Please accept my apologies for the noise.

No problem, glad it got resolved. Thanks!

 - Joel
