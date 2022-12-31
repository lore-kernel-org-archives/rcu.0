Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F99C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 02:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiLaCVu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiLaCVt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 21:21:49 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE319C12
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:21:48 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id q2so23700740ljp.6
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MUpJ7g+pHd28bA3K7UmlgJvkUsU1lB0aalldQ08P0m8=;
        b=AXyGiemRgo3BJ/BkFEXDCDxvdA5LoKxisdqtb4GALmHVoNSbS2Sn4o7I3U4KQwW2Nk
         e2vkO5UQKQBskN3YY2pIBd5xI2f3XqPPAb8KyjUySNMMy220QOT2d4BWUbIgo9Eb4RTP
         /bJTtmqfPU2c6stO8YqvjqvVsomMS3ZRu7OGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUpJ7g+pHd28bA3K7UmlgJvkUsU1lB0aalldQ08P0m8=;
        b=S5bYkMo7LG43oAWMWU1WOkpdku8uPXiWZhb1Gg4f6tzulIH7rn8TEZbNj5dFrVeMSb
         SquukSKPU6Vl8nUi8/MsLgDgb9o9ZVkc36AE9pntdZR0M3BvEddpbEIWQU4wBfhYpvV1
         IqXuQ8cTWSHDTMvs/xCvssUdoOpcpfZ0t4I+amTIGQyx9rXhm/muoEJ3q6e9LPUoghuZ
         bXg7XP059qa6iO90leYFTjKYRxyQfC2+gJDk+IJhZEvqJAoBmt1qlmMQPC3Pr4MOHJaR
         YDeGE3S/XzYJDtBfAatD2VZQi0ZmwkHQNihoYjHydk38hOEHlPV/gDuQ5SRynkpOjpci
         EzGw==
X-Gm-Message-State: AFqh2koa5VQ65WisiZqaFjoD72/v25Y+v6CvcvqtUJ8S2TjxAU2w5Adl
        BD5xVgOnveYRWqLrOFLaaB4fHnpSGW1t2a5LM6d3SMGpPwgPCxBc
X-Google-Smtp-Source: AMrXdXuW/GweNKyBiUbogJkAO7I/D34EY2fMFAM6X2XNRnwEqFK8/JUP0Lk5vLODDMRXxOnwPOgVvqN49juOtMmjLc0=
X-Received: by 2002:a2e:9d53:0:b0:276:4462:2d20 with SMTP id
 y19-20020a2e9d53000000b0027644622d20mr1411734ljj.19.1672453306715; Fri, 30
 Dec 2022 18:21:46 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 30 Dec 2022 21:21:45 -0500
Message-ID: <CAEXW_YT5hu1prg+5g_3Lrtwbp_4Hxnw+O0mKRAU3hJXfZ5LuLg@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Fri, Dec 30, 2022 at 9:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
[...]
> > Here is a full log with trace dump if you anyone wants to take a look:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/console.log
> > And the res directory:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/
> >
> > Any thoughts on any patches 6.0 might be missing?
>
> This doesn't happen on current mainline?
>
> (It doesn't for me, but then again, it didn't on v6.0, either.)

I have not seen it on mainline or newer kernels, 6.1 seems to do
pretty well, but I am not 100% sure. Even on 6.0 it happens like 20%
of the time or so.

thanks,

 - Joel
