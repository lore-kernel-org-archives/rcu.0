Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C88DC433EF
	for <rcu@archiver.kernel.org>; Wed,  6 Apr 2022 13:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiDFNEJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiDFNDo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Apr 2022 09:03:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1FE2EC511
        for <rcu@vger.kernel.org>; Wed,  6 Apr 2022 02:31:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l26so3053458ejx.1
        for <rcu@vger.kernel.org>; Wed, 06 Apr 2022 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FI+EACkCTDn0l2CnSWYFgxS84Koe1S8eDRxILRKVO+w=;
        b=QUqYwudkm5hdLASSInYwknK32f48QP5wrARDQ0sfAKPa4GRifQ1IsWNHCEA6CUFdho
         mzxcQfPOyjJNtAEbp4nei8JQU05coMPHffudcBxYyAUNxt5L85Z6OcG7ALOk52Y8paRa
         IbYARhO7kcfEiZih9ggf2DKd/RRqSUrDYJ/IDN/iYcUe9JxBiE8W8YJ34g7MBNXk1E2f
         EVt1GGnMFv1KcmCQcoiGG5Hs4Hvftv8MWd00VyOZ9Gwf8BwrbTM+bcUE7547DUmb9k52
         PZO61kSd5UgxSUuq51I/Nul2Kx5zdoD+QSzHPZYLRXM9qZHlY0JRLrWKmTkvXvIETT/E
         f/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FI+EACkCTDn0l2CnSWYFgxS84Koe1S8eDRxILRKVO+w=;
        b=fPMcMo6rAHMz5UQvfncS+tOvEvJdU9lxf/HEsW1qwlMpSJEz2exgYJ2o7Q7qe+4Xiz
         uxcf7tkSir2A6Jl8xIJaj3DjGt6l9Yh3nsi/cSMCtMECXqBeJcSSMpwbTGICIDHJywct
         szrB8y0wlJ/KkQqIzuftN0CQdxxheU/pMar5WzMr+oVemO0VbD7lr2bI1PsV7ZgePjRv
         44PHDRMS+Wyym6RxvTqet00i3uinOCsvXlJm+p7lF92a65i4CUvuCJm6NbKvldVXnhYr
         qOGlLyBkph/Ctk/l/idPe+44yN3G6O9Ai4AIW8CL9Jr9BaYV8LVZ243s+NS3lyL08O0X
         diTw==
X-Gm-Message-State: AOAM532hDR2j536AvrDcXgsllWLqx2oIrPacZxafp4HTo8X/Jvvhv3O3
        nXzjTnrYlT1vjS4wGdsDtZetFW0d5mLrc+Mqv3PZnJRO9Os=
X-Google-Smtp-Source: ABdhPJw8KQFjuLQmdXLOWEa2QDdz165o3Fngnj3VRfnJc7mZFia9owQqLuL5XH1JB37XLCcEbR4lIpRCuKC2KmxQ4x8=
X-Received: by 2002:a17:907:6d07:b0:6e7:979e:9c0a with SMTP id
 sa7-20020a1709076d0700b006e7979e9c0amr7295488ejc.614.1649237481267; Wed, 06
 Apr 2022 02:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
In-Reply-To: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 6 Apr 2022 17:31:10 +0800
Message-ID: <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi

I can reproduce it in a ppc virtual cloud server provided by Oregon
State University.  Following is what I do:
1) curl -l https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.18-rc1.tar.gz
-o linux-5.18-rc1.tar.gz
2) tar zxf linux-5.18-rc1.tar.gz
3) cp config linux-5.18-rc1/.config
4) cd linux-5.18-rc1
5) make vmlinux -j 8
6) qemu-system-ppc64 -kernel vmlinux -nographic -vga none -no-reboot
-smp 2 (QEMU 4.2.1)
7) after 12 rounds, the bug got reproduced:
(http://154.223.142.244/logs/20220406/qemu.log.txt)

Cheers ;-)
Zhouyi

On Wed, Apr 6, 2022 at 3:47 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi PPC/RCU,
>
> While merging v5.18-rc1 changes I noticed our CI PPC runs broke. I
> reproduced the problem in v5.18-rc1 as well as next-20220405, under
> both QEMU 4.2.1 and 6.1.0, with `-smp 2`; but I cannot reproduce it in
> v5.17 from a few tries.
>
> Sadly, the problem is not deterministic although it is not too hard to
> reproduce (1 out of 5?). Please see attached config and QEMU output.
>
> Cheers,
> Miguel
