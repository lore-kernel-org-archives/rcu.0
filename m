Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D8DC19F2D
	for <rcu@archiver.kernel.org>; Sun,  7 Aug 2022 03:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiHGDF2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 Aug 2022 23:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGDF0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 6 Aug 2022 23:05:26 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0D646E
        for <rcu@vger.kernel.org>; Sat,  6 Aug 2022 20:05:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id x1-20020a056830278100b00636774b0e54so4406693otu.4
        for <rcu@vger.kernel.org>; Sat, 06 Aug 2022 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IJmje6MTwtDJYx6y4/8GyHuvy7GQSVyf7a8C0/53fcg=;
        b=Xqc4KK6ALXjYSs8HB6UucKT+QHXrUkpERXfUbzAmDcDOu9bmYnAFkHDnwYJA0lO+Vj
         5tMaEXbhaeKxVLlQeZ5+qqDjVv7qx0zHM/4eNUNH3wzAVpeuzYozb2soDbgtRlMEKDAA
         Bx+M+S8cTTDPvVeqj32QjbSIHUYcbtvlSv+S7DYwgRxo/qn212/xIwOUneQXPX85fv2l
         +l0ahmvMBvl+U1DvI7rHnYxckPTAH2MU1lGidCc8NBhdu0ShWu+BNsN2bsSLoBlittqO
         ogwjkGRc2O0meoklzJR4XUNYBuXN1E5LTA1prZ3s82Vk/9d0n3pCm5m7KFul+TqDMCxn
         7c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IJmje6MTwtDJYx6y4/8GyHuvy7GQSVyf7a8C0/53fcg=;
        b=ki36aEgOiD47+qFAp/Pcu0KEgunXo/DKdxautucgW1xg8HmhsEDZEVJ9sLPQoCbeT4
         nsEoC1B3VGbxHBy0Sxb2/PEJfxZ6Lmznz9Gxf2Okvx6j55SSL5rRlYzQjgB/b696qBZ7
         sJHggq3f3JnJNaXhSrnDNUaH9Ipm6UnKHZ7SYsic4/Q+iv+Q6/akoG5DHh4npGx9biSw
         KgWNdhPW3nsMJRJ+9Z8m+iC8dp7D8SzhogiGQwXTEB4/jM+/JNgr4niYvU4dJVQE66yp
         g1cwqUQ2zs4DQA+TA7C6tvqtxjYV6eeC6awQ9BY1EemlEkx0RNVwpVxhtau3zpOhKzih
         9osA==
X-Gm-Message-State: ACgBeo2LWEPJ4sjdG6FdgEJWjhB8gJ4Mq4ea9S2WyjvYWeUJHheSgocL
        smfSPtjAoqVtgXZsG2+Xynfow+cOX4nn3rrWP/o=
X-Google-Smtp-Source: AA6agR7NZL28APvsKmJ8Y/FgLZuJvTuvmWq1rRoDkbh4yAOnYwllFnxOy4PrtMgQSHKQIZKwmAMS4v1hY7tIXvq6czc=
X-Received: by 2002:a9d:6517:0:b0:636:a8e7:4e86 with SMTP id
 i23-20020a9d6517000000b00636a8e74e86mr4187949otl.367.1659841523735; Sat, 06
 Aug 2022 20:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWUi_BJtjmewptMZWPUOT07FWBxu3A3yQTc-vM_F2XgTA@mail.gmail.com>
 <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1> <CA+icZUX6q32RX3g6KNqvaaD2ub1cL5U6-YWPq=Nao_HvQTy95w@mail.gmail.com>
 <20220806193645.GA2125313@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220806193645.GA2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 7 Aug 2022 05:04:47 +0200
Message-ID: <CA+icZUX+Rrmt7E3zCbuDmkpT=HoNagXntaTzG4yuUyFCZXsyfA@mail.gmail.com>
Subject: Re: [vfs-next] RCU call-traces (task: modprobe)
To:     paulmck@kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, rcu@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > [ CC Ben from Debian kernel-team ]
> >
> > Hi Paul,
> >
> > Thanks for the feedback.
> >
> > Right now, I installed latest Debian-5.19 kernel to compare the Kconfig values:
> >
> > [ Debian ]
> > $ grep RCU /boot/config-5.19.0-trunk-amd64 | grep -i stall
> > CONFIG_RCU_STALL_COMMON=y
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
> >
> > [ Sedat ]
> > $ grep RCU /boot/config-5.19.0-2-amd64-clang15-kcfi | grep -i stall
> > CONFIG_RCU_STALL_COMMON=y
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
> >
> > My custom kernels take Debian's latest as a base and I adapt it to my needs.
> >
> > Just checking the Kconfigs...
> >
> > [ CONFIG_RCU_CPU_STALL_TIMEOUT ]
> >
> > Help text
> > If a given RCU grace period extends more than the specified ***number
> > of seconds***, a CPU stall warning is printed. If the RCU grace period
> > persists, additional CPU stall warnings are printed at more widely
> > spaced intervals.
> >
> > https://cateee.net/lkddb/web-lkddb/RCU_CPU_STALL_TIMEOUT.html
> >
> > [ CONFIG_RCU_EXP_CPU_STALL_TIMEOUT ]
> >
> > Help text
> > If a given expedited RCU grace period extends more than the specified
> > ***number of milliseconds***, a CPU stall warning is printed. If the
> > RCU grace period persists, additional CPU stall warnings are printed
> > at more widely spaced intervals. A value of zero says to use the
> > RCU_CPU_STALL_TIMEOUT value converted from seconds to milliseconds.
> >
> > https://cateee.net/lkddb/web-lkddb/RCU_EXP_CPU_STALL_TIMEOUT.html
> >
> > Conclusion:
> >
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21 <--- XXX: value in seconds - 21 seconds
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000 <--- XXX: value in milliseconds
> > - 21 x 1000 = 21seconds
> >
> > ...to match the values are identical?
> >
> > Or as the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT help-text recommends:
> >
> > "A value of zero says to use the RCU_CPU_STALL_TIMEOUT value converted
> > from seconds to milliseconds."
> >
> > I will try with my next 5.19 kernel build.
>
> Good point, zero is the better choice, as it accommodates changes in
> the value of CONFIG_RCU_CPU_STALL_TIMEOUT.
>
>                                                         Thanx, Paul

I build with...

[ diffconfig ]
RCU_EXP_CPU_STALL_TIMEOUT 20 -> 21000

...will observe RCU CPU stallings.

Next build I try...

CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0

-Sedat-
