Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FF0C7EE23
	for <rcu@archiver.kernel.org>; Thu,  8 Jun 2023 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbjFHRUt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Jun 2023 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbjFHRUo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Jun 2023 13:20:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF4271D
        for <rcu@vger.kernel.org>; Thu,  8 Jun 2023 10:20:31 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-626149fbc8eso7271596d6.3
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686244831; x=1688836831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiUMOSXxnadMdfH5BZI/Bps6B5NzwsmxH9J17vehVTE=;
        b=1+GMzsnKpHf0vQ3fPKZx4WPB+4os+5xcHmhLWVm3v8FuxxZu8czvUh4SY3vOHtL5a6
         0XZVmDN79H2aYBmz82g5qFPNYWEmcFjTtAeY9G5iRHnMk2mZQgfc5kh4mnd2QC+O5T5o
         B0IFu6b3CLpTL1u1FaCRxoP00WLXDOJPVf6HTOfdsfzWTRwjxU/ZXojqlOPjVk/UPdOR
         8bnnRgQLFj67Z2mKKJRT2No5NoL64BTz9CclusyWSfmx/HWMqax9OHwOfGWg8lSUqTLo
         u3pdiRvJB1p2AluXcOVfy36pncX+UOCMK1MO/JHyFQ2h27huT37Y/rq3ceLKa65G9yTt
         9wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244831; x=1688836831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiUMOSXxnadMdfH5BZI/Bps6B5NzwsmxH9J17vehVTE=;
        b=bo0aRjWx/QqRwd1kLuNrnCwEZE3Cg8NVANq/VhMqxF3InJS5Lur5spxrSmxGAOpijo
         ql/Z78659tzz8RWjGOiNwsOmF53QIIFX65RmDRx60LjkAkDS0BnKqRQvFPrCZDA6NTCI
         LEsrKkmiM+fWuUf+DOBnVbj3rB/BDPskzgA8q4MQRKiWX6A5ut9vfxMRkCh9xe/0CumI
         3igtHeH6Ik8ivcBtljkV0HXdxoTcH41OfzVm0/PPCdq20JKAxst5x5FRFU1Lzrt3JTr/
         jqz6QLc51tKPHvfVQqU/gcFFCC8/pV0qux5E4Qw4N67gWTNFDdihjs0kKg2efoNkYbUA
         ANzw==
X-Gm-Message-State: AC+VfDypqLzqNy73jL52+tf90H7X7y8ICYFE7T828oTnWFqp4xEzNYmz
        LMboqlc9l2uMWU7K8gZ7T3QMoTCkfVVsxG1Ogw7LHg==
X-Google-Smtp-Source: ACHHUZ6+Lp1zf/e8qFWABC1i2ng1ZtM859BZQ6J4wwXv/nJtY5AAZd/D8FRLE4wwdXOJ2DbpJqa3rt9txtqR14Cw+lM=
X-Received: by 2002:ad4:5c6a:0:b0:626:2bd8:b67a with SMTP id
 i10-20020ad45c6a000000b006262bd8b67amr2965328qvh.21.1686244830829; Thu, 08
 Jun 2023 10:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net> <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com> <202306080917.C0B16C8@keescook>
In-Reply-To: <202306080917.C0B16C8@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Jun 2023 10:20:19 -0700
Message-ID: <CAKwvOdmY_NEK4cnrqwU8acpU=SK3Z2uV_3PYCnhA5zQt2_TJJg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 8, 2023 at 9:47=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Thu, Jun 08, 2023 at 08:45:53AM -0700, Linus Torvalds wrote:
> > So for convenient automatic pointer freeing, you want an interface
> > much more akin to
> >
> >         struct whatever *ptr __automatic_kfree =3D kmalloc(...);
> >
> > which is much more legible, doesn't have any type mis-use issues, and
> > is also just trivially dealt with by a
> >
> >   static inline void automatic_kfree_wrapper(void *pp)
> >   { void *p =3D *(void **)pp; if (p) kfree(p); }
> >   #define __automatic_kfree \
> >         __attribute__((__cleanup__(automatic_kfree_wrapper)))
> >   #define no_free_ptr(p) \
> >         ({ __auto_type __ptr =3D (p); (p) =3D NULL; __ptr; })
> >
> > which I just tested generates the sane code even for the "set the ptr
> > to NULL and return success" case.
> >
> > The above allows you to trivially do things like
> >
> >         struct whatever *p __automatic_kfree =3D kmalloc(..);
> >
> >         if (!do_something(p))
> >                 return -ENOENT;
> >
> >         return no_free_ptr(p);
>
> I am a little worried about how (any version so far of) this API could go
> wrong, e.g. if someone uses this and does "return p" instead of "return
> no_free_ptr(p)", it'll return a freed pointer.

Presumably, one could simply just not use RAII(/SBRM someone else
corrected me about this recently coincidentally; I taught them my fun
C++ acronym IDGAF) when working with a value that conditionally
"escapes" the local scope.

--=20
Thanks,
~Nick Desaulniers
