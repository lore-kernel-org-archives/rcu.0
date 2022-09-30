Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A2C433F5
	for <rcu@archiver.kernel.org>; Fri, 30 Sep 2022 13:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiI3NEt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Sep 2022 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiI3NEr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Sep 2022 09:04:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0024B98D
        for <rcu@vger.kernel.org>; Fri, 30 Sep 2022 06:04:45 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p202so3192864iod.6
        for <rcu@vger.kernel.org>; Fri, 30 Sep 2022 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lzxya8qVf85WLal0PUG5JMgwgRIj0gGWEqZmlBgLRgw=;
        b=dvkjKUiHSqGTFD1exfqQQYzbsYCv92ZBjDoUoeAh1jwvTj2xmz48ui5fiv9eTMcAua
         z/j/riLyFWZSMn/idRrS+0vcERaQTM8A44NcWvyRFo4EufG+UVbpDUn9TcVGqHtc652v
         xypJ1CyGPDVwCG79ZG9Igq/mTLD2xnPVSzo7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lzxya8qVf85WLal0PUG5JMgwgRIj0gGWEqZmlBgLRgw=;
        b=SV5FpSlneecIyCtrk+VOOr0w2JMkEhYCK0jrIC4B+VKjfHy1MzZjJexlrHj6/Rjr8S
         4OMXyH77thzYYWnaBUyqkPYWsPasAyTZ518rwn7W5pronumuQhp1didHvjkf9SQLmXue
         U3LERQD4KpFOSPBGL4re0oT64NvAcjnpqYOA7mg3zlkGXsUAJfS0JFJNJ3jmZ0n+Mrn6
         jvvx3jvuoUjOzYu31YiJcgwXRVB7ajSUKMVwMpH9jO4HQKBaD1spVaw9MwSgLFYZ6BmE
         T6Ey3MYSJUHutn8sYBSC0whKiby3pvTA0nMQfAM6dtJkIsRhLtiigmqQ7plFcT8fSIU8
         fqSQ==
X-Gm-Message-State: ACrzQf19oavVup3YBd/iX6+L5i0pWzs22QQ1qUC5Kb5HfdtfwaKJ1q9r
        mDBK3srZXRoYm5BK4DD/g3m1RcNxr4RwSm3fceqJxQ==
X-Google-Smtp-Source: AMsMyM6/U8dvsVBRMMN3DJ/d27mdMq0iAXUfWZBI7N5L2dSD4eeo8hukAXrs3ouVICrYBAUFTcnRGwK1t8gpwbTFIyM=
X-Received: by 2002:a05:6602:15d2:b0:6a5:14f6:5e53 with SMTP id
 f18-20020a05660215d200b006a514f65e53mr3998673iow.156.1664543085017; Fri, 30
 Sep 2022 06:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen> <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen> <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com> <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com> <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com> <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <CAFgQCTu-oyFMQOSGc=9q_ni=hJQ87oxM0AAU1joftkX36t9ejw@mail.gmail.com>
In-Reply-To: <CAFgQCTu-oyFMQOSGc=9q_ni=hJQ87oxM0AAU1joftkX36t9ejw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 30 Sep 2022 09:04:35 -0400
Message-ID: <CAEXW_YQ19C-Drh7zVDvGRj-zsdJzhpAUJJVvzA+6SHNbTJoA9w@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     Pingfan Liu <kernelfans@gmail.com>
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

On Thu, Sep 29, 2022 at 4:21 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> [...]
> > "
> >
> > I have no idea whether this is related to the reverted commit.
> >
>
> I have started another test against clean v6.0-rc7 to see whether this
> is an issue with the mainline.

I am not sure what exactly you are reverting (you could clarify that),
but if you are just removing the entire TICK_DEP_BIT_RCU, I do
remember (and mentioned on IRC to others recently) that without this
NOHZ_FULL has a hard time ending grace-periods because the forcing of
tick is needed for this configuration if we are spinning in the kernel
with the tick turned off. That seems to align with your TREE04
(NOHZ_FULL) configuration.

Also, the commit Frederic suggested to revert seems to be a cosmetic
optimization in the interrupt-entry path. That should not change
functionality I believe. So I did not fully follow why reverting that
is relevant (maybe Frederic can clarify?).

Or, are you trying to just remove its use from the hotplug path?

thanks,

 - Joel
