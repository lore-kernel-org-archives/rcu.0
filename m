Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63223EB64DA
	for <rcu@archiver.kernel.org>; Fri, 14 Jul 2023 13:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjGNNm0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Jul 2023 09:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjGNNmY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Jul 2023 09:42:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9322D73
        for <rcu@vger.kernel.org>; Fri, 14 Jul 2023 06:42:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b703c900e3so29339551fa.1
        for <rcu@vger.kernel.org>; Fri, 14 Jul 2023 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689342141; x=1691934141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKmPqGb1g30twwWqaJ5CUfJThJzoEqQ8H0HnZr1gDBk=;
        b=JVbrQ9XHrBarwjW6smOjpuQfehr7HlZKI1aPI45qO5NxlJLulfdIWmx79hksCqkAqX
         1tF6nWBXJdq92p4ytUVujUPXZVyNM0BD7hpfWsmpBtJ26/vJk8QwJ53TbSoRjsvwq2z7
         X2QZ9OCZaYFFCwr9olRkaAP4Za62lZv7AETBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342141; x=1691934141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKmPqGb1g30twwWqaJ5CUfJThJzoEqQ8H0HnZr1gDBk=;
        b=jcYjoSrKnxBjjBTzikqsTEmbZtnbeN9phRuM4poeoW2H+kyVXKBScrv4n3H5hpJUbm
         L7kuvutTN7BqMa67ggaKyyHphHrnRBkPm7eoOjTduPeY5soaw4PjIYDilk1xECKdO1Bi
         ExzVj/eEJOH5Mi7M+ai4Cgb2zjn/uzXKasBkRnnRur4YELUfioZqkOgwh63cMRdmRqwJ
         HnnZyBacmhrZb1ioE0HH3lZJD/d7fDNX9uko6ZwVxZaNewZN7WYyECkYoOC5A9euj+Qi
         9Q6jIOIrqLPVcKf2LX9K3VY9zvMm+eHMOM5DfHVD9rPEie5D2022t876Hm3psCYrqZz5
         EXUA==
X-Gm-Message-State: ABy/qLY1ucdFfW4RsiHb/h0VfIAkmHpR32AiwOpcWL0GtLaiWyv818GM
        PGXpWmAHt9Z1LjAdvMW40+7wkQBGsKcwLs+Av4DKFg==
X-Google-Smtp-Source: APBJJlH1WlIL+So7XPu4cswA6dYrMzMWL7p+KH+gVJRpdkuvvZwGD/w94Pdv9W6rq0jyEEhBOw2A3nnL6lODP8EX8Ss=
X-Received: by 2002:a2e:3c0c:0:b0:2b6:d137:b61c with SMTP id
 j12-20020a2e3c0c000000b002b6d137b61cmr3810480lja.39.1689342140935; Fri, 14
 Jul 2023 06:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230713003201.GA469376@google.com> <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop> <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop> <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com> <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop> <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <058e7ee9-0380-eb1b-d9a8-b184cba6ed53@linux.alibaba.com>
In-Reply-To: <058e7ee9-0380-eb1b-d9a8-b184cba6ed53@linux.alibaba.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 14 Jul 2023 09:42:08 -0400
Message-ID: <CAEXW_YQCpUsPz24H4Mux6wOH1=RFRR-gsXLFTbJ37MgUJo3kCw@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     paulmck@kernel.org, Sandeep Dhavale <dhavale@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 13, 2023 at 11:17=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2023/7/14 10:16, Paul E. McKenney wrote:
> > On Thu, Jul 13, 2023 at 09:33:35AM -0700, Paul E. McKenney wrote:
> >> On Thu, Jul 13, 2023 at 11:33:24AM -0400, Joel Fernandes wrote:
>
> ...
>
> >>>
> >>> >From what Sandeep described, the code path is in an RCU reader. My
> >>> question is more, why doesn't it use SRCU instead since it clearly
> >>> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
> >>> dive needs to be made into that before concluding that the fix is to
> >>> use rcu_read_lock_any_held().
> >>
> >> How can this be solved?
> >>
> >> 1.   Always use a workqueue.  Simple, but is said to have performance
> >>      issues.
> >>
> >> 2.   Pass a flag in that indicates whether or not the caller is in an
> >>      RCU read-side critical section.  Conceptually simple, but might
> >>      or might not be reasonable to actually implement in the code as
> >>      it exists now.  (You tell me!)
> >>
> >> 3.   Create a function in z_erofs that gives you a decent
> >>      approximation, maybe something like the following.
> >>
> >> 4.   Other ideas here.
> >
> > 5.    #3 plus make the corresponding Kconfig option select
> >       PREEMPT_COUNT, assuming that any users needing compression in
> >       non-preemptible kernels are OK with PREEMPT_COUNT being set.
> >       (Some users of non-preemptible kernels object strenuously
> >       to the added overhead from CONFIG_PREEMPT_COUNT=3Dy.)
>
> I'm not sure if it's a good idea

I think it is a fine idea.

> we need to work on
> CONFIG_PREEMPT_COUNT=3Dn (why not?), we could just always trigger a
> workqueue for this.
>

So CONFIG_PREEMPT_COUNT=3Dn users don't deserve good performance? ;-)

thanks,

 - Joel
