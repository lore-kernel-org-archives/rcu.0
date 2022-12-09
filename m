Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEACC4332F
	for <rcu@archiver.kernel.org>; Fri,  9 Dec 2022 23:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLIXeO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Dec 2022 18:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLIXeO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Dec 2022 18:34:14 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07596F4A5
        for <rcu@vger.kernel.org>; Fri,  9 Dec 2022 15:34:12 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id a17so4104335qvt.9
        for <rcu@vger.kernel.org>; Fri, 09 Dec 2022 15:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk3eVuxZ4xBc5xFbmOqHD4RqmggIQYBVfFYSAWyqwX0=;
        b=CmrRab3ZcSiDS9w2xAVKvX//Lrzv59uqPW1qVXnNusRLj7+UyZvnhibPzvALcCAWxF
         xkKSctZyoL+E7165blyLJwYsAZauGaGl3sNKK771z64GIBwyxfCcsqE+LDe1vWuHM6Mn
         MUa0YY04Zrp06WNuTL4aeKe03mi9nhVP00V14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk3eVuxZ4xBc5xFbmOqHD4RqmggIQYBVfFYSAWyqwX0=;
        b=uAto+cn4oi+Et+VPG05TKHtYErwgbqiY9f5YSDcqrKy7309/CaM2XhGG2dlTYVBeOv
         BIAYHnLl+FDE/sqLVg++12lPd73ISmyzZjPZVN+asoHOuSWpgqaVM5BfbNFr0Aey8kho
         2fsJ/u+C0tCoM5Yi3sTomq8uE+QNJwVJRU/abx+ViR8wCvlFjDM/1XvGkiqmsF4cKjHV
         DaPhMY5Iznpg0GkWlXeIZqGuLEQ1EKmi596WvDfkBxb60LoDJXBGdwbLhsio55STYUbg
         V4LVdXs5EjRDaIBURsXViOwuUYP5k2+4thWV1wBToSAIcyCMFdiH6xY8SkW38LGl2Dj6
         qaZA==
X-Gm-Message-State: ANoB5pmhFaAUoFJ5hCYJVlKWEZ8mZ+nKaStzSQpMIsTCJb4+CzPms9I+
        x12bXJZx/CffP7+T2R2PANMMiT8Jv8or7ZA6CKA=
X-Google-Smtp-Source: AA0mqf6foItiTgCNSw38Bb9HEJKMIasXmCqgOkIrS9zycled188xix5tcZYPpTK9qYctpksjzWtphA==
X-Received: by 2002:a0c:f7d0:0:b0:4c7:5d34:f38d with SMTP id f16-20020a0cf7d0000000b004c75d34f38dmr11026413qvo.38.1670628851230;
        Fri, 09 Dec 2022 15:34:11 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a249500b006fc9fe67e34sm902754qkn.81.2022.12.09.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 15:34:10 -0800 (PST)
Date:   Fri, 9 Dec 2022 23:34:10 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org, Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org
Subject: [Report] v4.19 TREE03 splat (stable kernel with ChromeOS patches)
Message-ID: <Y5PF8vismgZLzFam@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,

I see this an hour into the run for TREE03 on v4.19:
tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 60

Checking to see if Qiang has any thoughts as I saw him comment about a similar
issue in [1].

[ 3243.844445] ------------[ cut here ]------------^M
[ 3243.847112] WARNING: CPU: 1 PID: 0 at kernel/kthread.c:411 __kthread_bind_mask+0x19/0x60^M
[ 3243.851585] Modules linked in:^M
[ 3243.853295] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.267+ #1^M
[ 3243.856699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014^M
[ 3243.860052] RIP: 0010:__kthread_bind_mask+0x19/0x60^M
[ 3243.861769] Code: 48 89 42 20 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 55 41 54 55 48 89 f5 48 89 d6 53 48 89 fb e8 3c e9 00 00 48 85 c0 75 09 <0f> 0b 5b 5d 41 5c 41 5d c3 4c 8d ab b4 07 00 00 4c 89 ef e8 6f 28^M
[ 3243.867751] RSP: 0000:ffffa54b8014fec0 EFLAGS: 00010246^M
[ 3243.868959] RAX: 0000000000000000 RBX: ffff95555ee3c240 RCX: 0000000000000000^M
[ 3243.870606] RDX: ffff95555f063d80 RSI: 0000000000000246 RDI: 00000000ffffffff^M
[ 3243.872246] RBP: ffffffffb720a010 R08: af82bdcb11f9f4ff R09: 0000000000000000^M
[ 3243.873894] R10: ffffa54b8014fe70 R11: 00000000621ccdc2 R12: 0000000000000000^M
[ 3243.875538] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000^M
[ 3243.877181] FS:  0000000000000000(0000) GS:ffff95555f040000(0000) knlGS:0000000000000000^M
[ 3243.878698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[ 3243.879747] CR2: 0000000000000000 CR3: 000000001300a000 CR4: 00000000000006e0^M
[ 3243.881050] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
[ 3243.882358] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
[ 3243.883660] Call Trace:^M
[ 3243.884925]  kthread_unpark+0x52/0x60^M
[ 3243.885613]  cpuhp_online_idle+0x31/0x50^M
[ 3243.886341]  cpu_startup_entry+0x62/0x70^M
[ 3243.887063]  start_secondary+0x186/0x1b0^M
[ 3243.887783]  secondary_startup_64+0xa4/0xb0^M

[1] https://groups.google.com/g/syzkaller-bugs/c/w_LARy6pxvQ/m/dKjQyHAxAQAJ

thanks,

 - Joel

