Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E707C77B78
	for <rcu@archiver.kernel.org>; Tue,  2 May 2023 20:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEBUCC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 May 2023 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEBUCB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 May 2023 16:02:01 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DE41BDF
        for <rcu@vger.kernel.org>; Tue,  2 May 2023 13:01:53 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9dcd91a389so5290283276.2
        for <rcu@vger.kernel.org>; Tue, 02 May 2023 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683057713; x=1685649713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+NUeHiffgh2k2U66BC4by3evri+rtKHf4GS4ur6Xa8=;
        b=gvF+HN4mFgyi/s0nHpyeSzXRjZdVOZ/YAnB2yKEiZCPNc79ZhOZ0P6UbcPMBSUz5ST
         CJmp2K+nSErJLBLfiRTiKoeCRO2L5u4UxwnFc0pe2m9zAdXJN0ijv31QRExRyGJzpxWy
         CuAqqZJhsgP8DR0xUA8QZj3d7QoN+fH4h0BX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683057713; x=1685649713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+NUeHiffgh2k2U66BC4by3evri+rtKHf4GS4ur6Xa8=;
        b=EyRfJzrNg9sqSMWK6bpBD+/3qqNaQLGS6QCi3Qyx8szRoF/I0YG23Hyul8w0W6HryX
         LViCtyXUni+5X5yTH9jful6bZtmgo+H1ss7SqKywaOhs9fx3KzFVEJUVHPmDTX3w/Jhx
         Eoux1smfJyO+u9s6SKAvgqDsFvEZ7ZnlmtnI6EiqwLf67XiPjjMkpbQkZyNuPOpb0yQf
         d7PGRqkD95aPrNzSRjnXa52bk0QNjujp4M8EVMQ0fWho6nGwaZjT7+5X/QCOzT+3lNdI
         ft1Ih9WksFJ3mvNX+81GCgk3d/1GRHYL9NPgTk3vk3m+Lmqrzvgu3QKKtugw9Zdjqr2R
         dVjw==
X-Gm-Message-State: AC+VfDyqP1aEcRYLSd29Kxpd+ltmqwpaMtqTlI3FZrWDzVXtDgM/FxcV
        1I8IvZVzzvCb1WrQrwUOAtdGC3MzBUrBElXBv2u3ZCYXQL11PbqZ
X-Google-Smtp-Source: ACHHUZ7OwR1749ORbplQf4a/AjJCHrIyWkPBWonZzLSTug4EbDimnBt5tEugLGxDEnfhldyP2f4R4nEtGL9aa5UUtS4=
X-Received: by 2002:a05:6902:1081:b0:b9d:d5dc:596d with SMTP id
 v1-20020a056902108100b00b9dd5dc596dmr11618732ybu.3.1683057712839; Tue, 02 May
 2023 13:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2wTpG1dCU8GNTuiyj+2zkHxWgOF3j3Mqjk5BUgS6KADZA@mail.gmail.com>
 <439F943C-32E7-4FAA-8E35-15CA1CEC0A78@joelfernandes.org> <CAABZP2yjEzC3xrpQfrzRDigO0k_dz5auaRaEWUriUy=iZVzhbg@mail.gmail.com>
In-Reply-To: <CAABZP2yjEzC3xrpQfrzRDigO0k_dz5auaRaEWUriUy=iZVzhbg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 2 May 2023 16:01:41 -0400
Message-ID: <CAEXW_YQ5v0TKBA8VcnKd2xodF_-YEELDEE1GX-tM5Vj-gOOyAg@mail.gmail.com>
Subject: Re: [PATCH V2] rcu/torture replace wait_event with wait_event_idle
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 2, 2023 at 12:30=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> Sorry for the bad format of my previous email, there is always
> something wrong when I press Ctrl+C and Ctrl+V in my browser.
> Sorry for the inconvenience that I bring.
>
> On Tue, May 2, 2023 at 11:53=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> >
> >
> > > On May 2, 2023, at 9:50 AM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > >
> > > =EF=BB=BFOn Tue, May 2, 2023 at 9:40=E2=80=AFPM Paul E. McKenney <pau=
lmck@kernel.org> wrote:
> > >>
> > >>> On Tue, May 02, 2023 at 08:01:41AM +0800, zhouzhouyi@gmail.com wrot=
e:
> > >>> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > >>>
> > >>> In kfree_rcu_test, kfree_scale_shutdown will be detected as hung ta=
sk
> > >>> if kfree_loops is too big. Replace wait_event with wait_event_idle
> > >>> to avoid false positive.
> > >>>
> > >>> Tested in the PPC VM of Open Source Lab of Oregon State University.
> > >>>
> > >>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > >>> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > >>
> > >> Good catch, thank you!
> > >>
> > >> However, this commit beat you to it:
> > >>
> > >> ef1ef3d47677 ("rcuscale: Move shutdown from wait_event() to wait_eve=
nt_idle()")
> > > You are very welcome ;-) Still, this is a very fruitful learning
> > > process for me ;-)
> >
> > Speaking of learning, can you explain why it fixes the issue? ;-)
> >
> > Your change log lacked the real reason but that is Ok since change logs=
 can only tell you so much. I admit I myself did not know the reason till I=
 read some code.
> >
> > Quiz: why exactly does this all work out in the end even though the hun=
g task detector saw it hung?
> When I found "blocked for more than" report in console.log, I did a
> grep in kernel source tree, and found check_hung_task will only be
> invoked
> from check_hung_uninterruptible_tas
> ks when (state & TASK_UNINTERRUPTIBLE) and !(state & TASK_WAKEKILL)
> and !(state &
> TASK_NOLOAD),  so I send my first patch [1], and Paul tell me
> wait_event_idle is the right answer, then I do a grep for recursively
> expansion of macro wait_event_idle, which finally set current->state
> to TASK_IDLE ((TASK_UNINTERRUPTIBLE | TASK_NOLOAD)), then I conclude
> that check_hung_task will not be called. Yes,  _interruptible()
> variant indicates that wakeups due to things like POSIX signals are
> permitted, which are not our case.

That sounds right!

> I should investigate more on what wait_event_idle really means,
> instead of merely grep and debug what wait_event_idle does.
> I should write my change log more clearly and explain why wait_event_idle=
 works.

Sounds good, the header comments around those APIs should also help.

>
> I discovered [2] during the testing of the patch, this is also a very
> fruitful learning process.
>
> I will write my change log more indicative next time, and do better
> work to our RCU community (and thanks for remove linux-kernel from CC
> list ;-))

Sounds good, have fun! :)

 - Joel
