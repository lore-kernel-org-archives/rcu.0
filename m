Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA7EC001DF
	for <rcu@archiver.kernel.org>; Mon, 24 Jul 2023 13:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGXNjF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Jul 2023 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjGXNif (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Jul 2023 09:38:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49D3C34
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 06:36:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b95efb9d89so62939021fa.0
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690205774; x=1690810574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lge0lq+2WPWJTonw9pGFcD5L+8dXWa6AIMAcuxyQ034=;
        b=s1mVVsU3q3DtXirpuI8r7CDaNp4td7TG76eSCT4YjU30pJEvkVaUXOdZkSh0qZo2Z3
         i6dmP7u6nLIpT3EaVqG3Io6aPTjpUzyFWWUin7pJIcA4ux3oPfzeHe4j2Fh1geBvAzyN
         cyBdvOdWyUxG3AY+LINumP2TFT/3VOs7TrYtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690205774; x=1690810574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lge0lq+2WPWJTonw9pGFcD5L+8dXWa6AIMAcuxyQ034=;
        b=KdGI/Cp7fKGFHCjoiZHf+T4DFobKKWSbnn2dRmJzRoGZQ4blADrZwawBCrtKB8y2rK
         WrBaa4Ix+ZM2Q4bBjQ//O3sYytkp5+22X8obkSScmuK9UBKevBChrJcLP5IWl46+N3N4
         VZ/CrBs/3aQXLmO5OoX/R+nZJXDOg/iYoVaEz85wLyWsy7enV2Wb18R2ARMK+UGFpxfX
         stGdvw0NAxIBPkBhgyhPFVcU8n2eyT31eC64ckByXhfk/i+zWpjQmJEN9BiF4nuvHRKR
         TTlJqIf1aj4nJ6lkKplxRZNZeuVptR8aVhUWy+MmMBL+sNc4aE6YzjfbLAcT6YlqAY71
         XgzQ==
X-Gm-Message-State: ABy/qLZru3dg4VFfdkDcW0/5JeOI1UfjfGEOn7FWI9xk4IN61lbVTNN5
        v0zThz5yRZTc2Rj3kuqadPgCCvylkxjFYYv5y961gA==
X-Google-Smtp-Source: APBJJlHutpKHS0zO5YGmbKncUQ5YljPBvN5gtDVAxyVBePGj52Yto+lQv6QWt7+G3yv3vLhNE/Wy4LyDwsIo43FgsBY=
X-Received: by 2002:a2e:9dc4:0:b0:2b6:d8d5:15b1 with SMTP id
 x4-20020a2e9dc4000000b002b6d8d515b1mr5053563ljj.50.1690205774216; Mon, 24 Jul
 2023 06:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop> <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org> <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
 <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org> <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
 <a7bcbcf2-9b34-4326-822f-e1f2aa5c5668@joelfernandes.org> <ebde8612-95de-4eaf-aa56-34e9b3a3fa86@paulmck-laptop>
 <20230724003257.GA60074@google.com> <381862e5-153c-4641-a60e-8175acae971d@paulmck-laptop>
In-Reply-To: <381862e5-153c-4641-a60e-8175acae971d@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 24 Jul 2023 09:36:02 -0400
Message-ID: <CAEXW_YQsP_j9ZBAYKGk0mBfa3x-RikMoWE01Z6q1GXkLug2xoQ@mail.gmail.com>
Subject: Re: [BUG] Re: Linux 6.4.4
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 23, 2023 at 11:35=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Mon, Jul 24, 2023 at 12:32:57AM +0000, Joel Fernandes wrote:
> > On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
> > > On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> > > >
> > > >
> > > > On 7/22/23 13:27, Paul E. McKenney wrote:
> > > > [..]
> > > > >
> > > > > OK, if this kernel is non-preemptible, you are not running TREE03=
,
> > > > > correct?
> > > > >
> > > > >> Next plan of action is to get sched_waking stack traces since I =
have a
> > > > >> very reliable repro of this now.
> > > > >
> > > > > Too much fun!  ;-)
> > > >
> > > > For TREE07 issue, it is actually the schedule_timeout_interruptible=
(1)
> > > > in stutter_wait() that is beating up the CPU0 for 4 seconds.
> > > >
> > > > This is very similar to the issue I fixed in New year in d52d3a2bf4=
08
> > > > ("torture: Fix hang during kthread shutdown phase")
> > >
> > > Agreed, if there are enough kthreads, and all the kthreads are on a
> > > single CPU, this could consume that CPU.
> > >
> > > > Adding a cond_resched() there also did not help.
> > > >
> > > > I think the issue is the stutter thread fails to move spt forward
> > > > because it does not get CPU time. But spt =3D=3D 1 should be very b=
rief
> > > > AFAIU. I was wondering if we could set that to RT.
> > >
> > > Or just use a single hrtimer-based wait for each kthread?
> >
> > [Joel]
> > Yes this might be better, but there's still the issue that spt may not =
be set
> > back to 0 in some future release where the thread gets starved.
>
> But if each thread knows the absolute time at which the current stutter
> period is supposed to end, there should not be any need for the spt
> variable, correct?

Yes.

> > > > But also maybe the following will cure it like it did for the shutd=
own
> > > > issue, giving the stutter thread just enough CPU time to move spt f=
orward.
> > > >
> > > > Now I am trying the following and will let it run while I go do oth=
er
> > > > family related things. ;)
> > >
> > > Good point, if this avoids the problem, that gives a strong indicatio=
n
> > > that your hypothesis on the root cause is correct.
> >
> > [Joel]
> > And the TREE07 issue is gone with that change!
[...]
> > Let me know what you think, thanks!
>
> If we can make the stutter kthread set an absolute time for the current
> stutter period to end, then we should be able to simplify the code quite
> a bit and get rid of the CPU consumption entirely.  (Give or take the
> possible need for a given thread to check whether it was erroneously
> awakened early.)
>
> But what specifically did you have in mind?

I was thinking of a 2 counter approach storing the absolute time. Use
an alternative counter for different stuttering sessions. But yes,
generally I agree with the absolute time idea. What do you think Paul?

Do we want to just do  the simpler schedule_timeout at HZ / 20 to keep stab=
le
green, and do the absolute-time approach for mainline? That might be better
from a process PoV. But I think stable requires patches to be upstream. Gre=
g?

I will try to send out patches this week to discuss this, thanks,

 - Joel
