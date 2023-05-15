Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48ECC77B7D
	for <rcu@archiver.kernel.org>; Mon, 15 May 2023 11:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbjEOLzh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 May 2023 07:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbjEOLzT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 May 2023 07:55:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8EE19A6
        for <rcu@vger.kernel.org>; Mon, 15 May 2023 04:45:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaff9c93a5so85755765ad.2
        for <rcu@vger.kernel.org>; Mon, 15 May 2023 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684151150; x=1686743150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gECJd12M7TfrpJkr4+rwayIx/tMwc6xP0XhpA132fgA=;
        b=kQwb+9xNRV4zCWaOb6XgKREIu87NT0hbMy8o2Jn1O3htmd6lKsolhXqbmvtGifLknG
         X7BmWdODsf0Ryv9L0UvKWPt16rd3GlFSvHMrbc/yx4YOhe1x0cpFD8TAfZ1IA8GuWg2c
         XIBYXm4nTIe+KPh9vb6EEutNgKJ+a9yRWDvFJtXPFDz/3aRbIswa1KS46K29/KF2J7LA
         fJ4sZ9Ywdi3t3OeyIGCSg43iCb6crOBFbXPKIBq9qwqeI6OgjDP6AeuILN8IUBr2VelP
         5S+PB8T0vp6MjKoVxrPwM7grSheMCV0yoWuNF+3wt7elqRUG+1VWFL/N9L9iKmjIpHFS
         CSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684151150; x=1686743150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gECJd12M7TfrpJkr4+rwayIx/tMwc6xP0XhpA132fgA=;
        b=F7v6JDROquQDTwqbvh7LC/QuviwEIIXxFg4a4S16F+9p+CqOx6jUsfM06zTSJNx5oe
         EglL2TymIs8rwo0c5scqnRsOezNFo7PATkZIkBHXhoB5Eyq8LBW2HdoUXtjH3uGzEZh9
         aTcFJLY9KudFqlcJFc0jmVJJxjPPTyog5FHvmrZlecgw9lH0R1TEln/jnP6jgKSt7BaJ
         A8pTHVCpGIPlpBmBgvlJlAV7kVVslpHvmBi20F17aDO51KrozsXkBIE9Ae+5QswdnYam
         gX4508IozsucVMpc3alZcFGtVU87m1RCGAEAnp9I95v8IrJtV2ANhXvLCobyY0nuMOWh
         r2RA==
X-Gm-Message-State: AC+VfDySg7tJWZC4DemTkF7aYBAJq49/+oUWgVUhnzWUgFolCFjCNNLu
        xXVbKGEFS6OLk4g3oZlBH1OZn8LzxhycyzUlpLQ=
X-Google-Smtp-Source: ACHHUZ7oZrCohQ5DdkbdJ5rKV3krPf1f06SoZvZIOVaMGP/yGotwjtktVR/J8lbaNtT3hxGHHLMHCzr0uDde+85PpR4=
X-Received: by 2002:a17:903:120d:b0:1ae:b38:b6a with SMTP id
 l13-20020a170903120d00b001ae0b380b6amr6943858plh.58.1684151150023; Mon, 15
 May 2023 04:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2yo4J8tp0_oyzPnk+8KhUEC2mqSNRvpNdPsLawvaJxrRA@mail.gmail.com>
 <7a026049-fbfa-41b0-bbba-f0690802c8ec@paulmck-laptop>
In-Reply-To: <7a026049-fbfa-41b0-bbba-f0690802c8ec@paulmck-laptop>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 15 May 2023 19:45:39 +0800
Message-ID: <CAABZP2zxFX6Qw7X2jy8fx1hQNXXPJ3-xXf__Omz4r-eLCTbn_A@mail.gmail.com>
Subject: Re: A small question about rcu_nocb_wait_contended
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 15, 2023 at 7:26=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, May 15, 2023 at 09:55:02AM +0800, Zhouyi Zhou wrote:
> > Dear RCUers:
> >
> > When I study the function rcu_nocb_try_bypass, the only place it can
> > be called is from
> > function __call_rcu_common, and __call_rcu_common disable irq before
> > call rcu_nocb_try_bypass, so, I assume when we enter
> > rcu_nocb_try_bypass, there will be no
> > context switch.
> >
> > In rcu_nocb_try_bypass, rcu_nocb_wait_contended got called, the
> > purpose of rcu_nocb_wait_contended is "relying on the fact that at
> > most two kthreads and one CPU contend for this lock".
> >
> > My question is: assume there will be no context switch, why will there
> > be two kthreads competing for this CPU lock?
> >
> > I have stumbled on this question for more than a year.
> >
> > Thank you all in advance ;-)
>
> In kernels built with CONFIG_RCU_NOCB_CPU=3Dy and on CPUs selected by eit=
her
> the nohz_full or rcu_nocbs kernel boot parameters, callbacks are invoked
> by "rcuo" kthreads created for this purpose.  These kthreads might run
> on any CPU, and so you can have the CPU queuing the callback contending
> with the CPU running the corresponding "rcuo" kthread.
Thank Paul for solving my confusion. One paragraph of teaching solved
my a year's
puzzle ;-)

Thanks again
Zhouyi
>
>                                                         Thanx, Paul
