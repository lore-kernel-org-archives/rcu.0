Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CCC63798
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 02:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABE82075A
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 02:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="KVXsCq7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392117AbgK0CCe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 Nov 2020 21:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392109AbgK0CCe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 Nov 2020 21:02:34 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF0C0613D4
        for <rcu@vger.kernel.org>; Thu, 26 Nov 2020 18:02:34 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id k11so3071102pgq.2
        for <rcu@vger.kernel.org>; Thu, 26 Nov 2020 18:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:date:message-id:mime-version;
        bh=kLRSiy0jW2k3T4Timgh74JclLsE8e709GGZ1X6Muygw=;
        b=KVXsCq7AbKDIGOfkPdNpAOiVoDAVuaCyIE1c4g9h3IZnuOBTU244SyyVExs3sPsPDL
         sedtdFGnLZuMgIt2LimDe2eDjQCvsnhhwvVyaG8I/a9Xua/D2wMLNNYgRl8STMgmA0s/
         i1J89qGS1s6Rbtf46aN0m0iPIrFXBHV6iiWYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=kLRSiy0jW2k3T4Timgh74JclLsE8e709GGZ1X6Muygw=;
        b=i+iwdT+9hWmKAou+45yq1FevKknSBVpyAbqtWGF415d0jW+/mqEfMTaWuvmnmCfcRj
         4KjshBs1/7zeYpiNPb4bw41CGrprzsUWRTsBBljI3Id70Ee4poObIwsVEJ7tA2PSA0wT
         ObR/MQZJEARmclnNLkRo95pS/W27vr314i47uelLT7EbgVYp3fP8FtttgI95iLpXAPLh
         PHktLuxc4OjQxaUGtGp1iQVKdgoSz4HUmEUWJ5E2t7lrB+Fz4kPeobTygwRG3CAJXoKz
         G3/v4Gvy/l2eH8E7+ISfkEbHqXGYQ5ILuS35b25Hiz+71GIGV+ruTKbv8UDVbaozqev6
         +FiA==
X-Gm-Message-State: AOAM532kKzqbk9MitzrFntNNDxoomDp4thykkCHIrqMs+hRtSSkBamts
        Pqs1FyM+iZsPj1ovIG9FPBkme2SxJFJH4A==
X-Google-Smtp-Source: ABdhPJzhXog8Ats0AhlIXNoSzCkWhbDuGymnfKdZ7SqnfIOKimnM/wqXIV6Ye9N1PBdd/pFtpOEW0g==
X-Received: by 2002:a17:90a:4405:: with SMTP id s5mr6813487pjg.219.1606442553908;
        Thu, 26 Nov 2020 18:02:33 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-f892-9c2d-d399-9d41.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:f892:9c2d:d399:9d41])
        by smtp.gmail.com with ESMTPSA id ge21sm7733180pjb.5.2020.11.26.18.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 18:02:33 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     rcu@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: powerpc 5.10-rcN boot failures with RCU_SCALE_TEST=m
Date:   Fri, 27 Nov 2020 13:02:29 +1100
Message-ID: <87eekfh80a.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi all,

I'm having some difficulty tracking down a bug.

Some configurations of the powerpc kernel since somewhere in the 5.10
merge window fail to boot on some ppc64 systems. They hang while trying
to bring up SMP. It seems to depend on the RCU_SCALE/PERF_TEST option.
(It was renamed in the 5.10 merge window.)

I can reproduce it as follows with qemu tcg:

make -j64 pseries_le_defconfig
scripts/config -m RCU_SCALE_TEST
scripts/config -m RCU_PERF_TEST
make -j 64 vmlinux CC="ccache gcc"

qemu-system-ppc64 -cpu power9 -M pseries -m 1G -nographic -vga none -smp 4 -kernel vmlinux

...
[    0.036284][    T0] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes, linear)
[    0.036481][    T0] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes, linear)
[    0.148168][    T1] POWER9 performance monitor hardware support registered
[    0.151118][    T1] rcu: Hierarchical SRCU implementation.
[    0.186660][    T1] smp: Bringing up secondary CPUs ...
<hangs>

I have no idea why RCU_SCALE/PERF_TEST would be causing this, but that
seems to be what does it: if I don't set that, the kernel boots fine.

I've tried to git bisect it, but I keep getting different results:
always a random merge of a seemingly-unrelated subsystem tree - things
like armsoc or integrity or input.

It appears to also depend on the way the kernel is booted. Testing with
a Canonical kernel, so a slightly different config but including
RCU_SCALE_TEST=m, I see:

Power8 host + KVM + grub         -> boots
Power9 host bare metal (kexec)   -> fails
Power9 host + KVM + grub         -> fails
Power9 host + KVM + qemu -kernel -> boots
qemu TCG + power9 cpu            -> fails
qemu TCG + power8 cpu            -> fails

Any ideas?

Kind regards,
Daniel

$ qemu-system-ppc64 -version
QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.9)

$ gcc --version
gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0

It also happens when compiling with GCC 7 and 10.


