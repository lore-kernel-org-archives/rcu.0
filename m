Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE940C4332E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D32072C
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wuji1qBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCSTAq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:00:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54281 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbgCSTAq (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 19 Mar 2020 15:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584644444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1t0CDXQGrkOTO7FpbdWrJYK+C3q0cC+jstTgkRHjIMg=;
        b=Wuji1qBoLapCm81NjNW3KKqXvE/fufBXdh+ZbEsujjgH5gAhfLN67J/N6rQWMALR4Jrd10
        UA2DxylbSMhoVeY8ILJJeAW59PL1VYfuQOjzhGE9pvrAhEm8rqwUmmLpetQbMIW9T1V4Iq
        O1mne7bhLuvdXEXG72/R4miYkt0kBMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-OD2bujDXMLe31JPoO6ISew-1; Thu, 19 Mar 2020 15:00:40 -0400
X-MC-Unique: OD2bujDXMLe31JPoO6ISew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E6D218FE868;
        Thu, 19 Mar 2020 19:00:38 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-139.rdu2.redhat.com [10.10.113.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE0F6EFAB;
        Thu, 19 Mar 2020 19:00:36 +0000 (UTC)
Subject: Re: Hard lockups due to "tick/common: Make tick_periodic() check for
 missing ticks"
To:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw>
 <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw>
 <11BEA1A5-2E93-4E01-A05C-A6BA73A74CEB@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <218eed57-27c8-12c0-6f5f-111874798c21@redhat.com>
Date:   Thu, 19 Mar 2020 15:00:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <11BEA1A5-2E93-4E01-A05C-A6BA73A74CEB@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 3/19/20 9:58 AM, Qian Cai wrote:
>
>> On Mar 6, 2020, at 10:33 PM, Qian Cai <cai@lca.pw> wrote:
>>
>>
>>
>>> On Mar 5, 2020, at 11:06 PM, Qian Cai <cai@lca.pw> wrote:
>>>
>> Using this config,
>>
>>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
>> Reverted the linux-next commit d441dceb5dce (=E2=80=9Ctick/common: Mak=
e tick_periodic() check for missing ticks=E2=80=9D)
>> fixed the lockup that could easily happen during boot.
>
> Thomas or Stephen, can you back out this patch from linux-next while Wa=
iman is getting to the bottom of it?
> I can still reproduce it as today.

I am fine for reverting the patch for now. I am still having some
trouble reproducing it and I have other tasks to work on right now. I
will get to the bottom of it and resubmit a new patch later on.

Cheers,
Longman

