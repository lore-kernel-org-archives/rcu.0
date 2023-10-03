Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99927E7544F
	for <rcu@archiver.kernel.org>; Tue,  3 Oct 2023 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjJCMGt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Oct 2023 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjJCMGs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Oct 2023 08:06:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD83B0
        for <rcu@vger.kernel.org>; Tue,  3 Oct 2023 05:06:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso149367666b.2
        for <rcu@vger.kernel.org>; Tue, 03 Oct 2023 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696334803; x=1696939603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMEwSe0v3UMkN4ht9ICDTg60HhQEYyPoaa1WymDO9XY=;
        b=AK0VRmTNK5+ng9fZ2OSFhs+5X76Sl1tHLmzM2arc3gUqGtQUCfavjEr2iovEf83/IK
         d257Baa3FQSFFwo2hm0VqiNM5XQQd1te2Au1GH61i7phaV/HzPXRs5CZocSyMCLoKREz
         DVDORkmovzlLEEQSZF2CVyReqU5oNput+VCD8unhBAjZMQC3mEsxpTqlGrheejDc0lJH
         kmF/fykGkmvTKNqInOQNMQmrVovYg0Q61RhE5c6++T6suvD25KD2thgjiGq+wTxvQZXC
         GKRpqri/fC9b6rXsRl/ZuMBMWS+7NpOX2nN8oWaJsd4gdsew9A/OIvg7cSjWUtfN42Df
         Cawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696334803; x=1696939603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMEwSe0v3UMkN4ht9ICDTg60HhQEYyPoaa1WymDO9XY=;
        b=iM50ZAOOH2MRbzymkWBjWpIwZWjhi87+0oCGjbdShic1RQA77c42QtfgmBIpMQM/EE
         H/2tFrWsRJjRg44OQ7c63g5lzNUgsEhFRwozp++x1cvK3XgcJY0F7HSrTnIlTH1VxGbd
         2KdefOBV7iGKfFhFNSPRWsxpaUdxBOmJmMLzOXPtqDMklOUsQY8xEbYq4XpyKAJxv0iU
         SzZAPO8F/H1NW33ARralhBkv7nbZO1MnAoLJ4Whx/HwhL9eckbTVL9lwuPV8tuKVBmSh
         eZpiwJNocctYVJ0kPf7No80hspy8B6+JEv6Zi/ixS9QR7szbp+93yM7LTyq7nimq0EGG
         1P1Q==
X-Gm-Message-State: AOJu0Yz0+LTeSO6XputPpax5eqWAQ3icYkO1O3QCDsfHQtCA2YoKu87o
        wfUKFS3ZnGvHVFy2chbaV/Hn3mizLPkatr5Y7jU=
X-Google-Smtp-Source: AGHT+IFJ/v3oaXGNT3g+WZyFQhSq5wwL2bGHHEQqgI+NZiwMMjJNWm4/Ifk/a2JzgaVckbp8yRmTiFLhVFU9Z5+x4x4=
X-Received: by 2002:a17:907:b1a:b0:9ae:6648:9b67 with SMTP id
 h26-20020a1709070b1a00b009ae66489b67mr12754654ejl.1.1696334803369; Tue, 03
 Oct 2023 05:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain> <ZRn1PU8enLoM8u1T@localhost.localdomain>
 <CAFwiDX_RxMQ1SgG8Wc+JWB_9i-i90Qmxuei_Yk2yJ7ohTOHjLg@mail.gmail.com> <ZRtIS-8NPKHdY0Ym@localhost.localdomain>
In-Reply-To: <ZRtIS-8NPKHdY0Ym@localhost.localdomain>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Tue, 3 Oct 2023 17:36:30 +0530
Message-ID: <CAFwiDX-dU09PgL3=rOxeMB+k_veWFD0ty2HR8QR6oESqX4kUEg@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 3, 2023 at 4:16=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Mon, Oct 02, 2023 at 07:51:10AM +0530, Neeraj upadhyay a =C3=A9crit :
> > > And if this works, can we then remove srcu_invoke_callbacks() self-re=
queue?
> > > If queued several times before it actually fires, it will catch the l=
atest
> > > grace period's end. And if queued while the callback runs, it will re=
-run.
> > >
> >
> > This makes sense, but not sure for non-wq context which  link [1] menti=
ons,
> > whether it needs it.
> >
> > > Also why do we have sdp->srcu_invoke_callbacks ? Is that workqueue re=
-entrant?
> > >
> > I think you mean sdp->srcu_cblist_invoking ?
> >
> > There was a prior discussion on this [1], where Paul mentions about
> > non-wq context.
>
> Actually I realize that if we remove that, then two srcu_invoke_callbacks=
()
> can race in such a way that an srcu barrier callback may execute before t=
he

I wasn't aware that two srcu_invoke_callbacks() for same sdp can
execute in parallel.
My understanding was, any new callback will be handled by the same kworker,
once it completes the current executing one [1]. Maybe I am missing
your point here?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/workqueue.c?h=3Dv6.6-rc4#n1081

> callbacks it is supposed to follow. And if we must keep
> sdp->srcu_cblist_invoking then we must also keep self-requeuing.
>
> I'll add a comment about that instead of removing.
>
> Thanks.
>
>
> >
> >
> >
> > Thanks
> > Neeraj
> >
> > [1] https://lkml.org/lkml/2020/11/19/1065
> >
> > > Thanks.
