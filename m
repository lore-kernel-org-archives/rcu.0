Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29BBC4332F
	for <rcu@archiver.kernel.org>; Thu, 22 Dec 2022 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLVNLj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Dec 2022 08:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiLVNLi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Dec 2022 08:11:38 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6800913F3F
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 05:11:36 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id t191so904943vkb.4
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCUn/IqodYjF4eJCSdZgUCQTZHF1JXARNK7LmC9YXxY=;
        b=WgBohoc88b7UWZqydyAU2tvoFt9SFOD2jwLZv2mgUTfeOkD1E2ygzwQADqK3/2fGdz
         wcg3r41G/I60eJc781T3YgIr9hKICw9vBPW+LkRCCYFWnQKtQaPQDkWbmpJHvbWRhlfn
         KYXB13l5uAlZdz0oQeriFWLFKatpTleumjV/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCUn/IqodYjF4eJCSdZgUCQTZHF1JXARNK7LmC9YXxY=;
        b=cWc/0JD5P13ng9+j3jQ9+matKeRWR1gwfmN6N1fKzkW5x69DyWIHJEuk1Wj8bO/+RR
         7x4xh3LGTN4sgtd9KjpHYS0J3GFBH6OvO/gTxevNWvMG7vJoRzb4KXVn7ZM281MtbuJr
         ufAqlUuJ06AfpaaAsxSHN6XUIY2RFb5VJM6bqulVZ9I0Rn0o4dj81DJrawQq9Bg2Q4aT
         tDKWJJP+5iem7neLwZhorMTvAhiitmy16Lvzb1q2geeUbiWMfllyLRfih5LJ6M8zQDtY
         wpUhJlnwNF7092nCnHS4O/++8iguzb68ZGx0kvctGpQAwnnoxMzS7Av0590im5za9jrS
         TZ4A==
X-Gm-Message-State: AFqh2krih9uQsA0JYrVGs+CyuqLymbvNExkILAWLcikfze/KJ2Y0vcRW
        40pvJryQgRFzH6I79tWgQ9X45EVpSBy+LMbdxqQ=
X-Google-Smtp-Source: AMrXdXvlLjrfo9m3rzIdof6cpbb8UJlFAuU9tGu31PoXRKQaQDaly7IwKBWPj8t5jP5NirC1yDNoTQ==
X-Received: by 2002:a05:6122:178e:b0:3b8:6aad:b84a with SMTP id o14-20020a056122178e00b003b86aadb84amr2274188vkf.1.1671714694712;
        Thu, 22 Dec 2022 05:11:34 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id q29-20020a37f71d000000b006fb9bbb071fsm266982qkj.29.2022.12.22.05.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 05:11:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: NULL pointer issue in rcu_do_batch()
Date:   Thu, 22 Dec 2022 08:11:23 -0500
Message-Id: <459A73FF-7095-4D5D-9D2A-D90BDAD27AF0@joelfernandes.org>
References: <0fc6b3b3-465b-0b64-fbdf-c80db18a9f88@quicinc.com>
Cc:     rcu@vger.kernel.org
In-Reply-To: <0fc6b3b3-465b-0b64-fbdf-c80db18a9f88@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 22, 2022, at 6:34 AM, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>=20
> =EF=BB=BFHi All,
>=20
> We are observing NULL pointer dereference issue in rcu_do_batch() in 5.15,=
 although it is very hard to hit.
>=20
> Wanted to check if it is been reported and fixed in recent kernel ?

What is the test case? I have not seen such corruption. Is it possible for y=
ou to run with CONFIG_PROVE_RCU?

This looks like an Android kernel, I can tell by looking at VendorHooks in t=
he log. So with all that GKI stuff, are we sure that is not causing some unf=
oreseen side effect ?

Thanks,

 - Joel


> <1>[16.814014] [pid:    58] Unable to handle kernel NULL pointer dereferen=
ce at virtual address 0000000000000000
> <0>[16.814027] [pid:    58] PC Code: bad value
> <0>[16.814034] [pid:    58] LR Code: f81e03a8 b5000068 d10083a8 f81e83a8 a=
a1f03f6 91127319 d10083b7 f9434b68 d503201f f9400408 910006d6 f900041f d63f0=
100 (91004308) b8bfc108 374001c8 97ffff2b 9111e308 38bfc108 72001d1f
>=20
> <4>[16.814359] [pid:    58] CPU: 7 PID: 58 Comm: rcuop/5 Tainted: G S   W =
 OE     5.15.41-android13-8-25574579-abS911USQU1AVLL #1
> <4>[16.814361] [pid:    58] Hardware name: XXXXX
> <4>[16.814362] [pid:    58] pstate: 42400805 (nZcv daif +PAN -UAO +TCO -DI=
T -SSBS BTYPE=3D-c)
> <4>[16.814364] [pid:    58] pc : 0x0
> <4>[16.814365] [pid:    58] lr : rcu_do_batch+0x328/0xcd8
>=20
>=20
> rcu_data for CPU5 contains additional 12 RCU callback heads in the segment=
 of RCU_DONE_TAIL whose func is NULL. It doesn=E2=80=99t seem to be a random=
 memory corruption since only rhp->func is set to null across multiple objec=
ts.
>=20
> There is one more occurrence with CONFIG_CFI_CLANG enabled.
>=20
> [123587.101222][   T44] Kernel panic - not syncing: CFI failure (target: 0=
x0)
> [123587.101249][   T44] CPU: 0 PID: 44 Comm: rcuop/3 Tainted: G S WC OE   =
  5.15.41 #1
> [123587.101263][   T44] Hardware name: XXXXX
> [123587.101274][   T44] Call trace:
> [123587.101283][   T44]  dump_backtrace.cfi_jt+0x0/0x8
> [123587.101298][   T44]  show_stack+0x1c/0x2c
> [123587.101311][   T44]  dump_stack_lvl+0x94/0x100
> [123587.101326][   T44]  panic+0x17c/0x450
> [123587.101338][   T44]  find_check_fn+0x0/0x210
> [123587.101349][   T44]  rcu_do_batch+0x368/0x6f8
> [123587.101362][   T44]  nocb_cb_wait+0x80/0x450
> [123587.101374][   T44]  rcu_nocb_cb_kthread+0x54/0x90
> [123587.101386][   T44]  kthread+0x174/0x1d8
> [123587.101398][   T44]  ret_from_fork+0x10/0x20
> [123587.101410][   T44] SMP: stopping secondary CPUs
> [123587.101670][    C4] VendorHooks: CPU4: stopping
>=20
> -Mukesh
