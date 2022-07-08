Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D7EC433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Jul 2022 18:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiGHS3l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbiGHS3Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jul 2022 14:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4F82BC6
        for <rcu@vger.kernel.org>; Fri,  8 Jul 2022 11:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 980A76246A
        for <rcu@vger.kernel.org>; Fri,  8 Jul 2022 18:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C93C341C6;
        Fri,  8 Jul 2022 18:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657304959;
        bh=DxEEalOYhCfvShobFyQBW2rpqI+gJWr7dYJq19ZbYnc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z4fpPH3mdNH6N2i9KNErOslU9iEOnJRVM882Pq6JeobzfyWubpD/6EEwsarHhBTZU
         6CBTn0ZIzFSjkugpT0C8WFxkITC0zxLonnVQy4FPg6KNcDJY6M16wj1oMlM8VnMVpH
         fdFFjiFzE1y8UxLwvmcC2T6kVYhxGPyubPkkvlCqZzlcXWIHsyhMsXpxjnWsCnFoBY
         oY7vQ10UepTUstGUVZmRhNr8EctaLDn/CYcw8x+mab7Liv5x2nyEmlqu9v1EodgGpn
         DtJfpcuKW5/mI408xnQ15iV9l7aRQUrg7XwVCwULlndM2INtrEbS2rQMcbuHJe5rW+
         u291pUAcmclGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A6F0A5C0328; Fri,  8 Jul 2022 11:29:18 -0700 (PDT)
Date:   Fri, 8 Jul 2022 11:29:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     rcu@vger.kernel.org
Subject: Re: About dynamic switch to offload/nocb on non-server Intel machines
Message-ID: <20220708182918.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
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

On Fri, Jul 08, 2022 at 10:40:52AM -0700, Alison Chaiken wrote:
> Resending to mailng list due to HTML formatting . . . sorry.
> 
> -- Alison
> 
> ---
> 
> On Fri, Jul 8, 2022 at 10:19 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Dear Paul and Frederic,
> >
> > Len Brown on CC provided a good idea in a meeting on using intel_pstate to
> > detect if device is a server or a consumer device.
> 
> Robots are neither a server nor a consumer device.   Please let's not
> force industrial users of RT to choose between two inapt sets of
> configuration options.
> 
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
> 
> I know, how about a new CONFIG_ANDROID?*
> 
> Best wishes,
> Alison Chaiken
> Aurora Innovation
> 
> 
> *That was a joke.

I want a CONFIG_DO_THE_RIGHT_THING!

No, I am not volunteering to implement it.  Why do you ask?  ;-)

							Thanx, Paul
