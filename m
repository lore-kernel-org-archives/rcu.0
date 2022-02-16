Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820CCC433F5
	for <rcu@archiver.kernel.org>; Wed, 16 Feb 2022 09:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiBPJHK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:07:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiBPJHJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Feb 2022 04:07:09 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F81A819
        for <rcu@vger.kernel.org>; Wed, 16 Feb 2022 01:06:56 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebad.dynamic.kabel-deutschland.de [95.90.235.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 246D961EA1923;
        Wed, 16 Feb 2022 10:06:53 +0100 (CET)
Message-ID: <18aacdf8-cd6e-81e3-70bc-479336221b68@molgen.mpg.de>
Date:   Wed, 16 Feb 2022 10:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     rcu@vger.kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: rcutorture: Question about `specify_qemu_cpus()` and
 qemu-system-ppc64
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Linux folks,


`tools/testing/selftests/rcutorture/bin/functions.sh` contains:

```
# specify_qemu_cpus qemu-cmd qemu-args #cpus
#
# Appends a string containing "-smp XXX" to qemu-args, unless the incoming
# qemu-args already contains "-smp".
specify_qemu_cpus () {
         local nt;

         if echo $2 | grep -q -e -smp
         then
                 echo $2
         else
                 case "$1" in
                 qemu-system-x86_64|qemu-system-i386|qemu-system-aarch64)
                         echo $2 -smp $3
                         ;;
                 qemu-system-ppc64)
                         nt="`lscpu | grep '^NUMA node0' | sed -e 
's/^[^,]*,\([0-9]*\),.*$/\1/'`"
                         echo $2 -smp cores=`expr \( $3 + $nt - 1 \) / 
$nt`,threads=$nt
                         ;;
                 esac
         fi
}
```

`lscpu` collapses(?) if all numbers are consecutive:

     $ lscpu | grep '^NUMA node0'
     NUMA node0 CPU(s):               0-79

Currently, the second number is taken to find out the number of threads. 
`lscpu` contains a separate line containing the thread number though:

     $ lscpu | grep 'Thread'
     Thread(s) per core:              8

Could that be used instead?


Kind regards,

Paul


PS: Out of curiosity, what is `expr \( $3 + $nt - 1 \) / $nt` supposed 
to do? $3 contains the arguments of CPU number. If that should be the 
number of (total) threads, then it rounds it up?
