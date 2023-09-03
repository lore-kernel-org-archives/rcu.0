Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6904C83F2C
	for <rcu@archiver.kernel.org>; Sun,  3 Sep 2023 02:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjICCFZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 2 Sep 2023 22:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjICCFY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 2 Sep 2023 22:05:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965C189
        for <rcu@vger.kernel.org>; Sat,  2 Sep 2023 19:05:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so4370051fa.0
        for <rcu@vger.kernel.org>; Sat, 02 Sep 2023 19:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693706720; x=1694311520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iTQht2gg1pnyuWEUdV8Gja7AC1rAnEOwE/NOR0mtI0=;
        b=Pfg6Y9kjIEP75l2GAuWbseX2A+mNcopT1jEacCaKHev/u/tLNjQeQvrMynirjEmEi0
         qU5C8wSK3ZiU7UH5niO5ONTMrHQa8rNYTdiBaqyeNWVBghOJebNg6Lzq9jjV6RNcVb6G
         4tOPR/zrPvWO23AfpNcMd1nzwNrzvVVgpofro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693706720; x=1694311520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iTQht2gg1pnyuWEUdV8Gja7AC1rAnEOwE/NOR0mtI0=;
        b=YM+AG13yILcgCVgpCo/7BZNhoR8sjhsjuMpWy87CZZzowFdcaQgwqGnH43c+RM6cX1
         qclLy29YEOMPSga8jiLh9f3q7jrPfJPfszu8iLQ9HI7vN42ENpa1zAWbwJq3efrFaIm9
         p9Mi3blmvEE+W5HrY2Ysvf9VOsO8SVQxU/9xxvg3UqJSdddW+156edWDamy2ePW/jYra
         mYOo1y6k8JOWIXWhph0bPs8usz48HMnh3/R1eQrM8Ug18iIK5nw/6ov6t/+wFZwl5TbC
         1yJVmm5dJGTNVEQi8IyJn+2NxNavg1FEhcheLiU8ooBXcOV9g2xSC3DAI0zjlLq9dqIn
         DXBA==
X-Gm-Message-State: AOJu0YxE5emxPjqCxaIFv+ej2o6jH3Q4M0wIQIlX+7iGQpXXNrPTrAsi
        lwxcQesLUV5PejbE7p/0E+wrDQG8+gFfxWQHjE8tUQ==
X-Google-Smtp-Source: AGHT+IGdDfPJTQNMAtAuZ8I5w8Tvo1vA+/ZFqc9cwJUzg/yzMmhp3ouUBTJPBrzwxPWnptr9BH7WpyO1zZamOx0oaLE=
X-Received: by 2002:a2e:984f:0:b0:2bc:ffec:742 with SMTP id
 e15-20020a2e984f000000b002bcffec0742mr3985607ljj.49.1693706719348; Sat, 02
 Sep 2023 19:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230830110402.386898-1-joel@joelfernandes.org>
 <20230830110402.386898-2-joel@joelfernandes.org> <20230902182828.e42c6ec7b4a7beb1e4b2b042@linux-foundation.org>
 <CAEXW_YQB4qahh4FZrtw3AOsxwRw7-Bd1YXULCBOE2K9j81Oqag@mail.gmail.com>
In-Reply-To: <CAEXW_YQB4qahh4FZrtw3AOsxwRw7-Bd1YXULCBOE2K9j81Oqag@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 2 Sep 2023 22:05:08 -0400
Message-ID: <CAEXW_YSk1bE4e30=8+Sqfxeoj-SDesa=bCdyfhNWB+kxkNpXVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu: Dump vmalloc memory info safely
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 2, 2023 at 10:03=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Sat, Sep 2, 2023 at 9:28=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Wed, 30 Aug 2023 11:04:00 +0000 "Joel Fernandes (Google)" <joel@joel=
fernandes.org> wrote:
> >
> > > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > > memory info, if the objects is not allocated from the slab allocator,
> > > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> > > need to be held, since the call_rcu() can be invoked in interrupt con=
text,
> > > therefore, there is a possibility of spinlock deadlock scenarios.
> > >
> > > And in Preempt-RT kernel, the rcutorture test also trigger the follow=
ing
> > > lockdep warning:
> >
> > "possibility of deadlock" sounds like something -stable kernels would
> > like to have fixed.
> >
> > Did you consider the desirability of a -stable backport?
> >
> > If so, are we able to identify a suitable Fixes: target?
>
> Good point, it should be:
> Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
>
> I am currently reworking the patch as Vlad was also concerned about
> (the existing) issue of accessing vm_struct fields without holding the
> lock [1].
>
> I will add this fixes tag to both patches for the v3 on the respin.
>

Sigh, I missed sharing the link to [1]:
[1] https://lore.kernel.org/all/20230901003321.GA3389909@google.com/

thanks,

 - Joel
