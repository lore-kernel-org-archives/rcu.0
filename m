Return-Path: <SRS0=Stsp=2X=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC96AC2D0DD
	for <rcu@archiver.kernel.org>; Thu,  2 Jan 2020 07:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9E21734
	for <rcu@archiver.kernel.org>; Thu,  2 Jan 2020 07:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5FCHCPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgABHz6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:55:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33903 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgABHz5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jan 2020 02:55:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so21186113lfc.1
        for <rcu@vger.kernel.org>; Wed, 01 Jan 2020 23:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eGohEk6S6aS69bKKZtdPwikjBlLgnLVNXqA4xcC4Kho=;
        b=w5FCHCPcoy7So8XJA9xIRexZGLLWbE/hk5imTz9sah34ckqci+zpYnZqWeC+TQW+ZP
         0zD5fYB6jyusZl2JflmxXTmq4UGSYONrwfkNhO5zzcRD4xgR5Y5Tmb4SZmHuy6fPVlwH
         226p43eMEapBGGnlGdMQMcTbcQ62SjQLeYen08k2cegDF3UKo9fkUTPjKJ5Y7r3FpLVp
         OuaeWmVkT9FaAZQyT7dQxDpijNlTlYh/wvRc1nE486CWvie96fTD1mtS4YZmMRdnrBwn
         D3Ytvxwxb3dmBcXCvdpUzgXX6K9BmcuCwDuPHUplHOE9MErG9Uxgyt7RWOn8Y3t4Fet/
         lYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eGohEk6S6aS69bKKZtdPwikjBlLgnLVNXqA4xcC4Kho=;
        b=fUsyf45sWpSrM43FpbPptchtosEIOizfKfXCaFQNHkpVeWl8078JVGD43vlrzlw1CY
         i7TwYpXeqNVHDWI43v6qSI+Pr6NpjHD6OYF7XYRWNWroj5pTQoTsrQrzqlhxCIwq2uOt
         eWEaZHEgUEfXJaaSRXVwQZFQyAkJGLuqBKUztMXDliZIM/D+BGLyo5MPQ9YD3ofOqstG
         iJwXztJ0FiP8s3URVN2cK25+seLenNOVLwF63NQw6gimivc8MGdXU8QqJqzAuL+xHruP
         uz9hHA18XzgtZDaPtT5+kHajWwrWFUSyw7zoZwa0ju/VQ6TuqMDJ/eG7+ECtkzH8HAoe
         JgYQ==
X-Gm-Message-State: APjAAAVsxpwJqYDs0IDCT5UJazyshM9Z+ER9QRcOKXoQRbFiXZ7Kpn/Y
        wUF7CxbR0CssqjoYD744ap75UDJKbzl3tzsiSQeIXQ==
X-Google-Smtp-Source: APXvYqyjCkSGCjGJ9B28da0wZQwDRT9CO/xuV+W8Khgy8GH2aJkxDx6Qv0HJANMb32fem+zQhK9aA2k6fU2SmCETnWc=
X-Received: by 2002:ac2:4a91:: with SMTP id l17mr47045202lfp.75.1577951755636;
 Wed, 01 Jan 2020 23:55:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYv3=oJSFodFp4wwF7G7_g5FWYRYbc4F0AMU6jyfLT689A@mail.gmail.com>
In-Reply-To: <CA+G9fYv3=oJSFodFp4wwF7G7_g5FWYRYbc4F0AMU6jyfLT689A@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Jan 2020 13:25:44 +0530
Message-ID: <CA+G9fYvPWFtA77k=yx46FRd2wGW+_SMtzgZtYQFgkzmwPhNhdw@mail.gmail.com>
Subject: Re: stable-rc-4.19.93-rc1/4e040169e8b7 : kernel panic RIP: 0010:__inet_lookup_listener
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Firo Yang <firo.yang@suse.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        rcu@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 2 Jan 2020 at 12:24, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
>
> Results from Linaro=E2=80=99s test farm.
> Regressions on arm64, arm, x86_64, and i386.
>
> While running LTP syscalls accept* test cases on stable-rc-4.19 branch ke=
rnel.
> This report log extracted from qemu_x86_64.
>
> metadata:
>   git branch: linux-4.19.y
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git
>   git commit: 4e040169e8b7f4e1c50ceb0f6596015ecc67a052
>   git describe: v4.19.92-112-g4e040169e8b7
>   make_kernelversion: 4.19.93-rc1
>   kernel-config:
> http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/l=
kft/linux-stable-rc-4.19/396/config
>
> Crash log,
>
> BUG: unable to handle kernel paging request at 0000000040000001
> [   23.578222] PGD 138f25067 P4D 138f25067 PUD 0
> er run is 0h 15m[   23.578222] Oops: 0000 [#1] SMP NOPTI
> [   23.578222] CPU: 1 PID: 2216 Comm: accept02 Not tainted 4.19.93-rc1 #1
> [   23.578222] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [   23.578222] RIP: 0010:__inet_lookup_listener+0x12d/0x300

Reverting below patch solve this kernel panic,

tcp/dccp: fix possible race __inet_lookup_established()
[ Upstream commit 8dbd76e79a16b45b2ccb01d2f2e08dbf64e71e40 ]

Michal Kubecek and Firo Yang did a very nice analysis of crashes
happening in __inet_lookup_established().

Since a TCP socket can go from TCP_ESTABLISH to TCP_LISTEN
(via a close()/socket()/listen() cycle) without a RCU grace period,
I should not have changed listeners linkage in their hash table.

They must use the nulls protocol (Documentation/RCU/rculist_nulls.txt),
so that a lookup can detect a socket in a hash list was moved in
another one.

Since we added code in commit d296ba60d8e2 ("soreuseport: Resolve
merge conflict for v4/v6 ordering fix"), we have to add
hlist_nulls_add_tail_rcu() helper.

Fixes: 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under synfl=
ood")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Reported-by: Firo Yang <firo.yang@suse.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Link: https://lore.kernel.org/netdev/20191120083919.GH27852@unicorn.suse.cz=
/
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
