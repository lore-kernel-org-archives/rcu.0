Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C931C77B75
	for <rcu@archiver.kernel.org>; Fri, 12 May 2023 05:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjELFAc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 May 2023 01:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjELFAc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 May 2023 01:00:32 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520DF3C2F
        for <rcu@vger.kernel.org>; Thu, 11 May 2023 22:00:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-559ded5e170so139420277b3.3
        for <rcu@vger.kernel.org>; Thu, 11 May 2023 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683867629; x=1686459629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G0YQVid8BAUmDK4avXBWV3q8tHjdbwoFwpJ8dCo55c=;
        b=LSyQ73u1cO9ubO87ZHj25fnF1p8pwVA2g0Mk76uJfyrdc6DdZ4B37SuS4VIiOLfJk/
         37yMNZeOxw4a1QG4l2aBLnZys4v0vkMzue+WqsIF/beFFtXhqA5TFCJU18R/YmaV22Se
         sTj1DU3lNZqtAHBTxwm9vbEGJlJHZirIQEVYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683867629; x=1686459629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G0YQVid8BAUmDK4avXBWV3q8tHjdbwoFwpJ8dCo55c=;
        b=bgQ+MAJZjeJxglUZWmXZDJDKRnOpSl3m7iQVnEGMHSSOtPsVDHJChdE0xKkQq3GZzQ
         JdV6XaXHTaNy7qACOMlBsuusUguLTVyLGlQhCaSbYR1Z32X73uGnpmJL3rhg9KbOGv8l
         UIgh8lf0JQRPkQadhsZOHAN+g1C3KqWWy/uzqgdSSWH5Ej6n4pTagC+Jf+zLPxtQwPTP
         DPrCCA3Ez/MqayU6zMeeL2p2YSI1YZoUD8lmknkBfSDivEo3Z7mNFCdFpzP4wJZIa5PA
         tUSU3PZrubzLVuXmebouIrURgeMJJvIQt2nS3OpEYF7V1hPZU3G3rlfShA9oO5+L7mcO
         GUTw==
X-Gm-Message-State: AC+VfDw27VlCHUazrT3/EvLQJ3lvtRScjlrYEbhnHek1YrIm2fYK0kOd
        HYPv79mtineY6ZWxxT0kwNE3f8PzNwRctiY/nftz+Q==
X-Google-Smtp-Source: ACHHUZ6MLhbi5iBf/nXMLBN3mawFSRCoMhV1RHc31ogXUDbs6hd3pzeO2VCHa5DliqCbriCdIqWu32xLtao+ibFfYDo=
X-Received: by 2002:a81:4e4e:0:b0:55a:a90c:ecb8 with SMTP id
 c75-20020a814e4e000000b0055aa90cecb8mr24912252ywb.15.1683867629436; Thu, 11
 May 2023 22:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <20230510171238.2189921-5-paulmck@kernel.org> <CAEXW_YQNRQuPP8GzHMZXWPoLmbpK3rB_+eVXmiRu6RrsihrEpQ@mail.gmail.com>
 <0146f6ad-9a2c-4a28-8992-e054afade42c@paulmck-laptop>
In-Reply-To: <0146f6ad-9a2c-4a28-8992-e054afade42c@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 11 May 2023 22:00:18 -0700
Message-ID: <CAEXW_YQ0o8f-J3QqQKur7GkY+kxOvtANpFH4uajMGe6ioFErvw@mail.gmail.com>
Subject: Re: [PATCH rcu 5/6] doc/rcutorture: Add description of rcutorture.stall_cpu_block
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 11, 2023 at 11:11=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, May 10, 2023 at 10:47:36PM -0700, Joel Fernandes wrote:
> > On Wed, May 10, 2023 at 10:12=E2=80=AFAM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > >
> > > From: Zqiang <qiang1.zhang@intel.com>
> > >
> > > If you build a kernel with CONFIG_PREEMPTION=3Dn and CONFIG_PREEMPT_C=
OUNT=3Dy,
> > > then run the rcutorture tests specifying stalls as follows:
> > >
> > > runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" \
> > >         bootparams=3D"console=3DttyS0 rcutorture.stall_cpu=3D30 \
> > >         rcutorture.stall_no_softlockup=3D1 rcutorture.stall_cpu_block=
=3D1" -d
> > >
> > > The tests will produce the following splat:
> > >
> > > [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> > > [   10.841073] rcu_torture_stall start on CPU 3.
> > > [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x000=
0000
> > > ....
> > > [   10.841108] Call Trace:
> > > [   10.841110]  <TASK>
> > > [   10.841112]  dump_stack_lvl+0x64/0xb0
> > > [   10.841118]  dump_stack+0x10/0x20
> > > [   10.841121]  __schedule_bug+0x8b/0xb0
> > > [   10.841126]  __schedule+0x2172/0x2940
> > > [   10.841157]  schedule+0x9b/0x150
> > > [   10.841160]  schedule_timeout+0x2e8/0x4f0
> > > [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> > > [   10.841195]  rcu_torture_stall+0x2e8/0x300
> > > [   10.841199]  kthread+0x175/0x1a0
> > > [   10.841206]  ret_from_fork+0x2c/0x50
> >
> > Another way to get rid of the warning would be to replace the
> > cur_ops->readlock() with rcu_read_lock(). Though perhaps that will not
> > test whether the particular RCU flavor under testing is capable of
> > causing a stall :-).
>
> Exactly!
>
> > >         rcutorture.stall_cpu_block=3D [KNL]
> > >                         Sleep while stalling if set.  This will resul=
t
> > > -                       in warnings from preemptible RCU in addition
> > > -                       to any other stall-related activity.
> > > +                       in warnings from preemptible RCU in addition =
to
> > > +                       any other stall-related activity.  Note that
> > > +                       in kernels built with CONFIG_PREEMPTION=3Dn a=
nd
> > > +                       CONFIG_PREEMPT_COUNT=3Dy, this parameter will
> > > +                       cause the CPU to pass through a quiescent sta=
te.
> > > +                       Any such quiescent states will suppress RCU C=
PU
> > > +                       stall warnings, but the time-based sleep will
> > > +                       also result in scheduling-while-atomic splats=
.
> >
> > Could change last part to "but may also result in
> > scheduling-while-atomic splats as preemption might be disabled for
> > certain RCU flavors in order to cause the stall".
>
> Is that needed given the earlier "in kernels built with
> CONFIG_PREEMPTION=3Dn and CONFIG_PREEMPT_COUNT=3Dy"?

Hmm, I guess is not clear to the reader without code reading about why
preempt got disabled. So I would add that last part I mentioned, but I
am Ok either way, it is just a suggestion.

>
> > > +                       Which might or might not be what you want.
> > > +
> >
> > Suggest drop this line ;-).
>
> OK, I will bite.  ;-)
>
> What is your concern with this line?

It is not needed IMO.

thanks,

 - Joel


> > >         rcutorture.stall_cpu_holdoff=3D [KNL]
> > >                         Time to wait (s) after boot before inducing s=
tall.
> > > --
> > > 2.40.1
> > >
