Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A192C433F5
	for <rcu@archiver.kernel.org>; Fri, 11 Feb 2022 15:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiBKPmt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:42:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbiBKPms (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 11 Feb 2022 10:42:48 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D5F4
        for <rcu@vger.kernel.org>; Fri, 11 Feb 2022 07:42:46 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebe1.dynamic.kabel-deutschland.de [95.90.235.225])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9531461E6478B;
        Fri, 11 Feb 2022 16:42:44 +0100 (CET)
Message-ID: <b3f392b1-5418-c64b-502b-f0637df13f86@molgen.mpg.de>
Date:   Fri, 11 Feb 2022 16:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: =?UTF-8?Q?Re=3a_rcutorture=e2=80=99s_init_segfaults_in_ppc64le_VM?=
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, rcu@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>, Zhouyi Zhou <zhouzhouyi@gmail.com>
References: <565038d7-7374-1005-31bf-df2f051845ff@molgen.mpg.de>
 <871r0dmzzm.fsf@mpe.ellerman.id.au>
 <e7498a9d-7420-ff52-99e4-8194f3d177f0@molgen.mpg.de>
 <87y22irx5k.fsf@mpe.ellerman.id.au>
 <6ae23d59-fe88-6f14-7d9f-648afa3dc298@molgen.mpg.de>
In-Reply-To: <6ae23d59-fe88-6f14-7d9f-648afa3dc298@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Michael,


Am 11.02.22 um 15:19 schrieb Paul Menzel:

> Am 11.02.22 um 02:48 schrieb Michael Ellerman:
>> Paul Menzel writes:
>>> Am 08.02.22 um 11:09 schrieb Michael Ellerman:
>>>> Paul Menzel writes:
>>>
>>> […]
>>>
>>>>> On the POWER8 server IBM S822LC running Ubuntu 21.10, building Linux
>>>>> 5.17-rc2+ with rcutorture tests
>>>>
>>>> I'm not sure if that's the host kernel version or the version you're
>>>> using of rcutorture? Can you tell us the sha1 of your host kernel 
>>>> and of the tree you're running rcutorture from?
>>>
>>> The host system runs Linux 5.17-rc1+ started with kexec. Unfortunately,
>>> I am unable to find the exact sha1.
>>>
>>>       $ more /proc/version
>>>       Linux version 5.17.0-rc1+ (x@eddb.molgen.mpg.de) (Ubuntu clang version 13.0.0-2, LLD 13.0.0) #1 SMP Fri Jan 28 17:13:04 CET 2022
>>
>> OK. In general rc1 kernels can have issues, so it might be worth
>> rebooting the host into either v5.17-rc3 or a distro or stable kernel.
>> Just to rule out any issues on the host.
> 
> Yes, that was a good test. It works with Ubuntu’s 5.13 Linux kernel.
> 
>      $ more /proc/version
>      Linux version 5.13.0-28-generic (buildd@bos02-ppc64el-013) (gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.37) #31-Ubuntu SMP Thu Jan 13 17:40:19 UTC 2022
> 
> I have to do more tests, but it could be LLVM/clang related.

Building commit f1baf68e1383 (Merge tag 'net-5.17-rc4' of 
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net) with the ata 
patches on top with GCC, I am unable to reproduce the issue. Before I 
built it with

     make -j100 LLVM=1 LLVM_IAS=0 bindeb-pkg

[…]


Kind regards,

Paul
