Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF06C433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 14:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJBOHA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJBOG7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 10:06:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3639371B3
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 07:06:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a14so9340159ljj.8
        for <rcu@vger.kernel.org>; Sun, 02 Oct 2022 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5RwP5CuidPo3vKR0s4M6iTyez4QTv3TddpJbp2JFlUM=;
        b=hgt+oLHd7HZ2Rt14UMjegoi/IuyX8dD34vAtbGuViC2krXIayieryufZI0kYbazkul
         1+9zGt0TI9/EtmSn24Qh+QPuZ8PX0TfYoybx2wiZPuQqyyFMkzSAEIQwqXmWlOtSkYiO
         pHW1if+yiffox3VSOyWc+l4Y7ahxjd6QCQsW5HB6xUcPxBCzPgIE3h6tyimGT+4jKa2P
         q0oXvcPteULVgJs6YwSuaL+D5YadGl242SoIsukb3MsE9DMK3DCkxOFgmIvYnYlJOyHN
         NJxieF3nzNfH2WN35G+Qps3kF5sWl0W73Ze8M5GPie6B/QKmZ6LKpj41B91Uu0vddv3H
         ShUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5RwP5CuidPo3vKR0s4M6iTyez4QTv3TddpJbp2JFlUM=;
        b=Da/B1IOEAQp99JFYFD2SmbnkW+jYMzcMqgwXCrwzDVdSGp1EBGmocdcObZXR2zxM+X
         Rvro62JCTRex8rTjfXMyG9N43h2GZmDH5ak+nmjZrz+fHrmpn14YJ3zTmMP0kMJ07T2W
         d29h1Z3WmJ13IcDcYTt6cnOOFAQFjZfqw3HXIAiwqBhwEf0Efpa8jNxK/KonzEtp29yq
         +28+lWB0AHP7zxI9N2vMVTbkA9pnDgSN+CEswShJSP3wdylUxawdB9EFwRnPZNDLVVWz
         YPBBi2nq4x4KgUNlufvU+CucOT1F/VWl7sRKss5HBDd+C/711louC/5Gz+A4Zk9eJHi0
         V+vA==
X-Gm-Message-State: ACrzQf1VWjVN/XIh12IZ61kk0x16LfF2Ty+tv4zXYewetZsry+n/ACHf
        K+yF09WAJNjdcqS98/sJVx+2HTLdkaH6pzFLVOHAPF3oZw==
X-Google-Smtp-Source: AMsMyM6Nmdu03uG62ewD+58x/K6dJ44GE27MsXgZ/uLFfbU5RxQf+w2XIG07+3luZkyPP6UqJNP/+K1RtabuzXwxs+M=
X-Received: by 2002:a2e:b16e:0:b0:26d:d152:7a45 with SMTP id
 a14-20020a2eb16e000000b0026dd1527a45mr893355ljm.23.1664719616360; Sun, 02 Oct
 2022 07:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen> <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen> <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com> <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com> <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com> <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <CAFgQCTu-oyFMQOSGc=9q_ni=hJQ87oxM0AAU1joftkX36t9ejw@mail.gmail.com> <CAEXW_YQ19C-Drh7zVDvGRj-zsdJzhpAUJJVvzA+6SHNbTJoA9w@mail.gmail.com>
In-Reply-To: <CAEXW_YQ19C-Drh7zVDvGRj-zsdJzhpAUJJVvzA+6SHNbTJoA9w@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sun, 2 Oct 2022 22:06:44 +0800
Message-ID: <CAFgQCTvDCVL57JR3XA8UWCaS6aL9RHf=Bit6U0DDF7fqBBangA@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 30, 2022 at 9:04 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Sep 29, 2022 at 4:21 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > [...]
> > > "
> > >
> > > I have no idea whether this is related to the reverted commit.
> > >
> >
> > I have started another test against clean v6.0-rc7 to see whether this
> > is an issue with the mainline.
>
> I am not sure what exactly you are reverting (you could clarify that),

commit 96926686deab ("rcu: Make CPU-hotplug removal operations enable tick").
But due to conflict, "git revert" can not work directly. So I applied
it by hand.

> but if you are just removing the entire TICK_DEP_BIT_RCU, I do
> remember (and mentioned on IRC to others recently) that without this
> NOHZ_FULL has a hard time ending grace-periods because the forcing of
> tick is needed for this configuration if we are spinning in the kernel
> with the tick turned off. That seems to align with your TREE04
> (NOHZ_FULL) configuration.
>

Yes, that is the scenario.

> Also, the commit Frederic suggested to revert seems to be a cosmetic
> optimization in the interrupt-entry path. That should not change
> functionality I believe. So I did not fully follow why reverting that
> is relevant (maybe Frederic can clarify?).
>

Leave this question to Frederic.

And I schedule a test which reverts three commits
  96926686deab ("rcu: Make CPU-hotplug removal operations enable tick").
  53e87e3cdc15 (timers/nohz: Last resort update jiffies on nohz_full IRQ entry)
and:
  a1ff03cd6fb9 (tick: Detect and fix jiffies update stall)

Let us see the result. (Last time, it failed within an hour)

> Or, are you trying to just remove its use from the hotplug path?
>

Not from the hotplug path. Just revert the commit and run the standard
TREE04 test.

Thanks,

     Pingfan
