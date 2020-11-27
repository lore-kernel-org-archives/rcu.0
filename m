Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7388C63798
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9326F20657
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udwA9p34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgK0Qlf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgK0Qle (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Nov 2020 11:41:34 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27F7C0613D1
        for <rcu@vger.kernel.org>; Fri, 27 Nov 2020 08:41:32 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so7837623lfm.8
        for <rcu@vger.kernel.org>; Fri, 27 Nov 2020 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rgkrb035jm9NJnipoFNp6J644nVoW0SJU1WZzjzA+oA=;
        b=udwA9p34XKAzVdUynfyA3sUQIHdQlG/KghvzCRzcKIP+V6Ez0oaYWmUIVE5rTY6I/e
         CW4TCmiSwaTCiKDJXkn7LgN9+fjAGq6lrtbJ42gd4XLIk+N7/71H4pKuqh3TBy79TYvM
         1kOi7hd6b/9KCo6JhpWznw7poOjXY8a3z00zANtR8Fr+yhOvY1eHPYt8clzfeCOb4inW
         7HkL1Lx0rdIJN4uiRZH4AjcAap7qCC/+qWIn7hgSHtQ4+Vw8yB773T7eD9kntRacbjET
         xTJA12M/jwG7M8J0tS6CXBOGuRaO7dRGqyaBJ9KUdV7oMYH39dT18YhqJomNnBOHMnUk
         BAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rgkrb035jm9NJnipoFNp6J644nVoW0SJU1WZzjzA+oA=;
        b=q3y7k8Do7tKfHNk60v4TCszsYFiZB/hWOCQ+J285o9J4zuYxRNZ34ykaJJkz8tOlq2
         G5BUxvA8K7i3c1nWmoaPbPZzu+l+dcot2Bpmn939HiRSosnYLjQyRWsqantBv31j9pnW
         V+YxaRwk/9GRkhg9A7kaBfcvEfNiCEA1rw0gobA9nKnS506O1HgAAQUIClcJetp6l/Tw
         79HrLynviB/7/Y/vJB6JxH6OlaHkCN5A6HbtrjloVNQnszZCag48wMbkAxGuFXBdvjTb
         mfLxchzFojdrWlWr05IKuizClNoXsP/5fJJAxcto9wfzsuth88TmCen6rq23vvRKOMWw
         NeCg==
X-Gm-Message-State: AOAM533Ain2435TLGYFHcyjNuzv2PWt2pboPWenvF8pHBjtNUD5beu5i
        pbwma602nMTdnuu8wOA/NUciU/kT7pQ=
X-Google-Smtp-Source: ABdhPJzRxFJh5kMK+j5klpIKR50QifbYdGTWz6/104SUlMn5MLebth9HJ3j5Q4yoeCN71TH/Be22kw==
X-Received: by 2002:a19:e46:: with SMTP id 67mr3959180lfo.108.1606495291010;
        Fri, 27 Nov 2020 08:41:31 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 4sm1012291ljf.96.2020.11.27.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:41:30 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 27 Nov 2020 17:41:28 +0100
To:     Daniel Axtens <dja@axtens.net>
Cc:     rcu@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc 5.10-rcN boot failures with RCU_SCALE_TEST=m
Message-ID: <20201127164128.GA47008@pc638.lan>
References: <87eekfh80a.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eekfh80a.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> Hi all,
> 
> I'm having some difficulty tracking down a bug.
> 
> Some configurations of the powerpc kernel since somewhere in the 5.10
> merge window fail to boot on some ppc64 systems. They hang while trying
> to bring up SMP. It seems to depend on the RCU_SCALE/PERF_TEST option.
> (It was renamed in the 5.10 merge window.)
> 
> I can reproduce it as follows with qemu tcg:
> 
> make -j64 pseries_le_defconfig
> scripts/config -m RCU_SCALE_TEST
> scripts/config -m RCU_PERF_TEST
> make -j 64 vmlinux CC="ccache gcc"
> 
> qemu-system-ppc64 -cpu power9 -M pseries -m 1G -nographic -vga none -smp 4 -kernel vmlinux
> 
> ...
> [    0.036284][    T0] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes, linear)
> [    0.036481][    T0] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes, linear)
> [    0.148168][    T1] POWER9 performance monitor hardware support registered
> [    0.151118][    T1] rcu: Hierarchical SRCU implementation.
> [    0.186660][    T1] smp: Bringing up secondary CPUs ...
> <hangs>
>
I am not sure if that is helpful but i checked it on my x86_64 system
using the cross compiled for powerpc Linux kernel:

<snip>
urezki@pc638:~/data/coding/linux-rcu.git$ powerpc64-linux-gnu-gcc
--version
powerpc64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

urezki@pc638:~/data/coding/linux-rcu.git$
<snip>

with ARCH=powerpc make -j64 pseries_defconfig configuration. I used the 5.10.0-rc1 kernel.

<snip>
urezki@pc638:~/data/coding/linux-rcu.git$ qemu-system-ppc64 --version
QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-8+deb10u8)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
urezki@pc638:~/data/coding/linux-rcu.git$
<snip>

On my setup i can run the kernel with and without the modules which are
in question. So

qemu-system-ppc64 -cpu power9 -M pseries -m 1G -nographic -vga none -smp 4 -kernel ./vmlinux

works for both cases, with RCU_SCALE and without.

Just in case, maybe this information can be useful also.

--
Vlad Rezki
