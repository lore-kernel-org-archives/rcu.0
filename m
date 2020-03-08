Return-Path: <SRS0=4vwy=4Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CD9C10DCE
	for <rcu@archiver.kernel.org>; Sun,  8 Mar 2020 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9A2083E
	for <rcu@archiver.kernel.org>; Sun,  8 Mar 2020 21:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7Y4SU6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgCHVSa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:18:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52852 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgCHVSa (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 8 Mar 2020 17:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583702309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDFf6JJJ7oL8PZR807yO8QrfcQ0rQRkQyjpFnIU1DFg=;
        b=N7Y4SU6TTV8wgHWdurdsE+wlglddl5k2OF4Ohm2SJQpsn63MZiaRVgunGLH+lk9Kv60Nah
        aSj5wvZGSDyRXihHKIJCj4ldtW5Bfz6S1wKV5wpb/X0KOOd7LYg2/52Z8QxUg/H4tVFilJ
        /RZSymNhiKN3vHArIH3a8CZXWlhj4s4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-j7H4v-dmMfS0qUjk-mtQVg-1; Sun, 08 Mar 2020 17:18:25 -0400
X-MC-Unique: j7H4v-dmMfS0qUjk-mtQVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8DDE1005509;
        Sun,  8 Mar 2020 21:18:23 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-251.rdu2.redhat.com [10.10.120.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB9A15D9C5;
        Sun,  8 Mar 2020 21:18:21 +0000 (UTC)
Subject: Re: Hard lockups due to "tick/common: Make tick_periodic() check for
 missing ticks"
To:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw>
 <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <68ef67a1-306f-ee87-14c8-14f8863a67a1@redhat.com>
Date:   Sun, 8 Mar 2020 17:18:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 3/6/20 10:33 PM, Qian Cai wrote:
>
>> On Mar 5, 2020, at 11:06 PM, Qian Cai <cai@lca.pw> wrote:
>>
> Using this config,
>
>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> Reverted the linux-next commit d441dceb5dce (=E2=80=9Ctick/common: Make=
 tick_periodic() check for missing ticks=E2=80=9D)
> fixed the lockup that could easily happen during boot.
>
I will take a look at that and get back to you ASAP.

Thanks,
Longman

