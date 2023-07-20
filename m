Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51050EB64DA
	for <rcu@archiver.kernel.org>; Thu, 20 Jul 2023 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGTVLr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGTVLr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 Jul 2023 17:11:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328CD2123
        for <rcu@vger.kernel.org>; Thu, 20 Jul 2023 14:11:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40371070eb7so40951cf.1
        for <rcu@vger.kernel.org>; Thu, 20 Jul 2023 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689887505; x=1690492305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFMBMSuSHT3wjfgxcRFwsxpzW94657vZDmNiGlKTyzE=;
        b=IPspuDslZlm2yuv2pkMnm34gJ09M9jC1mazBAa+MyjyKQT2PgjpJFMvIY2iv3fLB01
         XaXFjpgclKZqQIqkcuEfTM3kDXorrJ6nYfH8SLfRNNi1/kXZuXGInFSbV78gZqaGq6x5
         9WvurKXxRnBEeAPXjPgGu53aoQWWhXW37IroTwlvPHyiPvAeUMpkiPBiYHFO9eSIQn6b
         gVrgOhKU6RHj6jObpnBs5Dyzhx4UI7+McuaRszsPGt0AZkWhRS8b40v5WREAWvwVmK36
         XTY0n7az8ibie3Dal1wvEKgqhgHYiE2ixzzJMbO0aNKM20clCXzO0vJkXuE6NrJ37MZS
         biCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689887505; x=1690492305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFMBMSuSHT3wjfgxcRFwsxpzW94657vZDmNiGlKTyzE=;
        b=I5SoSFrKPTO1aNxDpJ9StJR7hed23kdaZ0Dhoq8baT1S+cTXsDkl/k0cOAVkEBupcQ
         2cLS11/YIJHWu/IZ7l8Pw5wHeEUUEZgOLBgsktIz9yDq/WoC/SC3HrR7lBhihloVOhhh
         gBg0IJfEbxCZjLl6f32FHzZLHNiPuC2VpTvGcCidJneV+t9K55dTXs0pNUpUrhoF98CE
         NQlIL6EMGVEnxcFrEUM1IZU9uoVp8otfss0TDKbGbrSb49fV4cwlOh15isLuNqohy4hC
         DQOMtZ+Ae1iExHZOOmbu2L+oivW4aDDcigBXtzKb2T1WSRup6IPli26n7jl/qsbOQU8G
         ePpA==
X-Gm-Message-State: ABy/qLZ7nwDnHT7O73dEQIhqOp990pzO7couewAOVp62+ZjM4bF4lR36
        TPwzeIp/RChcS7VcugMUDN7p8hJkoHJljRb+iuzv3A==
X-Google-Smtp-Source: APBJJlFBWH+aa25PymwXQ4F9F/xaqcI0bxtFwMcMF7EMlYPMzL+/MvIfDaqZZfubPOJaRmZVG0MtsUG1oXNV/nH/7LE=
X-Received: by 2002:a05:622a:1792:b0:3f8:5b2:aef4 with SMTP id
 s18-20020a05622a179200b003f805b2aef4mr78399qtk.28.1689887505057; Thu, 20 Jul
 2023 14:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
 <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com> <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
In-Reply-To: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Jul 2023 23:11:34 +0200
Message-ID: <CANn89iLqU=huOuCt2kXmrXf68TUU-N90aQnMykkYcZ+Arx9-aA@mail.gmail.com>
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 20, 2023 at 10:00=E2=80=AFPM Alan Huang <mmpgouride@gmail.com> =
wrote:
>
>
> > 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet <edumazet=
@google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang <mmpgouride@gmail.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of first =
item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
> >> and a related discussion [1].
> >>
> >> After reading the whole discussion, it seems like that ptr->field was =
cached by gcc even with the deprecated
> >> ACCESS_ONCE(), so my question is:
> >>
> >>        Is that a compiler bug? If so, has this bug been fixed today, t=
en years later?
> >>
> >>        What about READ_ONCE(ptr->field)?
> >
> > Make sure sparse is happy.
>
> It caused a problem without barrier(), and the deprecated ACCESS_ONCE() d=
idn=E2=80=99t help:
>
>         https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>
> So, my real question is: With READ_ONCE(ptr->field), are there still some=
 unusual cases where gcc
> decides not to reload ptr->field?

I can not really answer without seeing an actual patch...

Why are you asking ? Are you tracking compiler bug fixes ?

>
> >
> > Do you have a patch for review ?
>
> Possibly next month. :)
>
> >
> >
> >>
> >>
> >> [1] https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-gla=
ptop/
> >>
> >> Thanks,
> >> Alan
>
