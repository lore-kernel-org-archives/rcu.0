Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38F3C433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Jul 2022 18:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiGHSQV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiGHSQV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jul 2022 14:16:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C933E09
        for <rcu@vger.kernel.org>; Fri,  8 Jul 2022 11:16:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c20so6282171qtw.8
        for <rcu@vger.kernel.org>; Fri, 08 Jul 2022 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wnKK7CshnFfIvJk8YaQeXocTj7op6NCtaSsltr31Yq8=;
        b=QGBu3N33pniLaKliww348mnJmQwrt0hjHNxMZkkNiWlpjhB4VJhrHuHpcdthWWYwGm
         WDAYML4PaTsdTez88aEEWvOqXwY3LIcYdk5gjePfPMINlUZe89PZ21UxzAW0vAKkvXN9
         k3/4l0nnPhc9CZgJNy+Vh1C8lkngvLRmsdXuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wnKK7CshnFfIvJk8YaQeXocTj7op6NCtaSsltr31Yq8=;
        b=VBzA2m6w7NY5hn4gUgYu7iJP5njMmboy53QDeNY+DUzv32ML4rT/CRRr3sBQWJuAHn
         MCLscOPcBJDrwhSxW7RjtL2I6xtMLMkNy6gf6+Vp7r75+lvonh3fqTwxOvXfPbJSSPLZ
         4mXlBX6nhr1T3410PssHHYoKUk4OjeSvKDc4/btYcPmC1XCvVCszCWW0OeukBWUVXK3h
         MK9Jw644x3RzLKf8EUeparaCKUdqimevimyzHVsfF+WM29zpp1GCaxNacCGfdJ0de/ix
         UeFN/GsvH+z56goH4T955B50Hoj6ZcRlLbnPDAZy9akq6S0HcyZDHbmc4IT/F/f3IVYQ
         zWXQ==
X-Gm-Message-State: AJIora9B+v2dvbwKJQWtTaeY2faW6Jz9W/LsZmIEFoSNDCf7zB+wUmIj
        XeiDOp4nkeBnhI4tzGBab2VTUgfu5PvC9w==
X-Google-Smtp-Source: AGRyM1tgspen/c7gbMKYxvlbeEHhLrTmU0M0uwj9CXaowtA8RMl5arvM8HWUZxBLLsQic5InZdGsHA==
X-Received: by 2002:a05:622a:1009:b0:31a:aed5:7bc3 with SMTP id d9-20020a05622a100900b0031aaed57bc3mr4142363qte.452.1657304179222;
        Fri, 08 Jul 2022 11:16:19 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id i16-20020ac84f50000000b0031ea1ad6c5asm2725185qtw.75.2022.07.08.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:16:18 -0700 (PDT)
Date:   Fri, 8 Jul 2022 18:16:18 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     rcu@vger.kernel.org
Subject: Re: About dynamic switch to offload/nocb on non-server Intel machines
Message-ID: <Ysh0cof8YKtyt8cO@google.com>
References: <YshnJLAmLtw90y2E@google.com>
 <CAFzL-7uaWeS6_UR_OYzfkBb34pbLVOeyr3mwWozonqd_ViyV0Q@mail.gmail.com>
 <CAFzL-7t5pUZwS2NO0gYnkJ8tgjP5-KaJCs_sdbXfZRF06LzgjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFzL-7t5pUZwS2NO0gYnkJ8tgjP5-KaJCs_sdbXfZRF06LzgjQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Alison, Nice to hear from you!

> On Fri, Jul 8, 2022 at 10:19 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Dear Paul and Frederic,
> >
> > Len Brown on CC provided a good idea in a meeting on using intel_pstate to
> > detect if device is a server or a consumer device.
> 
> 
> Robots are neither a server nor a consumer device.   Please let's not
> force industrial users of RT to choose between two inapt sets of
> configuration options.

I see your point.

> > Can we perhaps use this to trigger the offload/nocb mechanisms on consumer
> > devices / distros? I was thinking the dynamic offload and the "one kernel"
> > work that Frederic did can be trigger from such detection.
> >
> > It is true userspace can do the trigger, but maybe it is better to not leave
> > it to userspace so we'd save power on bad userspaces.
> >
> > Come to think of it, this can even be done at boot time if we can read the
> > below state early enough:
> >
> > > intel_pstate.c demonstrates how to detect a server when ACPI is present:
> > >
> > >
> > >
> > > #ifdef CONFIG_ACPI
> > >
> > >
> > >
> > > static bool intel_pstate_acpi_pm_profile_server(void)
> > >
> > > {
> > >
> > >         if (acpi_gbl_FADT.preferred_profile =3D=3D PM_ENTERPRISE_SERVER |=
> > |
> > >
> > >             acpi_gbl_FADT.preferred_profile =3D=3D PM_PERFORMANCE_SERVER)
> > >
> > >                 return true;
> > >
> > >
> > >
> > >         return false;
> > >
> > > }
> > >
> 
> 
> Robotics applications often rely on fairly "big iron" that is
> configured with CONFIG_CPU_FREQ_GOV_PERFORMANCE=y.   Servers and
> robotics are quite different use cases, so setting configuration that
> would be useful for servers whenever the CPU_FREQ_GOV_PERFORMANCE is
> selected would create a headache for many users.

Fair enough, I had to ask...

thanks,

 - Joel

> Best wishes,
> Alison Chaiken
> Aurora Innovation
> 
> 
> *That was a joke.
