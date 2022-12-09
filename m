Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1F1C4332F
	for <rcu@archiver.kernel.org>; Fri,  9 Dec 2022 17:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLIRCZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Dec 2022 12:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLIRCR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:17 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6719379C3D
        for <rcu@vger.kernel.org>; Fri,  9 Dec 2022 09:02:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so7962700lfs.10
        for <rcu@vger.kernel.org>; Fri, 09 Dec 2022 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=daikn9VroNivl1YE1yC9cN5gUExcOR7+xVWyWD74Yv8=;
        b=WYraxe+URQxRPVJ0/YGdVKJa+sGrtCkkuC963j7whwGMMFRt6cXQ2OeWkQZc5Kc+0u
         Sq3WkOHg/7X93qG5OH44XDvByNqGTSaJykpqqBFnVkvYGSaeLtw2K1Wxp96uB9qVrusN
         W6yOy9oKfgxkLOlKiShhFlA7ixSJSBmMzWAAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daikn9VroNivl1YE1yC9cN5gUExcOR7+xVWyWD74Yv8=;
        b=XqzDClNr5YSFroqxgCicOgVJki/TkBUns3tGYPeGxkt8npTdsG4DCum0TheF1NqSLq
         iCL2Mp+xxj+425MLbGR3R/r/L9oQam4sBIe/JPBJvkiAd0zE/MlWm44SSBmNvg3yoywn
         2dtePPxzIZMM07zR+jtCYYdKDsf10Bt0JEaSbZYKWrOWH+Jl9JRm4eOWsJnAfnl6QXpj
         5aqwFtqEuX2far6LOWo1iTNRWS2MxM6UJd3Mf7A6N4wNNj8oYJnO3IcjMO7SU1h3tv4Y
         9pd+qSuBEiAdOv+cHpg+qBXiv/ItmmPr4T6PDbMqPrsCoKnb7N8+LmqQ+1O274saNMps
         FK4Q==
X-Gm-Message-State: ANoB5pkmgQjqWOD8S+mu+cAjI0uoKAXN094b4FAbtGA28p/JKyDzDAPf
        6xCxN8xlLg8Kg7tUVRvWwHCT6kgZncI4MHeioLda425yDAJIwVdR
X-Google-Smtp-Source: AA0mqf6evJw9RZVu9lTsun7hiHcSvTbrjXEOV0BMWsMx11DYGhST83aW7ShOiqXMIAYrFrAgVJIthiBj3mruk+Ks3Pc=
X-Received: by 2002:a05:6512:b26:b0:4b4:f7aa:4e4 with SMTP id
 w38-20020a0565120b2600b004b4f7aa04e4mr20142462lfu.128.1670605334783; Fri, 09
 Dec 2022 09:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org> <20221209163445.jl4wdnbha47si7h7@offworld>
In-Reply-To: <20221209163445.jl4wdnbha47si7h7@offworld>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 9 Dec 2022 17:02:03 +0000
Message-ID: <CAEXW_YRaicORky1dWFVsRq8WFTpRsZRB5WB=GQi4--+cyEXYbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be boosted
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 9, 2022 at 4:59 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:
>
> >Currently RT boosting is only done for rtmutex_lock, however with proxy
> >execution, we also have the mutex_lock participating in priorities. To
> >exercise the testing better, add RT boosting to other lock testing types
> >as well, using a new knob (rt_boost).
> >
> >Tested with boot parameters:
> >locktorture.torture_type=mutex_lock
> >locktorture.onoff_interval=1
> >locktorture.nwriters_stress=8
> >locktorture.stutter=0
> >locktorture.rt_boost=1
> >locktorture.rt_boost_factor=1
> >locktorture.nlocks=3
> >
> >For the rtmutex test, rt_boost is always enabled even if disabling is
> >requested.
> >
> >Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >---
> > kernel/locking/locktorture.c | 99 ++++++++++++++++++++----------------
> > 1 file changed, 56 insertions(+), 43 deletions(-)
> >
> >diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >index bc3557677eed..8968fd65a90d 100644
> >--- a/kernel/locking/locktorture.c
> >+++ b/kernel/locking/locktorture.c
> >@@ -46,6 +46,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
> > torture_param(int, stat_interval, 60,
> >            "Number of seconds between stats printk()s");
> > torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> >+torture_param(int, rt_boost, 2,
> >+              "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
>
> Sorry if this was already discussed, but what would be the intent of option 2 without PE?

Np, Yes it was discussed. I would like to be, in order to exercise
more scheduler paths. It is not an invasive change in any case. We
have had issues with race conditions in the scheduler paths in the
past, that I would prefer to have in the test.

The scheduler has become incredibly complex over time with new
features such as core scheduling and heisenbugs are showing up. I am
still fighting an old 4.19 kernel issue which is likely scheduler
related, for instance.

Thanks.
