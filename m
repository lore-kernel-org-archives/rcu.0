Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB72C433F5
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 22:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiDHWJQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiDHWJO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 18:09:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D41689C7
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 15:07:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so6379011wmp.3
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z+VvyxgM4OC0WGPCxjOrHikEcgfUYeLNJ6nZBCP3TDM=;
        b=SJ8M2veFjJT2Qdk5xL/pf73ibR4NHvl/y1gShehfLU0vGvBchmkSpneO1btkI4XW29
         AuMlzJcY9HuHPK06sJmI7rM2anSaU4UobFGOGm4BqLBRFClKYmGakJZWZyaj8Kh/Ynju
         A4cwKtQ+2xoaqDOiwjRW/GGYGwWMvMXbPPKS/fywSRBZTZz2nZF9zUJ+b7Zywppl5cjL
         QaoVEWTp1vxhbuuVLqit5OKi04mLFmqPWRWwDhlEHFCVVdA6K2iZuV8c385lK8OrSnYB
         E+1VhHu/mbhUt4Mh49Zjl80xRZ0/O2YQtpH0l1klGf6fiePYAE5fu9HHFd4TjJynnb/y
         eeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z+VvyxgM4OC0WGPCxjOrHikEcgfUYeLNJ6nZBCP3TDM=;
        b=ymkQ3qyugYFN4d2coAjkhFkq/xer9utpFTEj36B11v7Sd1YugR4KYHsiSDv4OdUtMp
         dZ2xbO1JGqBuW9moynV5ioQTpqDhvYvaASltRQB1bgfqKMv1ogn9lUIxfI++ZvtHjrxM
         cKn0LK7N2qfGd5aKRs5ACnK/j5wG+16R11K9HXKXPoZ+fzCxTikSm/lsyMw+cCP2yd0U
         c1AG+BN9RTllUXL8yWdIFjurITUYCH6CGjETSXEzePjnEqaFJGbFyx0QKPhSghm3cof9
         c52bLHsRjA1BGeUlsRd4Ok1fFr47bzmWpY6Nje9cXUcLP/N1630cmwLNf90DWTBzb+Xb
         ZlyA==
X-Gm-Message-State: AOAM531RNxWK5xXmMacSbFKk+1xGRhj1+DhJXj0ELxnuF5Wuf+SZHXYu
        NE6oKgAWAWw9zdtNbSN9a8Sc5VHwCZx9OeFgVWCiLA==
X-Google-Smtp-Source: ABdhPJy+tpkyyQT7ltCQLVg6N+RT1dUBIkVnbWGcVx9CvkXrix+Y0StqVmDLI9LnfkWHKaRyyNXWMgXJKRQpIRmSQWY=
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id
 q22-20020a1ce916000000b0038eac96f477mr1659745wmc.160.1649455627870; Fri, 08
 Apr 2022 15:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
 <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1> <CAC_TJvf_ubOPUVpNYK9UUWXn5J5hpiTkOt2++kYTGbF9bM_pYw@mail.gmail.com>
 <20220408174245.65e1ec98@gandalf.local.home>
In-Reply-To: <20220408174245.65e1ec98@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 8 Apr 2022 15:06:56 -0700
Message-ID: <CAC_TJvcO6WQMkfrZ5uBGj1vHG0BkRdnZYS5A_oTpWiHo3uhY7A@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 2:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 8 Apr 2022 10:53:53 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > If PREEMT_RT systems don=E2=80=99t disable expedited grace periods, we =
can
> > remove default off for those. Steve?
>
> Yep, commit 36221e109eb20 ("rcu: Enable rcu_normal_after_boot
> unconditionally for RT") is still there.
>
> OK, that explains it. I missed that change, so I didn't see the relation =
to
> PREEMPT_RT. It wasn't described in the change log nor was there any
> comment in the kconfig to say why it was special. Perhaps that should be
> added for those that don't know all this tribal knowledge ;-)

Thanks for verifying Steve. I'll update the commit and Kconfig texts
accordingly.

-Kalesh

>
> -- Steve
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
