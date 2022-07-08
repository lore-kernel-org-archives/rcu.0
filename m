Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A447C433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Jul 2022 17:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiGHRlG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiGHRlF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jul 2022 13:41:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757DA675AF
        for <rcu@vger.kernel.org>; Fri,  8 Jul 2022 10:41:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c89111f23so154705067b3.0
        for <rcu@vger.kernel.org>; Fri, 08 Jul 2022 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ju0bxdXs2slENcWDTA6t3LGgmQ/bBHdvxh2exF02Cz4=;
        b=Tnl27gRTSxf9lp33hOZyVrgffYIXvDJgtCNo4SLaonDS5B5OXLGVdYzFTB7ZgYlY4Y
         5nHSV6GafoStwo+g49YsRLYm8H7mEz4WDwnuVuqAJ2UTMLhe4fJs41f2HERH/9g9k+Bh
         dtEZgM59/8L+aiK0VmD9ThtLADEYXh/6urIwJruTBdVQ1jnhptEjxqkqx4tNUtyhG+2s
         KZy4d/hT4EUyU9WeV67N3zcUk94NNVCvdJ5FO8CSwulTy/oDvSAEr90NqbQ+G7m74g59
         2zJD8SYyChawMmC6ZEjRCt5sV4TthWiu6rXTVxlxYwcvdG+A8E58m744WRcYyGXeflK2
         wGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ju0bxdXs2slENcWDTA6t3LGgmQ/bBHdvxh2exF02Cz4=;
        b=juGUhpxcbIAnWEnXTG7zUZIqV3A5Zxgi0Wy1ugvqijS/FXSeTHSHgllujCpJmC5q+p
         gm6jLKfiaJsTEZKRTifvm/1U6caPi0U4O97IiF+B8leE8Y61fc7fPIyCITiEsAFMxwF7
         itZFGGCQj/lDTQ9a5vbyoCrU06YtG/BIB1UnE7Drr0ZbudvN2XNefiGSuy9SMnYx++An
         ZbZ2mh+QvQXzlykb+zGClViQhb8v7kl2CTz4qHN93Jk/pLZjVn+lT33t1d7e8rEwRBfp
         jBRCVKYSWlLehCIZyQIPWAx8tbqgjoIOPvuxWS9JCNx3FHBhJ6trRe8cG22PNUZseJj8
         6l3w==
X-Gm-Message-State: AJIora8D/o3TkSKVEtFmGuiwpe1IzB5/s3Mi2+ZaSWtULMl5RsvyDn+J
        Ps0pLKzIEh//S81hYvrzyrV+lYdpoMYr+hb9E4Mqds/j884=
X-Google-Smtp-Source: AGRyM1sPe8Eff5+dnOp8yrPLmHCNA4HkmUq0LhWk9ZIDczCmduUTH8BZfqnQAR+Au33H0mcecaDAIJGNAFgCM5+joc4=
X-Received: by 2002:a81:84c:0:b0:31c:96fa:634d with SMTP id
 73-20020a81084c000000b0031c96fa634dmr5369069ywi.148.1657302063723; Fri, 08
 Jul 2022 10:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <YshnJLAmLtw90y2E@google.com> <CAFzL-7uaWeS6_UR_OYzfkBb34pbLVOeyr3mwWozonqd_ViyV0Q@mail.gmail.com>
In-Reply-To: <CAFzL-7uaWeS6_UR_OYzfkBb34pbLVOeyr3mwWozonqd_ViyV0Q@mail.gmail.com>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Fri, 8 Jul 2022 10:40:52 -0700
Message-ID: <CAFzL-7t5pUZwS2NO0gYnkJ8tgjP5-KaJCs_sdbXfZRF06LzgjQ@mail.gmail.com>
Subject: Re: About dynamic switch to offload/nocb on non-server Intel machines
To:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Resending to mailng list due to HTML formatting . . . sorry.

-- Alison

---

On Fri, Jul 8, 2022 at 10:19 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Dear Paul and Frederic,
>
> Len Brown on CC provided a good idea in a meeting on using intel_pstate to
> detect if device is a server or a consumer device.


Robots are neither a server nor a consumer device.   Please let's not
force industrial users of RT to choose between two inapt sets of
configuration options.

>
> Can we perhaps use this to trigger the offload/nocb mechanisms on consumer
> devices / distros? I was thinking the dynamic offload and the "one kernel"
> work that Frederic did can be trigger from such detection.
>
> It is true userspace can do the trigger, but maybe it is better to not leave
> it to userspace so we'd save power on bad userspaces.
>
> Come to think of it, this can even be done at boot time if we can read the
> below state early enough:
>
> > intel_pstate.c demonstrates how to detect a server when ACPI is present:
> >
> >
> >
> > #ifdef CONFIG_ACPI
> >
> >
> >
> > static bool intel_pstate_acpi_pm_profile_server(void)
> >
> > {
> >
> >         if (acpi_gbl_FADT.preferred_profile =3D=3D PM_ENTERPRISE_SERVER |=
> |
> >
> >             acpi_gbl_FADT.preferred_profile =3D=3D PM_PERFORMANCE_SERVER)
> >
> >                 return true;
> >
> >
> >
> >         return false;
> >
> > }
> >


Robotics applications often rely on fairly "big iron" that is
configured with CONFIG_CPU_FREQ_GOV_PERFORMANCE=y.   Servers and
robotics are quite different use cases, so setting configuration that
would be useful for servers whenever the CPU_FREQ_GOV_PERFORMANCE is
selected would create a headache for many users.

I know, how about a new CONFIG_ANDROID?*

Best wishes,
Alison Chaiken
Aurora Innovation


*That was a joke.
