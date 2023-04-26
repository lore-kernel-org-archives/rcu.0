Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A7CC7618E
	for <rcu@archiver.kernel.org>; Wed, 26 Apr 2023 13:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbjDZNoh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Apr 2023 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbjDZNog (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Apr 2023 09:44:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3015275
        for <rcu@vger.kernel.org>; Wed, 26 Apr 2023 06:44:35 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b99f0a0052fso3385060276.3
        for <rcu@vger.kernel.org>; Wed, 26 Apr 2023 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682516674; x=1685108674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlzacH95S9G7WQYp+n1NPz67OBwaM3/l9HiCCYW0Vx0=;
        b=DChMHSbVBySgl3y5N6nCQPhXy7ImLFSFkKAR/Jszb2rzvjrN589ggtoht5HpDQJVWX
         UNTPvCLGnJY7mgve07WL+obQWUBbz99i4YJcMulOtipltF6CLhrn2iqVvLrsUODk5QDA
         bSt/W/8rVjne4zvyZ015pAZtm4RkbOQgtBmg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516674; x=1685108674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlzacH95S9G7WQYp+n1NPz67OBwaM3/l9HiCCYW0Vx0=;
        b=dMpK5T6cZUePS31EhJIuypFDPrlzDUSTfD0bKwa8uxXYSr+IPEhvh81AVscLOLxYpN
         j73S4etKIVNC4wdVMl/2kR9RKYUGOF5sV+oKneUaBzYvvsH+VcfxH+DQlObuUPqUJM4k
         oPVJ7vhuchw7oGvDgWvmsr/nQuaMciAuuKoxi6UsJbNmhQbDZIag94uEr4mjAmch7q8m
         JaP4rj8Cts9tqKyaybkCxJ0JOTEU9tmgSezPZWozUl3eXymaVRDu6viAw/310nlSo2Sj
         rH94i0BBc2WfnkViZkqTHErio3X4D9jfuUjSj2NNMTZsduZF0VnYwoP3KVOCFjXXGLw7
         WVmw==
X-Gm-Message-State: AAQBX9f3LCkk56+Kl5E83aYjz1WFY1hWPQ8MNPAkkxjJaGXhry2P1O8I
        qnaiHmBpSHgMoxNyczJRsQVobQGPNR7e6caBK1IaWQ==
X-Google-Smtp-Source: AKy350ZN41b3pj65jdJxWoNccD5sj1/xopSHqVqNgPFtkjk/m1LDrR32lA4C+SkQh2ViVhBrymcby2pu2QkcbGoeoUg=
X-Received: by 2002:a25:34d4:0:b0:b8f:32aa:1d50 with SMTP id
 b203-20020a2534d4000000b00b8f32aa1d50mr12351252yba.55.1682516674401; Wed, 26
 Apr 2023 06:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com> <877ctyzv08.fsf@mail.concordia>
In-Reply-To: <877ctyzv08.fsf@mail.concordia>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 26 Apr 2023 09:44:22 -0400
Message-ID: <CAEXW_YR4rmNY5JF-077EUpriF=PP9uML+_WMDSVi-L3G6_FOdw@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 26, 2023 at 8:30=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Joel Fernandes <joel@joelfernandes.org> writes:
> > On Tue, Apr 25, 2023 at 6:58=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.c=
om> wrote:
> ...
> >
> > Out of curiosity for PPC folks, why cannot 64-bit PPC use per-task
> > canary? Michael, is this an optimization? Adding Christophe as well
> > since it came in a few years ago via the following commit:
>
> I think Christophe also answered these in his reply.
>
> We do use a per-task canary, but because we don't have "current" in a
> register, we can't use the value in current for GCC.
>
> In one of my replies I said a possible solution would be to keep current
> in a register on 64-bit, but we'd need to do that in addition to the
> paca, so that would consume another GPR which we'd need to think hard
> about.

Makes sense. I'd think it is not worth allocating a separate GPR just
for this, and may cause similar register optimization issues as well.

> There's another reason to have it in the paca, which is that the paca is
> always accessible, even when the MMU is off, whereas current isn't (in
> some situations).
>
> In general we don't want to use stack protector in code that runs with
> the MMU off, but if the canary wasn't in the paca then we'd have a hard
> requirement to not use stack protector in that code.

How could you control which code paths don't have the stack protector?
Just curious.

thanks,

 - Joel
