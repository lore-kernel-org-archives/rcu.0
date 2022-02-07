Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A35C433F5
	for <rcu@archiver.kernel.org>; Mon,  7 Feb 2022 17:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiBGREF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbiBGQxI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Feb 2022 11:53:08 -0500
X-Greylist: delayed 498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 08:53:07 PST
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6521EC0401D1
        for <rcu@vger.kernel.org>; Mon,  7 Feb 2022 08:53:07 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee58.dynamic.kabel-deutschland.de [95.90.238.88])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D39A661EA1924;
        Mon,  7 Feb 2022 17:53:05 +0100 (CET)
Message-ID: <36ffe02f-b299-2085-108a-5a4551e620fb@molgen.mpg.de>
Date:   Mon, 7 Feb 2022 17:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     rcu@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: ppc64le: rcutorture warns about improperly set
 `CONFIG_HYPERVISOR_GUEST` and `CONFIG_PARAVIRT`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Sebastian, dear Paul,


In commit a6fda6dab9 (rcutorture: Tweak kvm options) 
`tools/testing/selftests/rcutorture/configs/rcu/CFcommon` was extended 
by the three selections below:

     CONFIG_HYPERVISOR_GUEST=y
     CONFIG_PARAVIRT=y
     CONFIG_KVM_GUEST=y

Unfortunately, `CONFIG_HYPERVISOR_GUEST` is x86 specific and 
`CONFIG_PARAVIRT` only available on x86 and ARM.

Thus, running the tests on a ppc64le system (POWER8 IBM S822LC), the 
script shows the warnings below:

     :CONFIG_HYPERVISOR_GUEST=y: improperly set
     :CONFIG_PARAVIRT=y: improperly set

Do you have a way, how to work around that?


Kind regards,

Paul
