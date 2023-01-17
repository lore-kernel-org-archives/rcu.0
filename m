Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0FC677F1
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 21:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjAQV3e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjAQV2y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 16:28:54 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B714EB1
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 11:51:13 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a37so8396092ljq.0
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 11:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCP5TYJPKI6b0NCf/GLuUy8OO3JMk7h3/HfDIVN9DTM=;
        b=fnQnuxVT6TZ9HTeKK07R7S6jaI+jEVnN37OS5MFqUlr2oSFMQhM7ZKP9THUxo3GD2U
         C3b8iA9vlxwXiiYV2zSm9Fgv+vMDjfo4L/QGg4+VEwL+WU6btDDUpH08xMjiQSj6CiZw
         Vq3Y6L6Mdkj0GC0YPHrhbHZ3Ta4eJmkqhnNyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCP5TYJPKI6b0NCf/GLuUy8OO3JMk7h3/HfDIVN9DTM=;
        b=AmsIrag+7lE67FU+7AeGI7NOIHgScww2m7xru5TAZrx8HdmSABlO+j8BVc8yUGCIPT
         qfyhq5P4eXjYncYrbammv87C5yaVo83wtt2gYSpXzxAu4c4vO3AfgwRON2Pb3YZBg0jx
         tSEV5KcG1tfBCtANjvzYc1EKvtczbtCszfLbZq9utosK8bSrxV4fVxcCYaoWmJt6PC/2
         VVk8OWd6iJO9Di6f2irVagfdNeVsf6W2q8wG3vrnrJ+SJyqFQxYcf/woONotUHdEpRfJ
         ZreFalPFUHukyA5o7s3iYg+XqoTyr9TLhgWzlqqDU06O52HwwwFAyUjf9tVHOtdqM+al
         khKw==
X-Gm-Message-State: AFqh2kp+xC7H+8ODw22hlCHewXJb1fw4fzatsyKu648paWffuZHNVTu0
        6NYAtI+c4lxN0gBeC9s08yP6i7nh9povp70n6BIdLA==
X-Google-Smtp-Source: AMrXdXuE+T2sJKHU/Athg73lgQK0TKm/VGT2TOMngVkIup+c8WvC6wW1W14MhCW6OxhVW88mjaoZtYpBAzgrtxg4QZk=
X-Received: by 2002:a2e:7a1a:0:b0:28b:75ca:186c with SMTP id
 v26-20020a2e7a1a000000b0028b75ca186cmr436138ljc.313.1673985071442; Tue, 17
 Jan 2023 11:51:11 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2zHs+Zatp+SUWNsPzGn81StKF9WL_+XB3pVTJNakxh5Dw@mail.gmail.com>
 <6191067A-8033-4670-BBD0-873C5F9E8878@joelfernandes.org> <CAABZP2xbvz_SS3eZZ6SJFN6kA++DowsirDOsJANGTEX3b0DGBQ@mail.gmail.com>
In-Reply-To: <CAABZP2xbvz_SS3eZZ6SJFN6kA++DowsirDOsJANGTEX3b0DGBQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Jan 2023 19:50:59 +0000
Message-ID: <CAEXW_YT8FsuCp7BjrSz1BvvpGazqwUwaQ=tZ-N=NiFFWejwasA@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 11:43 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
[...]
> > >>>>
> > >>>> How about something simple like the following? (untested)
> > >>>>
> > >>>> ---8<-----------------------
> > >>>>
> > >>>> diff --git a/kernel/torture.c b/kernel/torture.c
> > >>>> index bc8fb361efc0..cd64110694c0 100644
> > >>>> --- a/kernel/torture.c
> > >>>> +++ b/kernel/torture.c
> > >>>> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_att=
empts, long *n_offl_successes,
> > >>>>                        // PCI probe frequently disables hotplug du=
ring boot.
> > >>>>                        (*n_offl_attempts)--;
> > >>>>                        s =3D " (-EBUSY forgiven during boot)";
> > >>>> +               } else if (tick_nohz_full_running && ret =3D=3D -E=
BUSY) {
> > >>>> +                       (*n_offl_attempts)--;
> > >>>> +                       s =3D " (-EBUSY forgiven if nohz_full is r=
unning)";
> > >>> Fantastic fix!! thus we can fix the time keeper cpu torture problem
> > >>> without touch the time keeper code.
> > >>
> > >> Thanks. Unfortunately this does not fix the issue for TRACE02 and th=
e patch
> > >> you shared does not fix it either -- because TRACE02 is not a no-hz-=
full
> > >> test. :-(
> > >>
> > >> We will need to do a bit of tracing to figure out where the -EBUSY i=
s coming
> > >> from for TRACE02.
> > > agree TRACE02 is another issue, unfortunately I can't reproduce the
> > > bug neither with your original Image [1]
> > > nor with my cross compiled kernel using [2].
> > >
> > > I guess there may be two reasons:
> > > 1) my testbed is X86_64 based.
> > > 2) the command that I invoke qemu is not right:
> > > 2-1) the newly compiled linux-5.15.89-rc1
> > > qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -smp 4
> >
> > Does 8 CPUs make any difference? That is my setup.
> 8 CPUs make no difference ;-(

Ah, it was worth a try! Hmm.

> > Not sure what else is different. It could be a CPU model specific issue=
, or something. But why donot you just use the same setup you used in Novem=
ber and check TRACE02? That is actually what I was requesting you to rest, =
since you saw the same issue on that setup.
> I guess it may be a CPU model specific issue, while I can't invoke
> qemu-system-aarch64  with  "-machine virt,gic-version=3Dhost -cpu host"
> because I didn't have an aarch64 bare metal host.
>
> OK, I am doing the same setup on linux-5.15.y as I did last November
> in the PPC VM of Open Source Lab of Oregon State University, this will
> take about 20 hours, and report what I found after the test finishes.

Sounds good, Thanks!

Thanks,

 - Joel
