Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93677C54EBE
	for <rcu@archiver.kernel.org>; Sat,  7 Jan 2023 10:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAGKEU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 7 Jan 2023 05:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjAGKDj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 7 Jan 2023 05:03:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1563632D
        for <rcu@vger.kernel.org>; Sat,  7 Jan 2023 01:59:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c34so5498577edf.0
        for <rcu@vger.kernel.org>; Sat, 07 Jan 2023 01:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/G9FcPlsL/ZYj6GpUzWdxZcsGx3VidjRMEnUyipGwTQ=;
        b=ycWZqSuFZ74To3dd3tRCQ6yRVxeq0UgluFKJfCwP7NMrAi4WhtdoXJFHq0fmn1PcGZ
         BidASz6yKHGfquMRO74r2wrv8n+3X0DaZHkvkUeed47LjYLFsCzlUSCcaNFJrkFwxmoe
         XAHqOJ+UooXB9uvMJr8qlJIPmNmP37tWffvmpi4nX/A3FuNHaVXj1ce3Qn+8CeG8GX3Y
         MbyMb8D/6efptMLg4LLEfs6zzrHmW6u41Vva+hK3pWH/RbLaTmU0G1JtluVSjaq/fitt
         rTRyEpJadF8DorfLe9vcUfJby2JEfhmaVxAxCymp+VXVioibcnYNPo8pOZlOma6G5xX6
         DZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/G9FcPlsL/ZYj6GpUzWdxZcsGx3VidjRMEnUyipGwTQ=;
        b=tafJMGEo9tebf9+cmdQe0x++mu8DCkQwcFNkla87T8JDQqpM3hUDGRr27zApd3JIqI
         uSyBEWmBVhU0acbANHIlKV0Sf+Q77UPhAqtqwJjaOMoxaXIUpP9XCyVfIUovMdiZadpN
         hUGdRLiD3l/T0KtgO/VRlhzs9eSB5n9iSUmBC5oPZsr4FrKmRBMs/9CgNhP9gUuurfl2
         y+7UDqgIXaYspUOa6ac2iZ4tZ8+QX662Bcxyt4crkwrx/OV8G2OOaQsIFGsjA9OTMKDo
         ZYvOV7fDvr334c+a1sGEZFBpIFTt/uCRM3EIHBrgSL7DAAjyjQZniarK6XWjCuaoBUS8
         bI/w==
X-Gm-Message-State: AFqh2kolpfAEvHoSc7sQUUkpoKNF5awyakTbQrk2Y9/PMyVF5fPoSmSP
        x3D9Zz9aAYmmmL/YAF5SApCNYmEU/g6jakXBE5YhCA==
X-Google-Smtp-Source: AMrXdXtLzFeJ9Ad5w+6FMr/1aURZJ28sV0J+AoE7j06eU9sJC8r/2qmYF8xl4P6NBEVpO98LES7s9yYkIY+u5wURJzM=
X-Received: by 2002:a05:6402:43cf:b0:48d:5b18:b009 with SMTP id
 p15-20020a05640243cf00b0048d5b18b009mr2154665edc.49.1673085498197; Sat, 07
 Jan 2023 01:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1> <20230105003813.1770367-5-paulmck@kernel.org>
In-Reply-To: <20230105003813.1770367-5-paulmck@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 7 Jan 2023 15:28:06 +0530
Message-ID: <CAAhSdy1VsT48WPQHZ5Pj5WNZRPUQvciFPF2LySawVv27tehD+g@mail.gmail.com>
Subject: Re: [PATCH rcu 05/27] arch/riscv/kvm: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 5, 2023 at 6:08 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: <kvm@vger.kernel.org>
> Cc: <kvm-riscv@lists.infradead.org>
> Cc: <linux-riscv@lists.infradead.org>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index f36a737d5f96d..6bc9b290c1283 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -27,7 +27,6 @@ config KVM
>         select KVM_XFER_TO_GUEST_WORK
>         select HAVE_KVM_VCPU_ASYNC_IOCTL
>         select HAVE_KVM_EVENTFD
> -       select SRCU
>         help
>           Support hosting virtualized guest machines.
>
> --
> 2.31.1.189.g2e36527f23
>
