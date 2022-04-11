Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD796C433F5
	for <rcu@archiver.kernel.org>; Mon, 11 Apr 2022 15:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347626AbiDKPUW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347616AbiDKPUV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Apr 2022 11:20:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50D732987
        for <rcu@vger.kernel.org>; Mon, 11 Apr 2022 08:18:06 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so19029331iov.10
        for <rcu@vger.kernel.org>; Mon, 11 Apr 2022 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qxxqdzsm5NNvKuddue8zfK73fgd0MVUdg9etiRzf7DY=;
        b=gOztIOTJCTDJDS0gZRh6PiXx3DtEHbXV0VsbvU5swCYUaAQYltS3JN/06k00LN+Wfp
         Q3AeuhuUlXCCgShBxW2ELxPF/Q20PTQpuLzhwQRCIdkti08VI+7tVafICMNE2B2P7Ysb
         4hc3a2NrVX4muD6KhVlsiEhObJYy/cJUnJJtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qxxqdzsm5NNvKuddue8zfK73fgd0MVUdg9etiRzf7DY=;
        b=r4u8CtaMrDheNnOZ+xDu9eqSXBMZpRFNHc6bgUEXP7tiuJ1lOF7HgbRCWoT5KPb4VG
         Wn2f3Q4tgVuO5cZ0E9xDTz6H5tw7tIzA1lkafHULiAPwNt94/769HEIMYYfJrvk2I0kR
         RlkX9cQbsvG5K1fr0fOWiFcdfCPqcFlQDjj/r0fixTP8M5NsZ6eSolV0Z03BXq/VBmMK
         YB8XbVqEWGcTUQ85nRJXjt0/R1NDpoDUkm9NBrvYJcmSzgD+lu5W5Jr6gA5EJ7N3mP+n
         98hlBK7xdtnR7TEy9qxmyP6DTr0OXYI2liMp+PE7D6i5SLhYPPfuQEEWc0athOSqsUYq
         1nbQ==
X-Gm-Message-State: AOAM531yje8DWBV5maf/o4UNymHfmL6MeQtdnIDhAdtf5Q3iZZTIZUBu
        LKZ+4QrxfsmoneVkIhVTiVMxNr53fMtftOXyUvgFDg==
X-Google-Smtp-Source: ABdhPJyTacRRyhXpUmMsFf0hOhTvn/aPNyPMKJSLnnAgP89m51SL+egsDhPkNYhtboj1sxiUJnHKWrhMT7chg4SYG9s=
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id
 y2-20020a5d94c2000000b0060bbd34bb6fmr13306775ior.32.1649690285953; Mon, 11
 Apr 2022 08:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210734.2548973-1-joel@joelfernandes.org> <YlQx0rZzrdWIA5w+@pc638.lan>
In-Reply-To: <YlQx0rZzrdWIA5w+@pc638.lan>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 11 Apr 2022 11:17:56 -0400
Message-ID: <CAEXW_YRu8z0tHn0nOpzd4PtsL0vKpgSuN86CgwXeWCEEiXbaog@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 11, 2022 at 9:49 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Joel.
>
> > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > which ends up not offloading any CPU. This patch removes yet another
> > dependency from the bootloader having to know about RCU, about how many
> > CPUs the system has, and about how to provide the mask. Basically, I
> > think we should stop pretending that the user knows what they are doing :).
> > In other words, if NO_CB_CPU is enabled, lets make use of it.
> >
> Could you also please modify the documentation accordingly and send v2?

Yes good point, I can go clean that up in v2.

 - Joel

> <snip>
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$ grep -rn RCU_NOCB_CPU ./Documentation/
> ./Documentation/timers/no_hz.rst:188:using the CONFIG_RCU_NOCB_CPU=y Kconfig option.  The specific CPUs to
> ./Documentation/admin-guide/kernel-parameters.txt:4380:                 In kernels built with CONFIG_RCU_NOCB_CPU=y,
> ./Documentation/admin-guide/kernel-parameters.txt:4507:                 When RCU_NOCB_CPU is set, also adjust the
> ./Documentation/admin-guide/kernel-per-CPU-kthreads.rst:311:3.  Build with CONFIG_RCU_NOCB_CPU=y and boot with the rcu_nocbs=
> ./Documentation/admin-guide/kernel-per-CPU-kthreads.rst:331:2.  Build with CONFIG_RCU_NOCB_CPU=n, which will prevent these
> ./Documentation/RCU/Design/Requirements/Requirements.rst:1424:``CONFIG_RCU_NOCB_CPU=y`` and booted with ``rcu_nocbs=1-63``, where
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$ grep -rn RCU_NOCB_CPU ./kernel/rcu/
> ...
> ./kernel/rcu/Kconfig:198:config RCU_NOCB_CPU
> ..
> <snip>
>
> --
> Uladzislau Rezki
